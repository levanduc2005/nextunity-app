import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/login_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/logout_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/register_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/verify_forgot_password_otp_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/verify_register_otp_usecase.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_providers.dart';

enum AuthStatus {
  initial, // trạng thái khởi tạo: đang kiểm tra phiên đăng nhập cũ trong máy
  unauthenticated, // chưa đăng nhập -> màn hình login
  otpSent, // đã gửi OTP -> màn hình nhập OTP
  authenticated, // đã đăng nhập thành công
}

class AuthState {
  final AuthStatus status;
  final UserEntity? user;
  final String? emailForOtp;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.emailForOtp,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? emailForOtp,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      emailForOtp: emailForOtp ?? this.emailForOtp,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class AuthController extends Notifier<AuthState> {
  LoginUseCase get _loginUseCase => ref.read(loginUseCaseProvider);
  RegisterUseCase get _registerUseCase => ref.read(registerUseCaseProvider);
  VerifyRegisterOtpUseCase get _verifyRegisterOtpUseCase =>
      ref.read(verifyRegisterOtpUseCaseProvider);
  ForgotPasswordUseCase get _forgotPasswordUseCase =>
      ref.read(forgotPasswordUseCaseProvider);
  VerifyForgotPasswordOtpUseCase get _verifyForgotPasswordOtpUseCase =>
      ref.read(verifyForgotPasswordOtpUseCaseProvider);
  ResetPasswordUseCase get _resetPasswordUseCase =>
      ref.read(resetPasswordUseCaseProvider);
  GetCurrentUserUseCase get _getCurrentUserUseCase =>
      ref.read(getCurrentUserUseCaseProvider);
  SendOtpUseCase get _sendOtpUseCase => ref.read(sendOtpUseCaseProvider);
  VerifyOtpUseCase get _verifyOtpUseCase => ref.read(verifyOtpUseCaseProvider);
  LogoutUseCase get _logoutUseCase => ref.read(logoutUseCaseProvider);
  SignInWithGoogleUseCase get _signInWithGoogleUseCase =>
      ref.read(signInWithGoogleUseCaseProvider);

  @override
  AuthState build() {
    // Tự động kiểm tra phiên đăng nhập khi mở app
    Future.microtask(checkAuthStatus);

    return const AuthState();
  }

  Future<void> checkAuthStatus() async {
    final result = await _getCurrentUserUseCase();

    result.when(
      ok: (user) {
        if (user != null) {
          state = state.copyWith(status: AuthStatus.authenticated, user: user);
        } else {
          state = state.copyWith(status: AuthStatus.unauthenticated);
        }
      },
      err: (failure) {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      },
    );
  }

  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _loginUseCase(email: email.trim(), password: password);

    return result.when(
      ok: (user) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
        );
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message, isLoading: false);
        return false;
      },
    );
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _registerUseCase(
      fullName: fullName.trim(),
      email: email.trim().toLowerCase(),
      password: password,
    );

    return result.when(
      ok: (_) {
        state = state.copyWith(
          status: AuthStatus.otpSent,
          emailForOtp: email.trim().toLowerCase(),
          isLoading: false,
        );
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message, isLoading: false);
        return false;
      },
    );
  }

  Future<bool> verifyRegisterOtp({
    required String email,
    required String otp,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _verifyRegisterOtpUseCase(
      email: email.trim().toLowerCase(),
      otp: otp.trim(),
    );

    return result.when(
      ok: (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message, isLoading: false);
        return false;
      },
    );
  }

  Future<bool> forgotPassword(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _forgotPasswordUseCase(
      email: email.trim().toLowerCase(),
    );

    return result.when(
      ok: (_) {
        state = state.copyWith(
          emailForOtp: email.trim().toLowerCase(),
          isLoading: false,
        );
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message, isLoading: false);
        return false;
      },
    );
  }

  Future<bool> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _verifyForgotPasswordOtpUseCase(
      email: email.trim().toLowerCase(),
      otp: otp.trim(),
    );

    return result.when(
      ok: (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message, isLoading: false);
        return false;
      },
    );
  }

  Future<bool> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _resetPasswordUseCase(
      email: email.trim().toLowerCase(),
      newPassword: newPassword,
    );

    return result.when(
      ok: (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message, isLoading: false);
        return false;
      },
    );
  }

  Future<bool> sendOtp(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _sendOtpUseCase(email: email.trim().toLowerCase());

    return result.when(
      ok: (_) {
        state = state.copyWith(
          status: AuthStatus.otpSent,
          emailForOtp: email.trim().toLowerCase(),
          isLoading: false,
        );
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message, isLoading: false);
        return false;
      },
    );
  }

  Future<bool> verifyOtp({required String email, required String otp}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _verifyOtpUseCase(
      email: email.trim().toLowerCase(),
      otp: otp.trim(),
    );

    return result.when(
      ok: (user) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
        );
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message, isLoading: false);
        return false;
      },
    );
  }

  void resetOtp() {
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      clearError: true,
      isLoading: false,
    );
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _signInWithGoogleUseCase();

    return result.when(
      ok: (user) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
        );
        return true;
      },
      err: (failure) {
        final isCancelled = failure.message.toLowerCase().contains('hủy') ||
            failure.message.toLowerCase().contains('cancel');
        state = state.copyWith(
          errorMessage: isCancelled ? null : failure.message,
          isLoading: false,
        );
        return false;
      },
    );
  }

  void updateUser(UserEntity updatedUser) {
    state = state.copyWith(user: updatedUser);
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    await _logoutUseCase();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
