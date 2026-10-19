import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_entity.freezed.dart';

@freezed
abstract class CourseEntity with _$CourseEntity {
  const factory CourseEntity({
    required String id,
    required String code,
    required String title,
    String? description,
    String? category,
    String? categoryName,
    @Default('BEGINNER') String difficulty,
    String? difficultyName,
    String? imageUrl,
    @Default(0) int totalLessons,
    @Default(0) int totalModules,
    @Default(0.0) double progress,
    @Default(false) bool isPremium,
    String? creatorName,
    @Default(false) bool isEnrolled,
    @Default(4.9) double rating,
    @Default(0) int reviewCount,
  }) = _CourseEntity;

  const CourseEntity._();
}
