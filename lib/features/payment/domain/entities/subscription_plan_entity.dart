import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_plan_entity.freezed.dart';

@freezed
abstract class SubscriptionPlanEntity with _$SubscriptionPlanEntity {
  const factory SubscriptionPlanEntity({
    required String code,
    required String name,
    required int price,
    required int durationDays,
    required String description,
  }) = _SubscriptionPlanEntity;

  const SubscriptionPlanEntity._();

  bool get isSemester => code.toUpperCase().contains('SEMESTER');
}
