import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Append-only provider evidence shared by website orders and POS sales.
/// Unknown JSON fields are retained; credentials and sensitive card fields are
/// removed recursively. No global `code`/`token` substring filtering is used.
Object? redactProviderResponse(Object? value,
    {required String provider, String parent = ''}) {
  if (value is Map) {
    final result = <String, dynamic>{};
    for (final entry in value.entries) {
      final key = entry.key.toString();
      final n = key.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');
      if (const {
        'clientsecret',
        'authorization',
        'proxyauthorization',
        'headers',
        'requestheaders',
        'requestbody',
        'apikey',
        'subscriptionkey',
        'ocpapimsubscriptionkey',
        'starshipitapikey',
        'secretkey',
        'password',
        'accesstoken',
        'refreshtoken',
        'authtoken',
        'pin',
        'pinblock',
        'encryptedpin',
        'pindata',
        'cvv',
        'cvv2',
        'cvc',
        'cvc2',
        'cv2',
        'cardsecuritycode',
        'cardverificationvalue',
        'cardverificationcode',
        'track1',
        'track2',
        'track3',
        'trackdata',
        'track1data',
        'track2data',
        'magstripedata',
        'emvdata',
        'iccdata'
      }.contains(n)) {
        continue;
      }
      if (const {'pan', 'cardnumber', 'primaryaccountnumber'}.contains(n) ||
          (n == 'number' &&
              const {'card', 'carddetails', 'paymentmethoddetails'}
                  .contains(parent))) {
        final suffix =
            RegExp(r'\d{4}$').firstMatch(entry.value.toString().trim());
        result[key] =
            suffix == null ? '****' : '************${suffix.group(0)}';
        continue;
      }
      result[key] =
          redactProviderResponse(entry.value, provider: provider, parent: n);
    }
    return result;
  }
  if (value is List) {
    return value
        .map((v) =>
            redactProviderResponse(v, provider: provider, parent: parent))
        .toList();
  }
  if (value is String) {
    if (provider == 'linkly' &&
        (parent.startsWith('receipt') || parent == 'displaytext')) {
      return value.replaceAllMapped(
          RegExp(r'(?<![0-9])[0-9](?:[ -]?[0-9]){12,18}(?![0-9])'), (match) {
        final digits = match[0]!.replaceAll(RegExp(r'[^0-9]'), '');
        var sum = 0;
        for (var i = 0; i < digits.length; i++) {
          var digit = int.parse(digits[digits.length - 1 - i]);
          if (i.isOdd) {
            digit *= 2;
            if (digit > 9) digit -= 9;
          }
          sum += digit;
        }
        return sum % 10 == 0
            ? '************${digits.substring(digits.length - 4)}'
            : match[0]!;
      });
    }
    if (RegExp(
            r'^(sk|rk)_(live|test)_|^Bearer\s|^Basic\s|^pi_.*_secret_|^seti_.*_secret_')
        .hasMatch(value)) {
      return '[REDACTED]';
    }
  }
  if (value == null || value is String || value is num || value is bool) {
    return value;
  }
  return value.toString();
}

Object? _canonical(Object? value) {
  if (value is Map) {
    return {
      for (final k in value.keys.map((k) => k.toString()).toList()..sort())
        k: _canonical(value[k])
    };
  }
  if (value is List) return value.map(_canonical).toList();
  return value;
}

Map<String, dynamic> providerResponseRecord(
    {required String provider,
    required String operation,
    required Object? response,
    String? operationId,
    DateTime? capturedAt}) {
  final safe = redactProviderResponse(response, provider: provider);
  final identity = jsonEncode(_canonical({
    'provider': provider,
    'operation': operation,
    'operationId': operationId,
    'response': safe
  }));
  return {
    'schemaVersion': 1,
    'id': sha256.convert(utf8.encode(identity)).toString(),
    'provider': provider,
    'operation': operation,
    'operationId': operationId,
    'capturedAt': (capturedAt ?? DateTime.now()).toUtc().toIso8601String(),
    'response': safe
  };
}

/// Same payload/event is idempotent; a changed response for the same session is
/// a new immutable observation. The backend archives before bounding embedded
/// history. POS keeps its journal until the server acknowledges that archive.
void appendProviderResponse(
    Map<String, dynamic> metadata, Map<String, dynamic> record) {
  final records = (metadata['providerResponses'] as List? ?? [])
      .whereType<Map<dynamic, dynamic>>()
      .map((v) => Map<String, dynamic>.from(v))
      .toList();
  if (records.any((r) => r['id'] == record['id'])) return;
  records.add(record);
  metadata['providerResponses'] = records;
}

Map<String, dynamic> mergeProviderMetadata(
    Map<String, dynamic> previous, Map<String, dynamic> incoming) {
  final merged = <String, dynamic>{
    ...previous,
    ...incoming,
    'providerResponses': previous['providerResponses'] ?? <dynamic>[]
  };
  for (final record in (incoming['providerResponses'] as List? ?? [])
      .whereType<Map<dynamic, dynamic>>()) {
    appendProviderResponse(merged, Map<String, dynamic>.from(record));
  }
  return merged;
}
