// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) => _ModuleModel(
  id: json['id'] as String,
  courseId: json['courseId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 1,
  lessons:
      (json['lessons'] as List<dynamic>?)
          ?.map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ModuleModelToJson(_ModuleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'title': instance.title,
      'description': instance.description,
      'orderIndex': instance.orderIndex,
      'lessons': instance.lessons,
    };
