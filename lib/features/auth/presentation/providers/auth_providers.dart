import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:rental_car/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rental_car/features/auth/data/datasources/google_auth_service.dart';
import 'package:rental_car/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:rental_car/features/auth/domain/repositories/auth_repository.dart';
import 'package:rental_car/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/login_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/logout_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/register_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/verify_forgot_password_otp_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/verify_register_otp_usecase.dart';

// --- Data Layer Providers ---
final googleAuthServiceProvider = Provider<GoogleAuthService>((ref) {
  return GoogleAuthServiceImpl();
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final secureStore = ref.watch(secureStoreProvider);
  final keyValueStore = ref.watch(keyValueStoreProvider);

  return AuthLocalDataSourceImpl(
    secureStore: secureStore,
    keyValueStore: keyValueStore,
  );
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSourceImpl(dio: dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final googleAuthService = ref.watch(googleAuthServiceProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    googleAuthService: googleAuthService,
  );
});

// --- Domain Layer UseCase Providers ---
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final verifyRegisterOtpUseCaseProvider = Provider<VerifyRegisterOtpUseCase>((
  ref,
) {
  return VerifyRegisterOtpUseCase(ref.watch(authRepositoryProvider));
});

final forgotPasswordUseCaseProvider = Provider<ForgotPasswordUseCase>((ref) {
  return ForgotPasswordUseCase(ref.watch(authRepositoryProvider));
});

final verifyForgotPasswordOtpUseCaseProvider =
    Provider<VerifyForgotPasswordOtpUseCase>((ref) {
      return VerifyForgotPasswordOtpUseCase(ref.watch(authRepositoryProvider));
    });

final resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>((ref) {
  return ResetPasswordUseCase(ref.watch(authRepositoryProvider));
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.watch(authRepositoryProvider));
});

final sendOtpUseCaseProvider = Provider<SendOtpUseCase>((ref) {
  return SendOtpUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.watch(authRepositoryProvider));
});

final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((
  ref,
) {
  return SignInWithGoogleUseCase(ref.watch(authRepositoryProvider));
});
