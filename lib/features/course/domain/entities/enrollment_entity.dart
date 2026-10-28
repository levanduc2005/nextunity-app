import 'package:freezed_annotation/freezed_annotation.dart';

part 'enrollment_entity.freezed.dart';

@freezed
abstract class EnrollmentEntity with _$EnrollmentEntity {
  const factory EnrollmentEntity({
    required String id,
    required String courseId,
    required String courseTitle,
    String? courseDescription,
    String? courseThumbnailUrl,
    @Default('BEGINNER') String courseDifficulty,
    String? courseDifficultyName,
    @Default(0) int totalLessons,
    @Default(0) int progressPercent,
    @Default('ENROLLED') String status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? instructorName,
    String? courseCode,
    String? currentLessonTitle,
  }) = _EnrollmentEntity;

  const EnrollmentEntity._();

  double get progressRatio => (progressPercent / 100.0).clamp(0.0, 1.0);

  bool get isCompleted =>
      status == 'COMPLETED' || progressPercent >= 100 || completedAt != null;
}
