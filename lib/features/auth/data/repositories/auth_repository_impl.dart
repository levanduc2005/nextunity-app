import 'package:rental_car/core/error/exceptions.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/core/utils/safe_call.dart';
import 'package:rental_car/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:rental_car/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rental_car/features/auth/data/datasources/google_auth_service.dart';
import 'package:rental_car/features/auth/domain/entities/auth_tokens.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final GoogleAuthService _googleAuthService;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    GoogleAuthService? googleAuthService,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _googleAuthService = googleAuthService ?? GoogleAuthServiceImpl();

  @override
  Future<Result<void>> register({
    required String fullName,
    required String email,
    required String password,
  }) {
    return safeCall(
      () => _remoteDataSource.register(
        fullName: fullName,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Result<void>> verifyRegisterOtp({
    required String email,
    required String otp,
  }) {
    return safeCall(
      () => _remoteDataSource.verifyRegisterOtp(email: email, otp: otp),
    );
  }

  @override
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  }) {
    return safeCall(() async {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      await _localDataSource.saveTokens(
        accessToken: result.tokens.accessToken,
        refreshToken: result.tokens.refreshToken,
      );

      await _localDataSource.saveUser(result.user);

      return result.user.toEntity();
    });
  }

  @override
  Future<Result<void>> forgotPassword({required String email}) {
    return safeCall(() => _remoteDataSource.forgotPassword(email: email));
  }

  @override
  Future<Result<void>> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) {
    return safeCall(
      () => _remoteDataSource.verifyForgotPasswordOtp(email: email, otp: otp),
    );
  }

  @override
  Future<Result<void>> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return safeCall(
      () => _remoteDataSource.resetPassword(
        email: email,
        newPassword: newPassword,
      ),
    );
  }

  @override
  Future<Result<UserEntity?>> getCurrentUser() {
    return safeCall(() async {
      final accessToken = await _localDataSource.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        return null;
      }

      final localUser = await _localDataSource.getUser();
      if (localUser != null) return localUser.toEntity();

      final remoteUser = await _remoteDataSource.getCurrentUser();
      await _localDataSource.saveUser(remoteUser);
      return remoteUser.toEntity();
    });
  }

  @override
  Future<Result<void>> logout() {
    return safeCall(() async {
      final refreshToken = await _localDataSource.getRefreshToken();
      try {
        await _remoteDataSource.logout(refreshToken: refreshToken);
      } finally {
        await _googleAuthService.signOut();
        await _localDataSource.clearTokens();
        await _localDataSource.clearUser();
      }
    });
  }

  @override
  Future<Result<AuthTokens>> refreshToken() {
    return safeCall(() async {
      final oldRefreshToken = await _localDataSource.getRefreshToken();
      if (oldRefreshToken == null || oldRefreshToken.isEmpty) {
        throw const ServerException(message: 'Không tìm thấy refresh token.');
      }

      final tokens = await _remoteDataSource.refreshToken(
        refreshToken: oldRefreshToken,
      );
      await _localDataSource.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken ?? oldRefreshToken,
      );

      return tokens.toEntity();
    });
  }

  @override
  Future<Result<void>> sendOtp({required String email}) {
    return safeCall(() => _remoteDataSource.sendOtp(email: email));
  }

  @override
  Future<Result<UserEntity>> signInWithGoogle() {
    return safeCall(() async {
      final auth = await _googleAuthService.signIn();
      if (auth == null) {
        throw const ServerException(message: 'Đăng nhập Google đã bị hủy.');
      }

      final idToken = auth.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw const ServerException(
          message: 'Không lấy được ID Token từ Google.',
        );
      }

      final result = await _remoteDataSource.loginWithGoogle(idToken: idToken);

      await _localDataSource.saveTokens(
        accessToken: result.tokens.accessToken,
        refreshToken: result.tokens.refreshToken,
      );

      final userModel = result.user ?? await _remoteDataSource.getCurrentUser();
      await _localDataSource.saveUser(userModel);

      return userModel.toEntity();
    });
  }
}
