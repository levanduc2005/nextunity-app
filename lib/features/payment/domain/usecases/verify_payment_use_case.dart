import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/payment/domain/entities/payment_status_entity.dart';
import 'package:rental_car/features/payment/domain/repositories/payment_repository.dart';

class VerifyPaymentUseCase {
  const VerifyPaymentUseCase(this._repository);

  final PaymentRepository _repository;

  Future<Result<PaymentStatusEntity>> call(int orderCode) {
    return _repository.verifyPayment(orderCode);
  }
}
