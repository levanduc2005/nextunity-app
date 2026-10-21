import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:rental_car/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:rental_car/features/payment/domain/entities/subscription_plan_entity.dart';
import 'package:rental_car/features/payment/domain/repositories/payment_repository.dart';
import 'package:rental_car/features/payment/domain/usecases/create_payment_use_case.dart';
import 'package:rental_car/features/payment/domain/usecases/get_available_plans_use_case.dart';
import 'package:rental_car/features/payment/domain/usecases/verify_payment_use_case.dart';

export 'payment_controller.dart';

// --- Data Sources & Repositories ---
final paymentRemoteDataSourceProvider = Provider<PaymentRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return PaymentRemoteDataSourceImpl(dio: dio);
});

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  final remote = ref.watch(paymentRemoteDataSourceProvider);
  return PaymentRepositoryImpl(remoteDataSource: remote);
});

// --- Use Cases ---
final getAvailablePlansUseCaseProvider = Provider<GetAvailablePlansUseCase>((ref) {
  final repo = ref.watch(paymentRepositoryProvider);
  return GetAvailablePlansUseCase(repo);
});

final createPaymentUseCaseProvider = Provider<CreatePaymentUseCase>((ref) {
  final repo = ref.watch(paymentRepositoryProvider);
  return CreatePaymentUseCase(repo);
});

final verifyPaymentUseCaseProvider = Provider<VerifyPaymentUseCase>((ref) {
  final repo = ref.watch(paymentRepositoryProvider);
  return VerifyPaymentUseCase(repo);
});

// --- Available Plans Provider ---
final availablePlansProvider =
    FutureProvider<List<SubscriptionPlanEntity>>((ref) async {
  final useCase = ref.watch(getAvailablePlansUseCaseProvider);
  final result = await useCase();
  return result.when(
    ok: (List<SubscriptionPlanEntity> plans) => plans,
    err: (failure) => throw Exception(failure.message),
  );
});
