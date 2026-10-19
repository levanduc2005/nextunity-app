import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
abstract class CourseModel with _$CourseModel {
  const factory CourseModel({
    required String id,
    required String title,
    String? code,
    String? description,
    String? category,
    String? categoryName,
    @Default('BEGINNER') String difficulty,
    String? difficultyName,
    @JsonKey(name: 'thumbnailUrl') String? imageUrl,
    @Default(0) int totalLessons,
    @Default(0) int totalModules,
    @JsonKey(name: 'myProgressPercent', fromJson: _progressFromJson)
    @Default(0.0)
    double progress,
    @Default(false) bool isPremium,
    String? creatorName,
    @Default(false) bool isEnrolled,
    @Default(4.9) double rating,
    @Default(0) int reviewCount,
  }) = _CourseModel;

  const CourseModel._();

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
      code: code ?? 'FPT',
      title: title,
      description: description,
      category: category,
      categoryName: categoryName ?? category,
      difficulty: difficulty,
      difficultyName: difficultyName,
      imageUrl: imageUrl,
      totalLessons: totalLessons,
      totalModules: totalModules,
      progress: progress,
      isPremium: isPremium,
      creatorName: creatorName,
      isEnrolled: isEnrolled,
      rating: rating,
      reviewCount: reviewCount,
    );
  }
}

double _progressFromJson(dynamic val) {
  if (val == null) return 0.0;
  final num p = val as num;
  return (p > 1.0 ? p / 100.0 : p.toDouble()).clamp(0.0, 1.0);
}
