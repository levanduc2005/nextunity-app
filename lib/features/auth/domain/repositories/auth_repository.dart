import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/auth/domain/entities/auth_tokens.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  /// Đăng ký tài khoản mới (FullName, Email, Password)
  Future<Result<void>> register({
    required String fullName,
    required String email,
    required String password,
  });

  /// Gửi mã OTP đến email user
  Future<Result<void>> sendOtp({required String email});

  /// Lấy thông tin current user
  Future<Result<UserEntity?>> getCurrentUser();

  /// Đăng xuất, xóa toàn bộ token và phiên làm việc
  Future<Result<void>> logout();

  /// Refresh Access Token
  Future<Result<AuthTokens>> refreshToken();

  /// Đăng nhập bằng Email và Password
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  });

  /// Xác thực mã OTP sau khi đăng ký tài khoản
  Future<Result<void>> verifyRegisterOtp({
    required String email,
    required String otp,
  });

  /// Yêu cầu gửi mã OTP đặt lại mật khẩu qua email
  Future<Result<void>> forgotPassword({required String email});

  /// Xác thực mã OTP đặt lại mật khẩu
  Future<Result<void>> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  });

  /// Đặt lại mật khẩu mới
  Future<Result<void>> resetPassword({
    required String email,
    required String newPassword,
  });

  /// Đăng nhập bằng tài khoản Google (OAuth 2.0)
  Future<Result<UserEntity>> signInWithGoogle();
}
