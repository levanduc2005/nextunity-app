import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<UserEntity>> call({
    String? fullName,
    String? university,
    String? studentId,
    String? avatarUrl,
    String? gender,
    DateTime? dateOfBirth,
    int? cohort,
    String? major,
    String? bio,
  }) {
    return _repository.updateProfile(
      fullName: fullName,
      university: university,
      studentId: studentId,
      avatarUrl: avatarUrl,
      gender: gender,
      dateOfBirth: dateOfBirth,
      cohort: cohort,
      major: major,
      bio: bio,
    );
  }
}
