import 'package:alcocalc/alcocalc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/alcocalc_lals_calculation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'distillation_record.g.dart';

/// Status of a distillation record
enum DistillationStatus {
  /// Record is being created/edited
  inProgress,

  /// Distillation is complete
  completed,

  /// Record has been archived
  archived
}

/// Represents a record of a distillation run in the production process.
///
/// Each distillation record tracks the details of a single distillation run,
/// including the still used, LALs measurements, and any notes taken during the process.
/// The record's ObjectId serves as the charge number, using its timestamp for sequential tracking.
@JsonSerializable()
class DistillationRecordModel extends DatabaseSerializable {
  /// The still used for this distillation run
  String stillUsed;

  /// Start time of the distillation
  final DateTime startTime;

  /// Current status of the distillation record
  @JsonKey(defaultValue: DistillationStatus.inProgress)
  final DistillationStatus status;

  /// Amount of feints added during the run
  double feintsAdded;

  /// Amount of LALs charged during the run
  double lalsCharged;

  /// Total LALs charged for this run (including all inputs)
  double totalLALsCharged;

  /// Total LALs yield from this run (sum of all outputs)
  double totalLALsYield;

  /// Notes taken during the distillation process
  final List<NoteModel> notes;

  GinStillStocktakeModel? ginStillStocktake;

  DistillationRecordModel({
    super.id,
    this.stillUsed = '',
    DateTime? startTime,
    this.status = DistillationStatus.inProgress,
    this.feintsAdded = 0,
    this.lalsCharged = 0,
    this.totalLALsCharged = 0,
    this.totalLALsYield = 0,
    List<NoteModel>? notes,
  })  : startTime = startTime ?? DateTime.now(),
        notes = notes ?? [];

  factory DistillationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DistillationRecordModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DistillationRecordModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'notes': true,
      };

  @override
  Map<String, Function> get nestedTypes => {
        'notes': NoteModel.fromJson,
      };
}

/// Represents a note in the distillation process
@JsonSerializable()
class NoteModel {
  String content;
  final DateTime date;
  final bool isSystem;

  NoteModel({
    required this.content,
    required this.date,
    this.isSystem = false,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}

/// Represents a stocktake measurement for a gin still
///
/// This model captures the key measurements needed for inventory tracking
/// of spirits in a gin still, including the liquid height, alcohol by volume,
/// and temperature (defaulting to 20°C if not specified).
@JsonSerializable()
class GinStillStocktakeModel {
  /// The height of the liquid in the still
  final double height;

  /// The alcohol by volume (ABV) as a decimal (e.g., 0.40 for 40%)
  final double abv;

  /// The temperature of the liquid in Celsius
  /// Defaults to 20°C if not specified
  final double temperature;

  final double volume;

  static double currentVolume(double height) {
    var stillWidth = 70; //cm
    var stillHeight = 61; //cm
    // Calculate the volume based on the "head gap" measurement
    // The height field represents the gap between liquid and top of vessel

    // Calculate the actual liquid height by subtracting the head gap from still height
    var liquidHeight = stillHeight - height;

    // Ensure the liquid height is not negative
    if (liquidHeight < 0) {
      return 0;
    }

    // Calculate the volume using the formula for a cylinder: V = π * r² * h
    // where r is the radius (stillWidth/2) and h is the liquid height

    // Convert width to radius in cm
    var radius = stillWidth / 2;

    // Calculate the total volume of the cylinder in cubic cm
    var liquidVolumeCm3 = 3.14159 * radius * radius * liquidHeight;

    // Convert to liters (1000 cm³ = 1 liter)
    return liquidVolumeCm3 / 1000;
  }

  final AlcocalcLalsCalculation lals;

  GinStillStocktakeModel({
    required this.height,
    required this.abv,
    this.temperature = 20,
  })  : volume = currentVolume(height),
        lals = AlcocalcLalsCalculation(
            weight: Alcocalc.abvToAbw(abv) * currentVolume(height),
            abv: abv,
            temperature: temperature);

  factory GinStillStocktakeModel.fromJson(Map<String, dynamic> json) =>
      _$GinStillStocktakeModelFromJson(json);
  Map<String, dynamic> toJson() => _$GinStillStocktakeModelToJson(this);
}
