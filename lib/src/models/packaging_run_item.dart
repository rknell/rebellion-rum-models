import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/alcocalc_dilution_calculation.dart';

part 'packaging_run_item.g.dart';

/// Status of a packaging run
/// Note: Introduced in v2.0.0 replacing string-based exciseReturn field
/// Migration path:
/// - Previous exciseReturn="": maps to inProgress
/// - Previous exciseReturn="W12345": maps to complete
/// - Previous exciseReturn=null: maps to inProgress
/// - All other values map to awaitingExcise
///
/// Enhanced in v3.0.0 to add excised status
enum PackagingRunStatus {
  /// Run is in progress
  inProgress,

  /// Run is complete but awaiting excise return
  awaitingExcise,

  /// Run is complete with excise return
  complete,

  /// Run is excised (final state)
  excised
}

@JsonSerializable()
class PackagingRunItemModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Barcode of the product being packaged
  String productBarcode;

  /// Size of individual units (typically 700ml, expressed in litres as 0.7)
  double unitSize;

  /// Alcohol strength (ABV) expressed as 0.50 for 50%
  double strength;

  /// Number of units packaged
  double unitsPackaged;

  /// Losses during packaging
  double packagingLosses;

  /// Remaining product after packaging
  double remaining;

  /// Volume available before packaging
  double volumeAvailable;

  /// Volume remaining after packaging
  double volumeRemaining;

  /// The initial LALs calculation for the packaging run
  AlcocalcDilutionCalculation? estimatedProduct;

  /// Secondary dilution calculation, if needed (when ABV reading is out of range)
  AlcocalcDilutionCalculation? secondaryDilution;

  /// ABV reading taken after dilution
  double? abvReading;

  /// Target number of bottles to fill, compare to units packaged and ensure its within 1.5% plus or minus
  int targetBottles;

  /// The timestamp of the packaging run
  /// If not set, falls back to the ObjectId timestamp
  DateTime? timestamp;

  /// The date when this packaging run was marked as complete
  DateTime? completionDate;

  /// Get the effective timestamp, falling back to ObjectId timestamp if not set
  DateTime get effectiveTimestamp => timestamp ?? id.dateTime;

  /// Default value of inProgress aligns with the migration path where both
  /// empty strings and null values in the legacy exciseReturn field map to inProgress,
  /// making it the most appropriate default for new records and migration cases.
  @JsonKey(unknownEnumValue: PackagingRunStatus.excised)
  PackagingRunStatus status;

  /// Excise return reference - either ObjectId or string identifier
  @NullableObjectIdConverter()
  ObjectId? exciseReturn;

  /// Note explaining discrepancy when actual bottles != expected bottles +- 1.5%
  String? discrepancyNote;

  PackagingRunItemModel({
    ObjectId? id,
    required this.productBarcode,
    required this.unitSize,
    required this.strength,
    required this.unitsPackaged,
    required this.packagingLosses,
    required this.remaining,
    required this.volumeAvailable,
    required this.volumeRemaining,
    this.targetBottles = 0,
    this.status = PackagingRunStatus.inProgress,
    this.estimatedProduct,
    this.secondaryDilution,
    this.abvReading,
    this.exciseReturn,
    this.timestamp,
    this.discrepancyNote,
    this.completionDate,
  }) : id = id ?? ObjectId();

  factory PackagingRunItemModel.fromJson(Map<String, dynamic> json) =>
      _$PackagingRunItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackagingRunItemModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
