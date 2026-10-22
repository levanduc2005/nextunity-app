import 'package:rental_car/core/error/exceptions.dart';
import 'package:rental_car/core/error/failure.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/core/utils/safe_call.dart';
import 'package:rental_car/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';
import 'package:rental_car/features/payment/domain/entities/payment_status_entity.dart';
import 'package:rental_car/features/payment/domain/entities/subscription_plan_entity.dart';
import 'package:rental_car/features/payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  const PaymentRepositoryImpl({
    required PaymentRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final PaymentRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<SubscriptionPlanEntity>>> getAvailablePlans() {
    return safeCall(() async {
      final models = await _remoteDataSource.getAvailablePlans();
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Result<PaymentResultEntity>> createPayment(String planCode) {
    return safeCall(() async {
      final model = await _remoteDataSource.createPayment(planCode);
      return model.toEntity();
    });
  }

  @override
  Future<Result<PaymentStatusEntity>> verifyPayment(int orderCode) {
    return safeCall(() async {
      final model = await _remoteDataSource.verifyPayment(orderCode);
      return model.toEntity();
    });
  }

  @override
  Stream<Result<PaymentStatusEntity>> subscribePaymentStatus(int orderCode) {
    return _remoteDataSource
        .subscribePaymentStatus(orderCode)
        .map<Result<PaymentStatusEntity>>(
          (model) => Result.ok(model.toEntity()),
        )
        .handleError((dynamic error) {
      if (error is ServerException) {
        return Result<PaymentStatusEntity>.err(
          ServerFailure(
            message: error.message,
            statusCode: error.statusCode,
            cause: error,
          ),
        );
      }
      if (error is NetworkException) {
        return Result<PaymentStatusEntity>.err(
          NetworkFailure(message: error.message, cause: error),
        );
      }
      return Result<PaymentStatusEntity>.err(
        UnknownFailure(message: error.toString(), cause: error),
      );
    });
  }
}
