import 'package:json_annotation/json_annotation.dart';

part 'startshipit_error_model.g.dart';

/// Represents an error from StartShipIt API
///
/// Contains information about the error, including the error message
/// and detailed exception information.
///
/// Example:
/// ```dart
/// final error = StartShipItErrorModel(
///   message: 'Invalid address',
///   details: 'The provided postal code is not valid for the country',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItErrorModel {
  /// Error message
  final String message;

  /// Detailed exception information
  final String details;

  const StartShipItErrorModel({
    required this.message,
    required this.details,
  });

  /// Creates an instance from a JSON object
  factory StartShipItErrorModel.fromJson(Map<String, dynamic> json) =>
      _$StartShipItErrorModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$StartShipItErrorModelToJson(this);
}
