import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:rental_car/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:rental_car/features/profile/domain/repositories/profile_repository.dart';
import 'package:rental_car/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/check_password_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_controller.dart';

export 'profile_controller.dart';

// --- Data Layer Providers ---
final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  return ProfileRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(
    remoteDataSource: ref.watch(profileRemoteDataSourceProvider),
  );
});

// --- Domain Layer UseCase Providers ---
final getProfileUseCaseProvider = Provider<GetProfileUseCase>((ref) {
  return GetProfileUseCase(ref.watch(profileRepositoryProvider));
});

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  return UpdateProfileUseCase(ref.watch(profileRepositoryProvider));
});

final uploadAvatarUseCaseProvider = Provider<UploadAvatarUseCase>((ref) {
  return UploadAvatarUseCase(ref.watch(profileRepositoryProvider));
});

final checkPasswordUseCaseProvider = Provider<CheckPasswordUseCase>((ref) {
  return CheckPasswordUseCase(ref.watch(profileRepositoryProvider));
});

final changePasswordUseCaseProvider = Provider<ChangePasswordUseCase>((ref) {
  return ChangePasswordUseCase(ref.watch(profileRepositoryProvider));
});

// --- Presentation Layer Controller Provider ---
final profileControllerProvider =
    NotifierProvider<ProfileController, ProfileState>(ProfileController.new);
