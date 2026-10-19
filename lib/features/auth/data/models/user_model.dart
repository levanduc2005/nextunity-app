import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
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
    String? dateOfBirth,
    int? cohort,
    String? major,
    String? bio,
    String? role,
    @Default('FREE') String subscriptionTier,
    String? premiumUntil,
    @Default(false) bool isPlus,
    String? createdAt,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullName: fullName,
      university: university,
      studentId: studentId,
      avatarUrl: avatarUrl,
      points: points,
      streak: streak,
      gender: gender,
      genderName: genderName,
      dateOfBirth: dateOfBirth != null ? DateTime.tryParse(dateOfBirth!) : null,
      cohort: cohort,
      major: major,
      bio: bio,
      role: role ?? 'STUDENT',
      subscriptionTier: subscriptionTier,
      premiumUntil: premiumUntil != null
          ? DateTime.tryParse(premiumUntil!)
          : null,
      isPlus: isPlus,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    );
  }
}
