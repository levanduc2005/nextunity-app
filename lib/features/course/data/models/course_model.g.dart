// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => _CourseModel(
  id: json['id'] as String,
  title: json['title'] as String,
  code: json['code'] as String?,
  description: json['description'] as String?,
  category: json['category'] as String?,
  categoryName: json['categoryName'] as String?,
  difficulty: json['difficulty'] as String? ?? 'BEGINNER',
  difficultyName: json['difficultyName'] as String?,
  imageUrl: json['thumbnailUrl'] as String?,
  totalLessons: (json['totalLessons'] as num?)?.toInt() ?? 0,
  totalModules: (json['totalModules'] as num?)?.toInt() ?? 0,
  progress: json['myProgressPercent'] == null
      ? 0.0
      : _progressFromJson(json['myProgressPercent']),
  isPremium: json['isPremium'] as bool? ?? false,
  creatorName: json['creatorName'] as String?,
  isEnrolled: json['isEnrolled'] as bool? ?? false,
  rating: (json['rating'] as num?)?.toDouble() ?? 4.9,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CourseModelToJson(_CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'code': instance.code,
      'description': instance.description,
      'category': instance.category,
      'categoryName': instance.categoryName,
      'difficulty': instance.difficulty,
      'difficultyName': instance.difficultyName,
      'thumbnailUrl': instance.imageUrl,
      'totalLessons': instance.totalLessons,
      'totalModules': instance.totalModules,
      'myProgressPercent': instance.progress,
      'isPremium': instance.isPremium,
      'creatorName': instance.creatorName,
      'isEnrolled': instance.isEnrolled,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
    };
