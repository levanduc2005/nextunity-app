// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EnrollmentModel _$EnrollmentModelFromJson(Map<String, dynamic> json) =>
    _EnrollmentModel(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      courseTitle: json['courseTitle'] as String,
      courseDescription: json['courseDescription'] as String?,
      courseThumbnailUrl: json['courseThumbnailUrl'] as String?,
      courseDifficulty: json['courseDifficulty'] as String? ?? 'BEGINNER',
      courseDifficultyName: json['courseDifficultyName'] as String?,
      totalLessons: (json['totalLessons'] as num?)?.toInt() ?? 0,
      progressPercent: (json['progressPercent'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'ACTIVE',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      instructorName: json['instructorName'] as String?,
      courseCode: json['courseCode'] as String?,
      currentLessonTitle: json['currentLessonTitle'] as String?,
    );

Map<String, dynamic> _$EnrollmentModelToJson(_EnrollmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'courseTitle': instance.courseTitle,
      'courseDescription': instance.courseDescription,
      'courseThumbnailUrl': instance.courseThumbnailUrl,
      'courseDifficulty': instance.courseDifficulty,
      'courseDifficultyName': instance.courseDifficultyName,
      'totalLessons': instance.totalLessons,
      'progressPercent': instance.progressPercent,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'instructorName': instance.instructorName,
      'courseCode': instance.courseCode,
      'currentLessonTitle': instance.currentLessonTitle,
    };
