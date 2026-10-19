import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/profile/domain/repositories/profile_repository.dart';

class ChangePasswordUseCase {
  const ChangePasswordUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<void>> call({
    required String currentPassword,
    required String newPassword,
  }) {
    return _repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
