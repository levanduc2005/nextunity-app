import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rental_car/core/error/failure.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/domain/repositories/profile_repository.dart';
import 'package:rental_car/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/check_password_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/upload_avatar_usecase.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository repository;
  late GetProfileUseCase getProfileUseCase;
  late UpdateProfileUseCase updateProfileUseCase;
  late UploadAvatarUseCase uploadAvatarUseCase;
  late CheckPasswordUseCase checkPasswordUseCase;
  late ChangePasswordUseCase changePasswordUseCase;

  setUp(() {
    repository = MockProfileRepository();
    getProfileUseCase = GetProfileUseCase(repository);
    updateProfileUseCase = UpdateProfileUseCase(repository);
    uploadAvatarUseCase = UploadAvatarUseCase(repository);
    checkPasswordUseCase = CheckPasswordUseCase(repository);
    changePasswordUseCase = ChangePasswordUseCase(repository);
  });

  const testUser = UserEntity(
    id: 'user-123',
    email: 'test@fpt.edu.vn',
    fullName: 'Nguyen Van A',
    studentId: 'SE123456',
    university: 'FPT University',
    avatarUrl: 'https://cloudinary.com/avatar.jpg',
    points: 150,
    streak: 7,
    isPlus: true,
  );

  group('Profile UseCases Test', () {
    test('GetProfileUseCase returns UserEntity when successful', () async {
      when(
        () => repository.getProfile(),
      ).thenAnswer((_) async => const Result.ok(testUser));

      final result = await getProfileUseCase();

      expect(result.isOk, isTrue);
      expect(result.valueOrNull, equals(testUser));
      verify(() => repository.getProfile()).called(1);
    });

    test(
      'UpdateProfileUseCase returns updated entity when successful',
      () async {
        when(
          () => repository.updateProfile(
            fullName: any(named: 'fullName'),
            university: any(named: 'university'),
            studentId: any(named: 'studentId'),
            avatarUrl: any(named: 'avatarUrl'),
            gender: any(named: 'gender'),
            dateOfBirth: any(named: 'dateOfBirth'),
            cohort: any(named: 'cohort'),
            major: any(named: 'major'),
            bio: any(named: 'bio'),
          ),
        ).thenAnswer((_) async => const Result.ok(testUser));

        final result = await updateProfileUseCase(
          fullName: 'Nguyen Van A',
          studentId: 'SE123456',
        );

        expect(result.isOk, isTrue);
        expect(result.valueOrNull?.studentId, equals('SE123456'));
      },
    );

    test('UploadAvatarUseCase returns image URL when successful', () async {
      const avatarUrl = 'https://cloudinary.com/avatar.jpg';
      when(
        () => repository.uploadAvatar(any()),
      ).thenAnswer((_) async => const Result.ok(avatarUrl));

      final result = await uploadAvatarUseCase('/tmp/avatar.png');

      expect(result.isOk, isTrue);
      expect(result.valueOrNull, equals(avatarUrl));
      verify(() => repository.uploadAvatar('/tmp/avatar.png')).called(1);
    });

    test('UploadAvatarUseCase returns Failure when upload fails', () async {
      when(() => repository.uploadAvatar(any())).thenAnswer(
        (_) async => const Result.err(
          ServerFailure(message: 'Upload to Cloudinary failed'),
        ),
      );

      final result = await uploadAvatarUseCase('/tmp/avatar.png');

      expect(result.isErr, isTrue);
      result.when(
        ok: (_) => fail('Should not be ok'),
        err: (failure) =>
            expect(failure.message, contains('Cloudinary failed')),
      );
    });

    test(
      'CheckPasswordUseCase returns success Result when password is correct',
      () async {
        when(
          () => repository.checkPassword('MySecretPass123!'),
        ).thenAnswer((_) async => const Result.ok(null));

        final result = await checkPasswordUseCase('MySecretPass123!');

        expect(result.isOk, isTrue);
        verify(() => repository.checkPassword('MySecretPass123!')).called(1);
      },
    );

    test(
      'CheckPasswordUseCase returns Failure when password is incorrect',
      () async {
        when(() => repository.checkPassword('WrongPass')).thenAnswer(
          (_) async => const Result.err(
            ServerFailure(message: 'Mật khẩu không chính xác'),
          ),
        );

        final result = await checkPasswordUseCase('WrongPass');

        expect(result.isErr, isTrue);
        result.when(
          ok: (_) => fail('Should not be ok'),
          err: (failure) =>
              expect(failure.message, contains('Mật khẩu không chính xác')),
        );
      },
    );

    test(
      'ChangePasswordUseCase returns success Result when changed successfully',
      () async {
        when(
          () => repository.changePassword(
            currentPassword: 'OldPass123!',
            newPassword: 'NewPass456!',
          ),
        ).thenAnswer((_) async => const Result.ok(null));

        final result = await changePasswordUseCase(
          currentPassword: 'OldPass123!',
          newPassword: 'NewPass456!',
        );

        expect(result.isOk, isTrue);
        verify(
          () => repository.changePassword(
            currentPassword: 'OldPass123!',
            newPassword: 'NewPass456!',
          ),
        ).called(1);
      },
    );
  });
}
