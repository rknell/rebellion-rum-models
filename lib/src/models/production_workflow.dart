import 'package:mongo_dart/mongo_dart.dart' show ObjectId;
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/alcocalc_lals_calculation.dart';

/// Optional, versioned workflow. Absent on historical runs: never infer completion.
class ProductionWorkflow {
  String phase;
  String operatorName;
  final List<ProductionBlendBatch> blends;
  ProductionWorkflow(
      {this.phase = 'load',
      this.operatorName = '',
      List<ProductionBlendBatch>? blends})
      : blends = blends ?? [];

  factory ProductionWorkflow.fromJson(Map<String, dynamic> json) {
    if (json['version'] != 1) {
      throw FormatException('workflow.version unsupported');
    }
    final phase = _text(json, 'phase');
    if (!const ['load', 'run', 'collect', 'blend', 'barrels'].contains(phase)) {
      throw FormatException('workflow.phase invalid');
    }
    final rows = json['blends'];
    if (rows is! List) throw FormatException('workflow.blends must be a list');
    return ProductionWorkflow(
        phase: phase,
        operatorName: _text(json, 'operatorName', empty: true),
        blends: rows
            .map((e) => ProductionBlendBatch.fromJson(_map(e, 'blends')))
            .toList());
  }
  Map<String, dynamic> toJson() => {
        'version': 1,
        'phase': phase,
        'operatorName': operatorName,
        'blends': blends.map((b) => b.toJson()).toList()
      };
}

/// A blend has its own identity, even when the physical vessel is reused.
/// Ingredients and barrel fills live in the bulk register, linked by this ID.
class ProductionBlendBatch {
  final String id;
  final String vesselId;
  final String name;
  final DateTime createdAt;
  final double targetKg;
  final double capacityLitres;
  AlcocalcLalsCalculation? settledMeasurement;
  double? waterKg;
  DateTime? blendedAt;
  String? reconciliationNote;
  bool closed;
  ProductionBlendBatch(
      {required this.id,
      required this.vesselId,
      required this.name,
      required this.createdAt,
      this.targetKg = 80,
      this.capacityLitres = 100,
      this.settledMeasurement,
      this.waterKg,
      this.blendedAt,
      this.reconciliationNote,
      this.closed = false});

  factory ProductionBlendBatch.fromJson(Map<String, dynamic> json) {
    final id = _id(json, 'id');
    try {
      final measurement = json['settledMeasurement'];
      final water = json['waterKg'];
      return ProductionBlendBatch(
          id: id,
          vesselId: _id(json, 'vesselId'),
          name: _text(json, 'name'),
          createdAt: jsonToDateTime(json['createdAt']),
          targetKg: _number(json, 'targetKg', positive: true),
          capacityLitres: _number(json, 'capacityLitres', positive: true),
          settledMeasurement: measurement == null
              ? null
              : productionMeasurementFromJson(measurement),
          waterKg: water == null ? null : _number(json, 'waterKg'),
          blendedAt: json['blendedAt'] == null
              ? null
              : jsonToDateTime(json['blendedAt']),
          reconciliationNote: json['reconciliationNote'] == null
              ? null
              : _text(json, 'reconciliationNote', empty: true),
          closed: json['closed'] is bool
              ? json['closed'] as bool
              : throw FormatException('closed must be boolean'));
    } catch (e) {
      throw FormatException('Blend $id: $e');
    }
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'vesselId': vesselId,
        'name': name,
        'createdAt': dateTimeToJson(createdAt),
        'targetKg': targetKg,
        'capacityLitres': capacityLitres,
        'settledMeasurement': settledMeasurement?.toJson(),
        'waterKg': waterKg,
        'blendedAt': dateTimeToJsonNullable(blendedAt),
        'reconciliationNote': reconciliationNote,
        'closed': closed
      };
}

/// Evidence attached to a physical movement. Unknown provenance remains unknown.
class ProductionMovementEvidence {
  final String? blendBatchId;
  final String role;
  final DateTime occurredAt;
  final DateTime recordedAt;
  final String operatorName;
  final double? ownAlcoholFraction;
  final String reference;
  ProductionMovementEvidence(
      {this.blendBatchId,
      required this.role,
      required this.occurredAt,
      required this.recordedAt,
      required this.operatorName,
      this.ownAlcoholFraction,
      required this.reference});
  factory ProductionMovementEvidence.fromJson(Map<String, dynamic> json) {
    final fraction = json['ownAlcoholFraction'];
    final own = fraction == null ? null : _number(json, 'ownAlcoholFraction');
    if (own != null && own > 1) {
      throw FormatException('ownAlcoholFraction exceeds 1');
    }
    final role = _text(json, 'role');
    if (!const ['collection', 'ingredient', 'barrel', 'loss'].contains(role)) {
      throw FormatException('productionEvidence.role invalid');
    }
    return ProductionMovementEvidence(
        blendBatchId:
            json['blendBatchId'] == null ? null : _id(json, 'blendBatchId'),
        role: role,
        occurredAt: jsonToDateTime(json['occurredAt']),
        recordedAt: jsonToDateTime(json['recordedAt']),
        operatorName: _text(json, 'operatorName'),
        ownAlcoholFraction: own,
        reference: _text(json, 'reference'));
  }
  Map<String, dynamic> toJson() => {
        'blendBatchId': blendBatchId,
        'role': role,
        'occurredAt': dateTimeToJson(occurredAt),
        'recordedAt': dateTimeToJson(recordedAt),
        'operatorName': operatorName,
        'ownAlcoholFraction': ownAlcoholFraction,
        'reference': reference
      };
}

AlcocalcLalsCalculation productionMeasurementFromJson(Object? value) {
  final json = _map(value, 'measurement');
  final weight = _number(json, 'weight');
  final abv = _number(json, 'abv');
  final temperature = json['temperature'];
  if (abv > 1 ||
      temperature is! num ||
      !temperature.isFinite ||
      temperature < -20 ||
      temperature > 50) {
    throw FormatException('measurement.abv or temperature invalid');
  }
  return AlcocalcLalsCalculation(
      weight: weight, abv: abv, temperature: temperature.toDouble());
}

Map<String, dynamic> _map(Object? value, String field) {
  if (value is! Map<String, dynamic>) {
    throw FormatException('$field must be an object');
  }
  return value;
}

String _text(Map<String, dynamic> json, String field, {bool empty = false}) {
  final value = json[field];
  if (value is! String || (!empty && value.trim().isEmpty)) {
    throw FormatException('$field must be text');
  }
  return value;
}

String _id(Map<String, dynamic> json, String field) {
  final value = _text(json, field);
  try {
    ObjectId.fromHexString(value);
  } catch (_) {
    throw FormatException('$field invalid ID');
  }
  return value;
}

double _number(Map<String, dynamic> json, String field,
    {bool positive = false}) {
  final value = json[field];
  if (value is! num ||
      !value.isFinite ||
      value < 0 ||
      (positive && value == 0)) {
    throw FormatException(
        '$field must be a finite ${positive ? 'positive' : 'non-negative'} number');
  }
  return value.toDouble();
}
