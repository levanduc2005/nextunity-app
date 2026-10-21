import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/payment/domain/entities/subscription_plan_entity.dart';
import 'package:rental_car/features/payment/domain/repositories/payment_repository.dart';

class GetAvailablePlansUseCase {
  const GetAvailablePlansUseCase(this._repository);

  final PaymentRepository _repository;

  Future<Result<List<SubscriptionPlanEntity>>> call() {
    return _repository.getAvailablePlans();
  }
}
