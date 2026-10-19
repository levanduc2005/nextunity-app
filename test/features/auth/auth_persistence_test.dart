import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rental_car/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:rental_car/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rental_car/features/auth/data/models/user_model.dart';
import 'package:rental_car/features/auth/data/repositories/auth_repository_impl.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late MockAuthRemoteDataSource remoteDataSource;
  late MockAuthLocalDataSource localDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    localDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  const testUserModel = UserModel(
    email: 'student@fpt.edu.vn',
    fullName: 'Nguyen Van A',
    role: 'STUDENT',
  );

  group('Auth Persistence & Auto-Login Tests', () {
    test(
      'getCurrentUser returns null when no accessToken exists in SecureStore',
      () async {
        when(
          () => localDataSource.getAccessToken(),
        ).thenAnswer((_) async => null);

        final result = await repository.getCurrentUser();

        expect(result.isOk, isTrue);
        expect(result.valueOrNull, isNull);
        verify(() => localDataSource.getAccessToken()).called(1);
        verifyNever(() => localDataSource.getUser());
      },
    );

    test(
      'getCurrentUser returns cached user when token and cache are present',
      () async {
        when(
          () => localDataSource.getAccessToken(),
        ).thenAnswer((_) async => 'valid_access_token');
        when(
          () => localDataSource.getUser(),
        ).thenAnswer((_) async => testUserModel);

        final result = await repository.getCurrentUser();

        expect(result.isOk, isTrue);
        expect(result.valueOrNull?.email, equals('student@fpt.edu.vn'));
        verify(() => localDataSource.getAccessToken()).called(1);
        verify(() => localDataSource.getUser()).called(1);
        verifyNever(() => remoteDataSource.getCurrentUser());
      },
    );

    test(
      'getCurrentUser fetches from remote and updates cache when token exists but cache is null',
      () async {
        when(
          () => localDataSource.getAccessToken(),
        ).thenAnswer((_) async => 'valid_access_token');
        when(() => localDataSource.getUser()).thenAnswer((_) async => null);
        when(
          () => remoteDataSource.getCurrentUser(),
        ).thenAnswer((_) async => testUserModel);
        when(
          () => localDataSource.saveUser(testUserModel),
        ).thenAnswer((_) async {});

        final result = await repository.getCurrentUser();

        expect(result.isOk, isTrue);
        expect(result.valueOrNull?.email, equals('student@fpt.edu.vn'));
        verify(() => remoteDataSource.getCurrentUser()).called(1);
        verify(() => localDataSource.saveUser(testUserModel)).called(1);
      },
    );
  });
}
