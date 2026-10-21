import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_status_entity.freezed.dart';

@freezed
abstract class PaymentStatusEntity with _$PaymentStatusEntity {
  const factory PaymentStatusEntity({
    required int orderCode,
    required int amount,
    required String status,
    required String plan,
    required bool isPaid,
  }) = _PaymentStatusEntity;
}
