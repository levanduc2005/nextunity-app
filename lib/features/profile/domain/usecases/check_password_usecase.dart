import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/profile/domain/repositories/profile_repository.dart';

class CheckPasswordUseCase {
  const CheckPasswordUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<void>> call(String password) {
    return _repository.checkPassword(password);
  }
}
