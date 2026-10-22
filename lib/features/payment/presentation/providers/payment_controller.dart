import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';
import 'package:rental_car/features/payment/domain/entities/payment_status_entity.dart';
import 'package:rental_car/features/payment/domain/usecases/create_payment_use_case.dart';
import 'package:rental_car/features/payment/domain/usecases/subscribe_payment_status_use_case.dart';
import 'package:rental_car/features/payment/domain/usecases/verify_payment_use_case.dart';
import 'package:rental_car/features/payment/presentation/providers/payment_providers.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';

// --- Controller State ---
class PaymentState {
  const PaymentState({
    this.isLoading = false,
    this.errorMessage,
    this.currentPayment,
    this.statusEntity,
  });

  final bool isLoading;
  final String? errorMessage;
  final PaymentResultEntity? currentPayment;
  final PaymentStatusEntity? statusEntity;

  PaymentState copyWith({
    bool? isLoading,
    String? errorMessage,
    PaymentResultEntity? currentPayment,
    PaymentStatusEntity? statusEntity,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      currentPayment: currentPayment ?? this.currentPayment,
      statusEntity: statusEntity ?? this.statusEntity,
    );
  }
}

// --- Payment Controller ---
class PaymentController extends Notifier<PaymentState> {
  @override
  PaymentState build() => const PaymentState();

  CreatePaymentUseCase get _createPayment =>
      ref.read(createPaymentUseCaseProvider);

  VerifyPaymentUseCase get _verifyPayment =>
      ref.read(verifyPaymentUseCaseProvider);

  SubscribePaymentStatusUseCase get _subscribePayment =>
      ref.read(subscribePaymentStatusUseCaseProvider);

  Stream<PaymentStatusEntity> subscribePayment(int orderCode) async* {
    final stream = _subscribePayment(orderCode);
    await for (final result in stream) {
      if (result case Ok(:final value)) {
        state = state.copyWith(statusEntity: value);
        if (value.isPaid) {
          ref.read(profileControllerProvider.notifier).refreshProfile();
        }
        yield value;
      }
    }
  }

  Future<PaymentResultEntity?> createPayment(String planCode) async {
    state = state.copyWith(isLoading: true);

    final result = await _createPayment(planCode);

    return result.when(
      ok: (PaymentResultEntity payment) {
        state = state.copyWith(
          isLoading: false,
          currentPayment: payment,
        );
        return payment;
      },
      err: (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return null;
      },
    );
  }

  Future<PaymentStatusEntity?> verifyPayment(int orderCode) async {
    final result = await _verifyPayment(orderCode);

    return result.when(
      ok: (PaymentStatusEntity status) {
        state = state.copyWith(statusEntity: status);
        if (status.isPaid) {
          // Kích hoạt làm mới hồ sơ để cập nhật huy hiệu PLUS
          ref.read(profileControllerProvider.notifier).refreshProfile();
        }
        return status;
      },
      err: (failure) {
        return null;
      },
    );
  }

  void reset() {
    state = const PaymentState();
  }
}

final paymentControllerProvider =
    NotifierProvider<PaymentController, PaymentState>(PaymentController.new);
