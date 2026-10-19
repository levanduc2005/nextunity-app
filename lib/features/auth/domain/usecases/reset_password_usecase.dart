import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  const ResetPasswordUseCase(this._repository);

  Future<Result<void>> call({
    required String email,
    required String newPassword,
  }) {
    return _repository.resetPassword(email: email, newPassword: newPassword);
  }
}
