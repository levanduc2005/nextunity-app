import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/profile/domain/repositories/profile_repository.dart';

class UploadAvatarUseCase {
  const UploadAvatarUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<String>> call(String filePath) =>
      _repository.uploadAvatar(filePath);
}
