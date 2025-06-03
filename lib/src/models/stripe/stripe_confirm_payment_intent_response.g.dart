// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_confirm_payment_intent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeConfirmPaymentIntentResponse _$StripeConfirmPaymentIntentResponseFromJson(
        Map<String, dynamic> json) =>
    StripeConfirmPaymentIntentResponse(
      id: json['id'] as String,
      object: json['object'] as String,
      amount: (json['amount'] as num).toInt(),
      amountCapturable: (json['amount_capturable'] as num?)?.toInt(),
      amountDetails: json['amount_details'] as Map<String, dynamic>?,
      amountReceived: (json['amount_received'] as num?)?.toInt(),
      application: json['application'] as String?,
      applicationFeeAmount: (json['application_fee_amount'] as num?)?.toInt(),
      automaticPaymentMethods:
          json['automatic_payment_methods'] as Map<String, dynamic>?,
      canceledAt: (json['canceled_at'] as num?)?.toInt(),
      cancellationReason: json['cancellation_reason'] as String?,
      captureMethod: json['capture_method'] as String,
      clientSecret: json['client_secret'] as String,
      confirmationMethod: json['confirmation_method'] as String,
      created: (json['created'] as num).toInt(),
      currency: json['currency'] as String,
      customer: json['customer'] as String?,
      description: json['description'] as String?,
      lastPaymentError: json['last_payment_error'] as Map<String, dynamic>?,
      latestCharge: json['latest_charge'] as String?,
      livemode: json['livemode'] as bool,
      metadata: json['metadata'] as Map<String, dynamic>?,
      nextAction: json['next_action'] as Map<String, dynamic>?,
      onBehalfOf: json['on_behalf_of'] as String?,
      paymentMethod: json['payment_method'] as String?,
      paymentMethodOptions:
          json['payment_method_options'] as Map<String, dynamic>?,
      paymentMethodTypes: (json['payment_method_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      processing: json['processing'] as Map<String, dynamic>?,
      receiptEmail: json['receipt_email'] as String?,
      review: json['review'] as String?,
      setupFutureUsage: json['setup_future_usage'] as String?,
      shipping: json['shipping'] as Map<String, dynamic>?,
      source: json['source'] as String?,
      statementDescriptor: json['statement_descriptor'] as String?,
      statementDescriptorSuffix: json['statement_descriptor_suffix'] as String?,
      status: json['status'] as String,
      transferData: json['transfer_data'] as Map<String, dynamic>?,
      transferGroup: json['transfer_group'] as String?,
    );

Map<String, dynamic> _$StripeConfirmPaymentIntentResponseToJson(
        StripeConfirmPaymentIntentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'amount': instance.amount,
      if (instance.amountCapturable case final value?)
        'amount_capturable': value,
      if (instance.amountDetails case final value?) 'amount_details': value,
      if (instance.amountReceived case final value?) 'amount_received': value,
      if (instance.application case final value?) 'application': value,
      if (instance.applicationFeeAmount case final value?)
        'application_fee_amount': value,
      if (instance.automaticPaymentMethods case final value?)
        'automatic_payment_methods': value,
      if (instance.canceledAt case final value?) 'canceled_at': value,
      if (instance.cancellationReason case final value?)
        'cancellation_reason': value,
      'capture_method': instance.captureMethod,
      'client_secret': instance.clientSecret,
      'confirmation_method': instance.confirmationMethod,
      'created': instance.created,
      'currency': instance.currency,
      if (instance.customer case final value?) 'customer': value,
      if (instance.description case final value?) 'description': value,
      if (instance.lastPaymentError case final value?)
        'last_payment_error': value,
      if (instance.latestCharge case final value?) 'latest_charge': value,
      'livemode': instance.livemode,
      if (instance.metadata case final value?) 'metadata': value,
      if (instance.nextAction case final value?) 'next_action': value,
      if (instance.onBehalfOf case final value?) 'on_behalf_of': value,
      if (instance.paymentMethod case final value?) 'payment_method': value,
      if (instance.paymentMethodOptions case final value?)
        'payment_method_options': value,
      if (instance.paymentMethodTypes case final value?)
        'payment_method_types': value,
      if (instance.processing case final value?) 'processing': value,
      if (instance.receiptEmail case final value?) 'receipt_email': value,
      if (instance.review case final value?) 'review': value,
      if (instance.setupFutureUsage case final value?)
        'setup_future_usage': value,
      if (instance.shipping case final value?) 'shipping': value,
      if (instance.source case final value?) 'source': value,
      if (instance.statementDescriptor case final value?)
        'statement_descriptor': value,
      if (instance.statementDescriptorSuffix case final value?)
        'statement_descriptor_suffix': value,
      'status': instance.status,
      if (instance.transferData case final value?) 'transfer_data': value,
      if (instance.transferGroup case final value?) 'transfer_group': value,
    };
