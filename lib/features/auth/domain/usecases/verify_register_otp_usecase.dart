import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/auth/domain/repositories/auth_repository.dart';

class VerifyRegisterOtpUseCase {
  final AuthRepository _repository;

  const VerifyRegisterOtpUseCase(this._repository);

  Future<Result<void>> call({required String email, required String otp}) {
    return _repository.verifyRegisterOtp(email: email, otp: otp);
  }
}
