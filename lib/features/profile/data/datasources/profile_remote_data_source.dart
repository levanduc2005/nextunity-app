import 'package:dio/dio.dart';
import 'package:rental_car/core/config/app_config.dart';
import 'package:rental_car/core/error/exceptions.dart';
import 'package:rental_car/core/network/api_handler.dart';
import 'package:rental_car/features/auth/data/models/user_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile(Map<String, dynamic> updateData);
  Future<String> uploadAvatar(String filePath);
  Future<void> checkPassword(String password);
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({required Dio dio, Dio? cloudinaryDio})
    : _dio = dio,
      _cloudinaryDio = cloudinaryDio;

  final Dio _dio;
  final Dio? _cloudinaryDio;

  Dio get _effectiveCloudinaryDio =>
      _cloudinaryDio ??
      Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

  @override
  Future<UserModel> getProfile() {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>('/users/me');
      final data = response.data?['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw const ParsingException('Không tìm thấy dữ liệu người dùng.');
      }
      return UserModel.fromJson(data);
    });
  }

  @override
  Future<UserModel> updateProfile(Map<String, dynamic> updateData) {
    return guardApiCall(() async {
      final response = await _dio.put<Map<String, dynamic>>(
        '/users/me',
        data: updateData,
      );
      final data = response.data?['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw const ParsingException('Không tìm thấy dữ liệu cập nhật.');
      }
      return UserModel.fromJson(data);
    });
  }

  @override
  Future<String> uploadAvatar(String filePath) {
    return guardApiCall(() async {
      if (AppConfig.cloudinaryCloudName.isEmpty ||
          AppConfig.cloudinaryUploadPreset.isEmpty) {
        throw const ServerException(
          message:
              'Chưa cấu hình Cloudinary (CLOUDINARY_CLOUD_NAME hoặc CLOUDINARY_UPLOAD_PRESET).',
        );
      }

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        'upload_preset': AppConfig.cloudinaryUploadPreset,
        'folder': 'user_avatar',
      });

      const url =
          'https://api.cloudinary.com/v1_1/${AppConfig.cloudinaryCloudName}/image/upload';

      final response = await _effectiveCloudinaryDio.post<Map<String, dynamic>>(
        url,
        data: formData,
      );

      final secureUrl = response.data?['secure_url'] as String?;
      if (secureUrl == null) {
        throw const ParsingException(
          'Không nhận được secure_url từ Cloudinary.',
        );
      }

      return secureUrl;
    });
  }

  @override
  Future<void> checkPassword(String password) {
    return guardApiCall(() async {
      await _dio.post<Map<String, dynamic>>(
        '/users/check-password',
        data: {'password': password},
      );
    });
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return guardApiCall(() async {
      await _dio.put<Map<String, dynamic>>(
        '/users/change-password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
      );
    });
  }
}
