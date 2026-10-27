import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_entity.freezed.dart';

@freezed
abstract class LessonEntity with _$LessonEntity {
  const factory LessonEntity({
    required String id,
    required String moduleId,
    required String title,
    @Default(1) int orderIndex,
    @Default(false) bool isCompleted,
    String? content,
    @Default('TEXT') String type,
    String? typeName,
    String? videoUrl,
    @Default(15) int estimatedMinutes,
    String? slideUrl,
    String? quizId,
    DateTime? createdAt,
  }) = _LessonEntity;

  const LessonEntity._();
}
