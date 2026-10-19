import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:rental_car/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';

enum ProfileStatus { initial, loading, success, failure }

/// Trạng thái UI thuần túy của màn hình Hồ Sơ (Profile UI Actions State).
/// Dữ liệu User được quản lý tập trung và duy nhất tại [currentUserProvider].
class ProfileState {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.isUpdating = false,
    this.updateSuccess = false,
    this.isUploadingAvatar = false,
  });

  final ProfileStatus status;
  final String? errorMessage;
  final bool isUpdating;
  final bool updateSuccess;
  final bool isUploadingAvatar;

  bool get isLoading => status == ProfileStatus.loading;

  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    bool? isUpdating,
    bool? updateSuccess,
    bool? isUploadingAvatar,
    bool clearError = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isUpdating: isUpdating ?? this.isUpdating,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      isUploadingAvatar: isUploadingAvatar ?? this.isUploadingAvatar,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  GetProfileUseCase get _getProfileUseCase =>
      ref.read(getProfileUseCaseProvider);
  UpdateProfileUseCase get _updateProfileUseCase =>
      ref.read(updateProfileUseCaseProvider);
  UploadAvatarUseCase get _uploadAvatarUseCase =>
      ref.read(uploadAvatarUseCaseProvider);

  @override
  ProfileState build() {
    return const ProfileState();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(status: ProfileStatus.loading, clearError: true);
    final result = await _getProfileUseCase();
    result.when(
      ok: (user) {
        state = state.copyWith(status: ProfileStatus.success, clearError: true);
        ref.read(authControllerProvider.notifier).updateUser(user);
      },
      err: (failure) {
        state = state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: failure.message,
        );
      },
    );
  }

  Future<void> refreshProfile() async {
    final result = await _getProfileUseCase();
    result.when(
      ok: (user) {
        state = state.copyWith(status: ProfileStatus.success, clearError: true);
        ref.read(authControllerProvider.notifier).updateUser(user);
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message);
      },
    );
  }

  Future<bool> updateProfile({
    String? fullName,
    String? university,
    String? studentId,
    String? avatarUrl,
    String? gender,
    DateTime? dateOfBirth,
    int? cohort,
    String? major,
    String? bio,
  }) async {
    state = state.copyWith(
      isUpdating: true,
      updateSuccess: false,
      clearError: true,
    );
    final result = await _updateProfileUseCase(
      fullName: fullName,
      university: university,
      studentId: studentId,
      avatarUrl: avatarUrl,
      gender: gender,
      dateOfBirth: dateOfBirth,
      cohort: cohort,
      major: major,
      bio: bio,
    );
    return result.when(
      ok: (updatedUser) {
        state = state.copyWith(isUpdating: false, updateSuccess: true);
        ref.read(authControllerProvider.notifier).updateUser(updatedUser);
        return true;
      },
      err: (failure) {
        state = state.copyWith(
          isUpdating: false,
          updateSuccess: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  /// Tải ảnh lên Cloudinary và tự động lưu `avatarUrl` mới vào Profile người dùng
  Future<bool> changeAvatar(String filePath) async {
    state = state.copyWith(isUploadingAvatar: true, clearError: true);

    // 1. Upload ảnh lên Cloudinary
    final uploadResult = await _uploadAvatarUseCase(filePath);

    return uploadResult.when(
      ok: (avatarUrl) async {
        // 2. Cập nhật avatarUrl vào Profile trên backend
        final updateResult = await _updateProfileUseCase(avatarUrl: avatarUrl);
        return updateResult.when(
          ok: (updatedUser) {
            state = state.copyWith(isUploadingAvatar: false);
            ref.read(authControllerProvider.notifier).updateUser(updatedUser);
            return true;
          },
          err: (failure) {
            state = state.copyWith(
              isUploadingAvatar: false,
              errorMessage: failure.message,
            );
            return false;
          },
        );
      },
      err: (failure) {
        state = state.copyWith(
          isUploadingAvatar: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }
}
