// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_confirm_payment_intent_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeConfirmPaymentIntentRequest _$StripeConfirmPaymentIntentRequestFromJson(
        Map<String, dynamic> json) =>
    StripeConfirmPaymentIntentRequest(
      paymentMethod: json['payment_method'] as String?,
      receiptEmail: json['receipt_email'] as String?,
      setupFutureUsage: $enumDecodeNullable(
              _$StripeSetupFutureUsageEnumMap, json['setup_future_usage'],
              unknownValue: StripeSetupFutureUsage.none) ??
          StripeSetupFutureUsage.none,
      shipping: json['shipping'] == null
          ? null
          : StripeShippingDetails.fromJson(
              json['shipping'] as Map<String, dynamic>),
      returnUrl: json['return_url'] as String?,
      errorOnRequiresAction: json['error_on_requires_action'] as bool?,
      mandate: json['mandate'] as String?,
      useStripeSdk: json['use_stripe_sdk'] as bool? ?? false,
    );

Map<String, dynamic> _$StripeConfirmPaymentIntentRequestToJson(
        StripeConfirmPaymentIntentRequest instance) =>
    <String, dynamic>{
      if (instance.paymentMethod case final value?) 'payment_method': value,
      if (instance.receiptEmail case final value?) 'receipt_email': value,
      if (_$StripeSetupFutureUsageEnumMap[instance.setupFutureUsage]
          case final value?)
        'setup_future_usage': value,
      if (instance.shipping?.toJson() case final value?) 'shipping': value,
      if (instance.returnUrl case final value?) 'return_url': value,
      if (instance.errorOnRequiresAction case final value?)
        'error_on_requires_action': value,
      if (instance.mandate case final value?) 'mandate': value,
      if (instance.useStripeSdk case final value?) 'use_stripe_sdk': value,
    };

const _$StripeSetupFutureUsageEnumMap = {
  StripeSetupFutureUsage.offSession: 'off_session',
  StripeSetupFutureUsage.onSession: 'on_session',
  StripeSetupFutureUsage.none: null,
};
