// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePaymentModel _$CreatePaymentModelFromJson(Map<String, dynamic> json) =>
    _CreatePaymentModel(
      orderCode: (json['orderCode'] as num).toInt(),
      checkoutUrl: json['checkoutUrl'] as String,
      qrCode: json['qrCode'] as String,
      amount: (json['amount'] as num).toInt(),
      plan: json['plan'] as String,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$CreatePaymentModelToJson(_CreatePaymentModel instance) =>
    <String, dynamic>{
      'orderCode': instance.orderCode,
      'checkoutUrl': instance.checkoutUrl,
      'qrCode': instance.qrCode,
      'amount': instance.amount,
      'plan': instance.plan,
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };
