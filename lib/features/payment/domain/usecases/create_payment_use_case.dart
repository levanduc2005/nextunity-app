import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';
import 'package:rental_car/features/payment/domain/repositories/payment_repository.dart';

class CreatePaymentUseCase {
  const CreatePaymentUseCase(this._repository);

  final PaymentRepository _repository;

  Future<Result<PaymentResultEntity>> call(String planCode) {
    return _repository.createPayment(planCode);
  }
}
