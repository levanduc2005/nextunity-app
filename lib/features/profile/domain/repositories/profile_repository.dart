import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';

abstract interface class ProfileRepository {
  /// Lấy thông tin cá nhân của người dùng hiện tại
  Future<Result<UserEntity>> getProfile();

  /// Cập nhật thông tin cá nhân
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
  });

  /// Tải lên ảnh đại diện
  Future<Result<String>> uploadAvatar(String filePath);

  /// Kiểm tra mật khẩu hiện tại
  Future<Result<void>> checkPassword(String password);

  /// Đổi mật khẩu
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
