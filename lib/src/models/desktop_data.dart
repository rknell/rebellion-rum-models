import 'package:mongo_dart/mongo_dart.dart' show ObjectId;

/// The finite desktop migration protocol. It cannot execute database commands,
/// aggregation pipelines, index operations or arbitrary code.
enum DesktopDataOperation {
  find,
  count,
  insert,
  replace,
  update,
  remove,
  findAndModify
}

class DesktopQuery {
  DesktopQuery({
    this.filter = const {},
    this.sort = const {},
    this.fields = const {},
    this.offset = 0,
    this.limit = 500,
    this.includeArchived = false,
  }) {
    if (offset < 0 || offset > 1000000) {
      throw ArgumentError.value(offset, 'offset');
    }
    if (limit < 1 || limit > 1000) throw ArgumentError.value(limit, 'limit');
  }
  final Map<String, dynamic> filter;
  final Map<String, dynamic> sort;
  final Map<String, dynamic> fields;
  final int offset;
  final int limit;
  final bool includeArchived;

  factory DesktopQuery.fromJson(Map<String, dynamic> json) => DesktopQuery(
        filter: _map(DesktopValueCodec.decode(json['filter'] ?? {})),
        sort: _map(json['sort'] ?? {}),
        fields: _map(json['fields'] ?? {}),
        offset: (json['offset'] as num?)?.toInt() ?? 0,
        limit: (json['limit'] as num?)?.toInt() ?? 500,
        includeArchived: json['includeArchived'] == true,
      );
  Map<String, dynamic> toJson() => {
        'filter': DesktopValueCodec.encode(filter),
        'sort': sort,
        'fields': fields,
        'offset': offset,
        'limit': limit,
        'includeArchived': includeArchived,
      };
}

class DesktopDataRequest {
  DesktopDataRequest({
    required this.operation,
    DesktopQuery? query,
    this.document = const {},
    this.upsert = false,
    this.multi = false,
    this.returnNew = false,
  }) : query = query ?? DesktopQuery();
  final DesktopDataOperation operation;
  final DesktopQuery query;
  final Map<String, dynamic> document;
  final bool upsert;
  final bool multi;
  final bool returnNew;

  factory DesktopDataRequest.fromJson(Map<String, dynamic> json) {
    final operations =
        DesktopDataOperation.values.where((op) => op.name == json['operation']);
    if (operations.isEmpty) {
      throw const FormatException('Unsupported desktop operation');
    }
    return DesktopDataRequest(
      operation: operations.single,
      query: DesktopQuery.fromJson(_map(json['query'] ?? {})),
      document: _map(DesktopValueCodec.decode(json['document'] ?? {})),
      upsert: json['upsert'] == true,
      multi: json['multi'] == true,
      returnNew: json['returnNew'] == true,
    );
  }
  Map<String, dynamic> toJson() => {
        'operation': operation.name,
        'query': query.toJson(),
        'document': DesktopValueCodec.encode(document),
        'upsert': upsert,
        'multi': multi,
        'returnNew': returnNew,
      };
}

class DesktopDataResponse {
  const DesktopDataResponse(
      {this.rows = const [], this.result = const {}, this.nextOffset});
  final List<Map<String, dynamic>> rows;
  final Map<String, dynamic> result;
  final int? nextOffset;
  factory DesktopDataResponse.fromJson(Map<String, dynamic> json) =>
      DesktopDataResponse(
        rows: (DesktopValueCodec.decode(json['rows'] ?? []) as List)
            .map(_map)
            .toList(),
        result: _map(DesktopValueCodec.decode(json['result'] ?? {})),
        nextOffset: (json['nextOffset'] as num?)?.toInt(),
      );
  Map<String, dynamic> toJson() => {
        'rows': DesktopValueCodec.encode(rows),
        'result': DesktopValueCodec.encode(result),
        if (nextOffset != null) 'nextOffset': nextOffset,
      };
}

/// Lossless wire values for existing records during the REST migration.
/// Explicit tags prevent date-looking strings from changing their meaning.
class DesktopValueCodec {
  static Object? encode(Object? value) {
    if (value is ObjectId) return {r'$oid': value.oid};
    if (value is DateTime) return {r'$date': value.toUtc().toIso8601String()};
    if (value is Map) {
      return value.map((key, item) => MapEntry('$key', encode(item)));
    }
    if (value is Iterable) return value.map(encode).toList();
    if (value == null || value is String || value is num || value is bool) {
      return value;
    }
    throw FormatException('Unsupported desktop value: ${value.runtimeType}');
  }

  static Object? decode(Object? value) {
    if (value is Map) {
      if (value.length == 1 && value[r'$oid'] is String) {
        return ObjectId.fromHexString(value[r'$oid'] as String);
      }
      if (value.length == 1 && value[r'$date'] is String) {
        return DateTime.parse(value[r'$date'] as String).toUtc();
      }
      return value.map((key, item) => MapEntry('$key', decode(item)));
    }
    if (value is List) return value.map(decode).toList();
    return value;
  }
}

Map<String, dynamic> _map(Object? value) =>
    Map<String, dynamic>.from(value as Map);
