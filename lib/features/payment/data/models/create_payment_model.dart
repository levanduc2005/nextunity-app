import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';

part 'create_payment_model.freezed.dart';
part 'create_payment_model.g.dart';

@freezed
abstract class CreatePaymentModel with _$CreatePaymentModel {
  const factory CreatePaymentModel({
    required int orderCode,
    required String checkoutUrl,
    required String qrCode,
    required int amount,
    required String plan,
    DateTime? expiresAt,
  }) = _CreatePaymentModel;

  const CreatePaymentModel._();

  factory CreatePaymentModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentModelFromJson(json);

  PaymentResultEntity toEntity() => PaymentResultEntity(
        orderCode: orderCode,
        checkoutUrl: checkoutUrl,
        qrCode: qrCode,
        amount: amount,
        plan: plan,
        expiresAt: expiresAt,
      );
}
