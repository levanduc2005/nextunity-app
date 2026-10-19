// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => _LessonModel(
  id: json['id'] as String,
  title: json['title'] as String,
  moduleId: json['moduleId'] as String? ?? '',
  orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 1,
  isCompleted: json['isCompleted'] as bool? ?? false,
  content: json['content'] as String?,
  type: json['type'] as String? ?? 'TEXT',
  typeName: json['typeName'] as String?,
  videoUrl: json['videoUrl'] as String?,
  estimatedMinutes: (json['estimatedMinutes'] as num?)?.toInt() ?? 15,
  slideUrl: json['slideUrl'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$LessonModelToJson(_LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'moduleId': instance.moduleId,
      'orderIndex': instance.orderIndex,
      'isCompleted': instance.isCompleted,
      'content': instance.content,
      'type': instance.type,
      'typeName': instance.typeName,
      'videoUrl': instance.videoUrl,
      'estimatedMinutes': instance.estimatedMinutes,
      'slideUrl': instance.slideUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
