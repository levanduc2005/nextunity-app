import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';
import 'package:rental_car/features/payment/domain/entities/payment_status_entity.dart';
import 'package:rental_car/features/payment/domain/entities/subscription_plan_entity.dart';

abstract interface class PaymentRepository {
  Future<Result<List<SubscriptionPlanEntity>>> getAvailablePlans();
  Future<Result<PaymentResultEntity>> createPayment(String planCode);
  Future<Result<PaymentStatusEntity>> verifyPayment(int orderCode);
}
