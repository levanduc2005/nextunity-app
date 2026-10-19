import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/course/data/models/lesson_model.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';

part 'module_model.freezed.dart';
part 'module_model.g.dart';

@freezed
abstract class ModuleModel with _$ModuleModel {
  const factory ModuleModel({
    required String id,
    required String courseId,
    required String title,
    String? description,
    @Default(1) int orderIndex,
    @Default([]) List<LessonModel> lessons,
  }) = _ModuleModel;

  const ModuleModel._();

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);

  ModuleEntity toEntity() {
    return ModuleEntity(
      id: id,
      courseId: courseId,
      title: title,
      description: description,
      orderIndex: orderIndex,
      lessons: lessons.map((l) => l.toEntity()).toList(),
    );
  }
}
