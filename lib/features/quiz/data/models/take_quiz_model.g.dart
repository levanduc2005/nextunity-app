// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'take_quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TakeQuizModel _$TakeQuizModelFromJson(Map<String, dynamic> json) =>
    _TakeQuizModel(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 15,
      passingScore: (json['passingScore'] as num?)?.toInt() ?? 80,
      totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 0,
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map(
                (e) => TakeQuestionModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TakeQuizModelToJson(_TakeQuizModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'title': instance.title,
      'description': instance.description,
      'durationMinutes': instance.durationMinutes,
      'passingScore': instance.passingScore,
      'totalQuestions': instance.totalQuestions,
      'questions': instance.questions,
    };

_TakeQuestionModel _$TakeQuestionModelFromJson(Map<String, dynamic> json) =>
    _TakeQuestionModel(
      id: json['id'] as String,
      content: json['content'] as String,
      type: json['type'] as String? ?? 'SINGLE_CHOICE',
      points: (json['points'] as num?)?.toDouble() ?? 10.0,
      orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 1,
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => TakeOptionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TakeQuestionModelToJson(_TakeQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': instance.type,
      'points': instance.points,
      'orderIndex': instance.orderIndex,
      'options': instance.options,
    };

_TakeOptionModel _$TakeOptionModelFromJson(Map<String, dynamic> json) =>
    _TakeOptionModel(
      id: json['id'] as String,
      content: json['content'] as String,
      orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$TakeOptionModelToJson(_TakeOptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'orderIndex': instance.orderIndex,
    };
