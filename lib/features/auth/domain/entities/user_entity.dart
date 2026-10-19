import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String email,
    String? id,
    String? fullName,
    String? university,
    String? studentId,
    String? avatarUrl,
    @Default(0) int points,
    @Default(0) int streak,
    String? gender,
    String? genderName,
    DateTime? dateOfBirth,
    int? cohort,
    String? major,
    String? bio,
    @Default('STUDENT') String role,
    @Default('FREE') String subscriptionTier,
    DateTime? premiumUntil,
    @Default(false) bool isPlus,
    DateTime? createdAt,
  }) = _UserEntity;

  const UserEntity._();

  String get genderDisplayName =>
      genderName ??
      (gender != null && gender!.isNotEmpty ? gender! : 'Chưa cập nhật');

  String get displayName =>
      fullName?.trim().isNotEmpty == true ? fullName! : email.split('@').first;
}
