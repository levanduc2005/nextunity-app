import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rental_car/app/router/app_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/auth/domain/usecases/logout_usecase.dart';
import 'package:rental_car/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_providers.dart';

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

class _TestAuthController extends AuthController {
  final AuthState initialState;
  _TestAuthController(this.initialState);

  @override
  AuthState build() => initialState;
}

void main() {
  const testUser = UserEntity(
    id: '1',
    email: 'user@fpt.edu.vn',
    fullName: 'Test User',
  );

  group('Forgot Password Navigation & Auth Router Tests', () {
    test('appRouterRedirect allows forgotPassword when authenticated', () {
      const authState = AuthState(
        status: AuthStatus.authenticated,
        user: testUser,
      );

      // 1. forgotPassword when authenticated -> should return null (allowed, no redirect to home)
      final redirectForgot = appRouterRedirect(
        authState: authState,
        matchedLocation: AppRoute.forgotPassword.path,
      );
      expect(redirectForgot, isNull);

      // 2. resetPassword when authenticated -> should return null (allowed)
      final redirectReset = appRouterRedirect(
        authState: authState,
        matchedLocation: AppRoute.resetPassword.path,
      );
      expect(redirectReset, isNull);

      // 3. accountCreated when authenticated -> should return null (allowed)
      final redirectAccountCreated = appRouterRedirect(
        authState: authState,
        matchedLocation: AppRoute.accountCreated.path,
      );
      expect(redirectAccountCreated, isNull);

      // 4. login when authenticated -> should redirect to /home
      final redirectLogin = appRouterRedirect(
        authState: authState,
        matchedLocation: AppRoute.login.path,
      );
      expect(redirectLogin, equals(AppRoute.home.path));

      // 5. splash when authenticated -> should redirect to /home
      final redirectSplash = appRouterRedirect(
        authState: authState,
        matchedLocation: AppRoute.splash.path,
      );
      expect(redirectSplash, equals(AppRoute.home.path));
    });

    test('appRouterRedirect handles unauthenticated user correctly', () {
      const authState = AuthState(status: AuthStatus.unauthenticated);

      // 1. forgotPassword when unauthenticated -> should return null (allowed)
      final redirectForgot = appRouterRedirect(
        authState: authState,
        matchedLocation: AppRoute.forgotPassword.path,
      );
      expect(redirectForgot, isNull);

      // 2. home when unauthenticated -> should redirect to /login
      final redirectHome = appRouterRedirect(
        authState: authState,
        matchedLocation: AppRoute.home.path,
      );
      expect(redirectHome, equals(AppRoute.login.path));
    });

    test(
      'resetPassword logs out and sets unauthenticated state on success',
      () async {
        final mockReset = MockResetPasswordUseCase();
        final mockLogout = MockLogoutUseCase();

        when(
          () => mockReset(
            email: any(named: 'email'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenAnswer((_) async => const Result.ok(null));

        when(() => mockLogout()).thenAnswer((_) async => const Result.ok(null));

        final container = ProviderContainer(
          overrides: [
            resetPasswordUseCaseProvider.overrideWithValue(mockReset),
            logoutUseCaseProvider.overrideWithValue(mockLogout),
            authControllerProvider.overrideWith(
              () => _TestAuthController(
                const AuthState(
                  status: AuthStatus.authenticated,
                  user: testUser,
                ),
              ),
            ),
          ],
        );
        addTearDown(container.dispose);

        final controller = container.read(authControllerProvider.notifier);
        final success = await controller.resetPassword(
          email: 'user@fpt.edu.vn',
          newPassword: 'NewPassword123!',
        );

        expect(success, isTrue);
        expect(
          container.read(authControllerProvider).status,
          equals(AuthStatus.unauthenticated),
        );
        verify(() => mockLogout()).called(1);
      },
    );
  });
}
