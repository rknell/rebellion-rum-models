import 'package:rebellion_rum_models/src/models/product.dart';

/// Ordered POS keyboard menus, persisted separately from product documents.
/// Missing catalogue configuration means an older server; an empty groups list
/// means the operator explicitly removed all groups and must not be reseeded.
class PosShortcutConfiguration {
  PosShortcutConfiguration(
      {required this.revision, required List<PosShortcutGroup> groups})
      : groups = List.unmodifiable(groups) {
    if (revision < 0) {
      throw const FormatException('revision must be non-negative');
    }
    if (groups.length > 36) {
      throw const FormatException('At most 36 shortcut groups are supported');
    }
    final ids = <String>{};
    final keys = <String>{};
    for (final group in groups) {
      if (!ids.add(group.id)) {
        throw FormatException('Duplicate group id: ${group.id}');
      }
      if (group.enabled && !keys.add(group.key)) {
        throw FormatException(
            'Duplicate group key: ${group.key.toUpperCase()}');
      }
    }
  }
  final int revision;
  final List<PosShortcutGroup> groups;
  factory PosShortcutConfiguration.fromJson(Map<String, dynamic> json) {
    final revision = json['revision'];
    if (revision is! int || revision < 0) {
      throw const FormatException('revision must be a non-negative integer');
    }
    return PosShortcutConfiguration(
        revision: revision,
        groups: _objects(json['groups'], 'groups')
            .map(PosShortcutGroup.fromJson)
            .toList());
  }
  Map<String, dynamic> toJson() =>
      {'revision': revision, 'groups': groups.map((g) => g.toJson()).toList()};

  void validateProducts(Iterable<ProductModel> products) {
    final active = {
      for (final p in products)
        if (!p.isArchived) p.id.oid: p
    };
    for (final group in groups.where((g) => g.enabled)) {
      for (final product in active.values) {
        if (product.shortcut?.trim().toLowerCase() == group.key) {
          throw FormatException(
              'Key ${group.key.toUpperCase()} is already the single-key shortcut for ${product.name}. Clear or change that product shortcut first.');
        }
      }
      for (final option in group.options.where((o) => o.enabled)) {
        if (!active.containsKey(option.productId)) {
          throw FormatException(
              '${group.name} / ${option.label}: select an active product or disable this entry.');
        }
      }
    }
  }
}

class PosShortcutGroup {
  PosShortcutGroup(
      {required this.id,
      required String name,
      required String key,
      this.enabled = true,
      required List<PosShortcutOption> options})
      : name = _text(name, 'group name'),
        key = _key(key),
        options = List.unmodifiable(options) {
    if (!RegExp(r'^[a-zA-Z0-9_-]{1,64}$').hasMatch(id)) {
      throw const FormatException('Invalid group id');
    }
    if (options.length > 36) {
      throw const FormatException('At most 36 entries per group are supported');
    }
    final keys = <String>{};
    for (final option in options) {
      if (option.enabled && !keys.add(option.key)) {
        throw FormatException(
            '$name: duplicate key ${option.key.toUpperCase()}');
      }
    }
  }
  final String id;
  final String name;
  final String key;
  final bool enabled;
  final List<PosShortcutOption> options;
  factory PosShortcutGroup.fromJson(Map<String, dynamic> json) =>
      PosShortcutGroup(
        id: _text(json['id'], 'group id'),
        name: _text(json['name'], 'group name'),
        key: _key(json['key']),
        enabled: _bool(json['enabled'], 'group enabled'),
        options: _objects(json['options'], 'options')
            .map(PosShortcutOption.fromJson)
            .toList(),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'key': key,
        'enabled': enabled,
        'options': options.map((o) => o.toJson()).toList()
      };
}

class PosShortcutOption {
  PosShortcutOption(
      {required String key,
      required String label,
      this.productId,
      this.enabled = true})
      : key = _key(key),
        label = _text(label, 'entry label') {
    if (productId != null &&
        !RegExp(r'^[a-fA-F0-9]{24}$').hasMatch(productId!)) {
      throw const FormatException('Invalid productId');
    }
    if (enabled && productId == null) {
      throw const FormatException('Select a product for each enabled entry');
    }
  }
  final String key;
  final String label;
  final String? productId;
  final bool enabled;
  factory PosShortcutOption.fromJson(Map<String, dynamic> json) {
    final productId = json['productId'];
    if (productId != null && productId is! String) {
      throw const FormatException('productId must be a string or null');
    }
    return PosShortcutOption(
        key: _key(json['key']),
        label: _text(json['label'], 'entry label'),
        productId: productId as String?,
        enabled: _bool(json['enabled'], 'entry enabled'));
  }
  Map<String, dynamic> toJson() =>
      {'key': key, 'label': label, 'productId': productId, 'enabled': enabled};
}

String _text(Object? value, String field) {
  if (value is! String || value.trim().isEmpty || value.trim().length > 100) {
    throw FormatException('$field must be 1–100 characters');
  }
  return value.trim();
}

String _key(Object? value) {
  if (value is! String || !RegExp(r'^[a-zA-Z0-9]$').hasMatch(value.trim())) {
    throw const FormatException('Shortcut keys must be one letter or number');
  }
  return value.trim().toLowerCase();
}

bool _bool(Object? value, String field) {
  if (value is! bool) throw FormatException('$field must be true or false');
  return value;
}

List<Map<String, dynamic>> _objects(Object? value, String field) {
  if (value is! List) throw FormatException('$field must be a list');
  return value.map((entry) {
    if (entry is! Map<String, dynamic>) {
      throw FormatException('$field entries must be objects');
    }
    return entry;
  }).toList();
}
