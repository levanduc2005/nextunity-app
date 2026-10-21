import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/payment/domain/entities/subscription_plan_entity.dart';

part 'subscription_plan_model.freezed.dart';
part 'subscription_plan_model.g.dart';

@freezed
abstract class SubscriptionPlanModel with _$SubscriptionPlanModel {
  const factory SubscriptionPlanModel({
    required String code,
    required String name,
    required int price,
    @Default(30) int durationDays,
    @Default('') String description,
  }) = _SubscriptionPlanModel;

  const SubscriptionPlanModel._();

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanModelFromJson(json);

  SubscriptionPlanEntity toEntity() => SubscriptionPlanEntity(
        code: code,
        name: name,
        price: price,
        durationDays: durationDays,
        description: description,
      );
}
