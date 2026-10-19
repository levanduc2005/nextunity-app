import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';

part 'enrollment_model.freezed.dart';
part 'enrollment_model.g.dart';

@freezed
abstract class EnrollmentModel with _$EnrollmentModel {
  const factory EnrollmentModel({
    required String id,
    required String courseId,
    required String courseTitle,
    String? courseDescription,
    String? courseThumbnailUrl,
    @Default('BEGINNER') String courseDifficulty,
    String? courseDifficultyName,
    @Default(0) int totalLessons,
    @Default(0) int progressPercent,
    @Default('ACTIVE') String status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? instructorName,
    String? courseCode,
    String? currentLessonTitle,
  }) = _EnrollmentModel;

  const EnrollmentModel._();

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentModelFromJson(json);

  EnrollmentEntity toEntity() {
    return EnrollmentEntity(
      id: id,
      courseId: courseId,
      courseTitle: courseTitle,
      courseDescription: courseDescription,
      courseThumbnailUrl: courseThumbnailUrl,
      courseDifficulty: courseDifficulty,
      courseDifficultyName: courseDifficultyName,
      totalLessons: totalLessons,
      progressPercent: progressPercent,
      status: status,
      createdAt: createdAt,
      completedAt: completedAt,
      instructorName: instructorName,
      courseCode: courseCode ?? 'FPT',
      currentLessonTitle: currentLessonTitle,
    );
  }
}
