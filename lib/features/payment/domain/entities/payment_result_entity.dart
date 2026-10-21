import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_result_entity.freezed.dart';

@freezed
abstract class PaymentResultEntity with _$PaymentResultEntity {
  const factory PaymentResultEntity({
    required int orderCode,
    required String checkoutUrl,
    required String qrCode,
    required int amount,
    required String plan,
    DateTime? expiresAt,
  }) = _PaymentResultEntity;
}
