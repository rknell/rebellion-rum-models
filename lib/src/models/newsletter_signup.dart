import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'newsletter_signup.g.dart';

/// Represents a newsletter signup record.
///
/// This model tracks contact information for users who have signed up
/// for the newsletter. Currently stores the contact information (typically
/// an email address) along with the signup timestamp.
///
/// Example:
/// ```dart
/// final signup = NewsletterSignupModel(
///   contactInfo: 'customer@example.com',
/// );
/// ```
@JsonSerializable()
class NewsletterSignupModel extends DatabaseSerializable {
  /// Contact information (typically email address) for the newsletter signup. It may also contain a mobile number
  final String contactInfo;

  /// Timestamp when the signup occurred
  /// If not set, falls back to the ObjectId timestamp
  final DateTime? signupDate;

  /// Whether this signup is still active (for managing unsubscribes)
  final bool isActive;

  /// Get the effective signup timestamp, falling back to ObjectId timestamp if not set
  DateTime get effectiveSignupDate => signupDate ?? id.dateTime;

  NewsletterSignupModel({
    super.id,
    required this.contactInfo,
    this.signupDate,
    this.isActive = true,
  });

  factory NewsletterSignupModel.fromJson(Map<String, dynamic> json) =>
      _$NewsletterSignupModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NewsletterSignupModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
