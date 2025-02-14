import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'payment.g.dart';

/// Represents the type of payment used in a transaction
enum PaymentType { cash, eftpos, coupon, online, bank, unknown }

/// Represents a payment made against a sale.
///
/// Each payment record tracks the amount, method, and any associated
/// transaction details or receipts.
///
/// Example:
/// ```dart
/// final payment = PaymentModel(
///   amount: 99.99,
///   type: PaymentType.eftpos,
///   reference: 'TXN-123',
/// );
/// ```
@JsonSerializable()
class PaymentModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Amount paid in this payment
  final double amount;

  /// Type of payment used
  @JsonKey(unknownEnumValue: PaymentType.unknown)
  final PaymentType type;

  /// Optional reference number (e.g., transaction ID, receipt number)
  final String? reference;

  PaymentModel({
    ObjectId? id,
    required this.amount,
    required this.type,
    this.reference,
  }) : id = id ?? ObjectId();

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
