import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/auth/domain/repositories/auth_repository.dart';

class VerifyForgotPasswordOtpUseCase {
  final AuthRepository _repository;

  const VerifyForgotPasswordOtpUseCase(this._repository);

  Future<Result<void>> call({required String email, required String otp}) {
    return _repository.verifyForgotPasswordOtp(email: email, otp: otp);
  }
}
