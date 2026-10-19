// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  email: json['email'] as String,
  id: json['id'] as String?,
  fullName: json['fullName'] as String?,
  university: json['university'] as String?,
  studentId: json['studentId'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  points: (json['points'] as num?)?.toInt() ?? 0,
  streak: (json['streak'] as num?)?.toInt() ?? 0,
  gender: json['gender'] as String?,
  genderName: json['genderName'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  cohort: (json['cohort'] as num?)?.toInt(),
  major: json['major'] as String?,
  bio: json['bio'] as String?,
  role: json['role'] as String?,
  subscriptionTier: json['subscriptionTier'] as String? ?? 'FREE',
  premiumUntil: json['premiumUntil'] as String?,
  isPlus: json['isPlus'] as bool? ?? false,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
      'fullName': instance.fullName,
      'university': instance.university,
      'studentId': instance.studentId,
      'avatarUrl': instance.avatarUrl,
      'points': instance.points,
      'streak': instance.streak,
      'gender': instance.gender,
      'genderName': instance.genderName,
      'dateOfBirth': instance.dateOfBirth,
      'cohort': instance.cohort,
      'major': instance.major,
      'bio': instance.bio,
      'role': instance.role,
      'subscriptionTier': instance.subscriptionTier,
      'premiumUntil': instance.premiumUntil,
      'isPlus': instance.isPlus,
      'createdAt': instance.createdAt,
    };
