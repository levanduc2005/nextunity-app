import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/payment/domain/entities/payment_status_entity.dart';

part 'payment_status_model.freezed.dart';
part 'payment_status_model.g.dart';

@freezed
abstract class PaymentStatusModel with _$PaymentStatusModel {
  const factory PaymentStatusModel({
    required int orderCode,
    required int amount,
    required String status,
    @Default('') String plan,
  }) = _PaymentStatusModel;

  const PaymentStatusModel._();

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatusModelFromJson(json);

  PaymentStatusEntity toEntity() => PaymentStatusEntity(
    orderCode: orderCode,
    amount: amount,
    status: status,
    plan: plan,
    isPaid: status.toUpperCase() == 'PAID',
  );
}
