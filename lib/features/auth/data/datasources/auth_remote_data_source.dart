import 'package:dio/dio.dart';
import 'package:rental_car/core/network/api_handler.dart';
import 'package:rental_car/features/auth/data/models/auth_tokens_model.dart';
import 'package:rental_car/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> verifyRegisterOtp({required String email, required String otp});

  Future<({AuthTokensModel tokens, UserModel user})> login({
    required String email,
    required String password,
  });

  Future<void> forgotPassword({required String email});

  Future<void> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  });

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });

  Future<void> sendOtp({required String email});

  Future<UserModel> getCurrentUser();

  Future<void> logout({String? refreshToken});

  Future<AuthTokensModel> refreshToken({required String refreshToken});

  Future<({AuthTokensModel tokens, UserModel? user})> loginWithGoogle({
    required String idToken,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) {
    return guardApiCall(() async {
      await _dio.post<dynamic>(
        '/auth/register',
        data: {'fullName': fullName, 'email': email, 'password': password},
        options: Options(extra: {'isPublic': true}),
      );
    });
  }

  @override
  Future<void> verifyRegisterOtp({required String email, required String otp}) {
    return guardApiCall(() async {
      await _dio.post<dynamic>(
        '/auth/verify-register-otp',
        data: {'email': email, 'otp': otp},
        options: Options(extra: {'isPublic': true}),
      );
    });
  }

  @override
  Future<({AuthTokensModel tokens, UserModel user})> login({
    required String email,
    required String password,
  }) {
    return guardApiCall(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': email, 'password': password},
        options: Options(extra: {'isPublic': true}),
      );

      final data = response.data!['data'] as Map<String, dynamic>;
      final accessToken =
          (data['accessToken'] ?? data['token'] ?? '') as String;
      final refreshToken = data['refreshToken'] as String?;

      final tokens = AuthTokensModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
      return (tokens: tokens, user: user);
    });
  }

  @override
  Future<void> forgotPassword({required String email}) {
    return guardApiCall(() async {
      await _dio.post<dynamic>(
        '/auth/forgot-password',
        data: {'email': email},
        options: Options(extra: {'isPublic': true}),
      );
    });
  }

  @override
  Future<void> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) {
    return guardApiCall(() async {
      await _dio.post<dynamic>(
        '/auth/verify-forgot-password-otp',
        data: {'email': email, 'otp': otp},
        options: Options(extra: {'isPublic': true}),
      );
    });
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return guardApiCall(() async {
      await _dio.post<dynamic>(
        '/auth/reset-password',
        data: {'email': email, 'newPassword': newPassword},
        options: Options(extra: {'isPublic': true}),
      );
    });
  }

  @override
  Future<UserModel> getCurrentUser() {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>('/users/me');

      final data = response.data!['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data);
    });
  }

  @override
  Future<void> logout({String? refreshToken}) {
    return guardApiCall(() async {
      await _dio.post<void>(
        '/auth/logout',
        data: refreshToken != null && refreshToken.isNotEmpty
            ? {'refreshToken': refreshToken}
            : null,
      );
    });
  }

  @override
  Future<AuthTokensModel> refreshToken({required String refreshToken}) {
    return guardApiCall(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(extra: {'isPublic': true}),
      );

      final data = response.data!['data'] as Map<String, dynamic>;
      final accessToken =
          (data['accessToken'] ?? data['token'] ?? '') as String;
      final newRefreshToken = data['refreshToken'] as String? ?? refreshToken;

      return AuthTokensModel(
        accessToken: accessToken,
        refreshToken: newRefreshToken,
      );
    });
  }

  @override
  Future<void> sendOtp({required String email}) async {
    return guardApiCall(() async {
      await _dio.post<void>(
        '/auth/resend-register-otp',
        data: {'email': email},
        options: Options(extra: {'isPublic': true}),
      );
    });
  }

  @override
  Future<({AuthTokensModel tokens, UserModel? user})> loginWithGoogle({
    required String idToken,
  }) {
    return guardApiCall(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/google',
        data: {'idToken': idToken},
        options: Options(extra: {'isPublic': true}),
      );

      final data = response.data!['data'] as Map<String, dynamic>;
      final accessToken =
          (data['accessToken'] ?? data['token'] ?? '') as String;
      final refreshToken = data['refreshToken'] as String?;

      final tokens = AuthTokensModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      UserModel? user;
      if (data['user'] != null && data['user'] is Map<String, dynamic>) {
        try {
          user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
        } catch (_) {
          user = null;
        }
      }

      return (tokens: tokens, user: user);
    });
  }
}
