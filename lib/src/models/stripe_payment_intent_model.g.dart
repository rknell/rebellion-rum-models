// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_payment_intent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripePaymentIntentModel _$StripePaymentIntentModelFromJson(
        Map<String, dynamic> json) =>
    StripePaymentIntentModel(
      id: json['id'] as String,
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      clientSecret: json['client_secret'] as String,
      paymentMethodTypes: (json['payment_method_types'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      livemode: json['livemode'] as bool,
      created: (json['created'] as num).toInt(),
      captureMethod: json['capture_method'] as String,
      confirmationMethod: json['confirmation_method'] as String,
      amountCapturable: (json['amount_capturable'] as num).toInt(),
      amountReceived: (json['amount_received'] as num).toInt(),
      description: json['description'] as String?,
      metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      paymentMethodOptions:
          json['payment_method_options'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$StripePaymentIntentModelToJson(
        StripePaymentIntentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'client_secret': instance.clientSecret,
      'payment_method_types': instance.paymentMethodTypes,
      if (instance.description case final value?) 'description': value,
      if (instance.metadata case final value?) 'metadata': value,
      'livemode': instance.livemode,
      'created': instance.created,
      'capture_method': instance.captureMethod,
      'confirmation_method': instance.confirmationMethod,
      'amount_capturable': instance.amountCapturable,
      'amount_received': instance.amountReceived,
      if (instance.paymentMethodOptions case final value?)
        'payment_method_options': value,
    };
