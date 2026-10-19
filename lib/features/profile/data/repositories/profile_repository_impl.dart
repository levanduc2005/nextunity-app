import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/core/utils/safe_call.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:rental_car/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required ProfileRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<Result<UserEntity>> getProfile() {
    return safeCall(() async {
      final model = await _remoteDataSource.getProfile();
      return model.toEntity();
    });
  }

  @override
  Future<Result<UserEntity>> updateProfile({
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
    return safeCall(() async {
      final updateData = <String, dynamic>{};
      if (fullName != null) updateData['fullName'] = fullName;
      if (university != null) updateData['university'] = university;
      if (studentId != null) updateData['studentId'] = studentId;
      if (avatarUrl != null) updateData['avatarUrl'] = avatarUrl;
      if (gender != null) updateData['gender'] = gender;
      if (dateOfBirth != null) {
        updateData['dateOfBirth'] = dateOfBirth
            .toIso8601String()
            .split('T')
            .first;
      }
      if (cohort != null) updateData['cohort'] = cohort;
      if (major != null) updateData['major'] = major;
      if (bio != null) updateData['bio'] = bio;

      final model = await _remoteDataSource.updateProfile(updateData);
      return model.toEntity();
    });
  }

  @override
  Future<Result<String>> uploadAvatar(String filePath) {
    return safeCall(() => _remoteDataSource.uploadAvatar(filePath));
  }

  @override
  Future<Result<void>> checkPassword(String password) {
    return safeCall(() => _remoteDataSource.checkPassword(password));
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return safeCall(
      () => _remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      ),
    );
  }
}
