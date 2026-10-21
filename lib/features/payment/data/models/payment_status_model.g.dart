// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentStatusModel _$PaymentStatusModelFromJson(Map<String, dynamic> json) =>
    _PaymentStatusModel(
      orderCode: (json['orderCode'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      status: json['status'] as String,
      plan: json['plan'] as String? ?? '',
    );

Map<String, dynamic> _$PaymentStatusModelToJson(_PaymentStatusModel instance) =>
    <String, dynamic>{
      'orderCode': instance.orderCode,
      'amount': instance.amount,
      'status': instance.status,
      'plan': instance.plan,
    };
