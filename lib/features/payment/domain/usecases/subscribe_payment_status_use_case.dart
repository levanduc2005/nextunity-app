import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/payment/domain/entities/payment_status_entity.dart';
import 'package:rental_car/features/payment/domain/repositories/payment_repository.dart';

class SubscribePaymentStatusUseCase {
  const SubscribePaymentStatusUseCase(this._repository);

  final PaymentRepository _repository;

  Stream<Result<PaymentStatusEntity>> call(int orderCode) {
    return _repository.subscribePaymentStatus(orderCode);
  }
}
