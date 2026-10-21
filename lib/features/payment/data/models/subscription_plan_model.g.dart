// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionPlanModel _$SubscriptionPlanModelFromJson(
  Map<String, dynamic> json,
) => _SubscriptionPlanModel(
  code: json['code'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  durationDays: (json['durationDays'] as num?)?.toInt() ?? 30,
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$SubscriptionPlanModelToJson(
  _SubscriptionPlanModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'price': instance.price,
  'durationDays': instance.durationDays,
  'description': instance.description,
};
