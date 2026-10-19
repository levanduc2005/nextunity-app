import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';

part 'lesson_model.freezed.dart';
part 'lesson_model.g.dart';

@freezed
abstract class LessonModel with _$LessonModel {
  const factory LessonModel({
    required String id,
    required String title,
    @Default('') String moduleId,
    @Default(1) int orderIndex,
    @Default(false) bool isCompleted,
    String? content,
    @Default('TEXT') String type,
    String? typeName,
    String? videoUrl,
    @Default(15) int estimatedMinutes,
    String? slideUrl,
    DateTime? createdAt,
  }) = _LessonModel;

  const LessonModel._();

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  LessonEntity toEntity() {
    return LessonEntity(
      id: id,
      moduleId: moduleId,
      title: title,
      orderIndex: orderIndex,
      isCompleted: isCompleted,
      content: content,
      type: type,
      typeName: typeName,
      videoUrl: videoUrl,
      estimatedMinutes: estimatedMinutes,
      slideUrl: slideUrl,
      createdAt: createdAt,
    );
  }
}
