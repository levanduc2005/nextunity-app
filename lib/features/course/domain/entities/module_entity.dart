import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';

part 'module_entity.freezed.dart';

@freezed
abstract class ModuleEntity with _$ModuleEntity {
  const factory ModuleEntity({
    required String id,
    required String courseId,
    required String title,
    String? description,
    @Default(1) int orderIndex,
    @Default([]) List<LessonEntity> lessons,
  }) = _ModuleEntity;

  const ModuleEntity._();

  int get completedLessonsCount => lessons.where((l) => l.isCompleted).length;

  bool get isAllCompleted =>
      lessons.isNotEmpty && completedLessonsCount == lessons.length;
}
