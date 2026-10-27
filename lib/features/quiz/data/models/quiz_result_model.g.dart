// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizResultModel _$QuizResultModelFromJson(Map<String, dynamic> json) =>
    _QuizResultModel(
      submissionId: json['submissionId'] as String,
      quizId: json['quizId'] as String,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      totalPoints: (json['totalPoints'] as num?)?.toDouble() ?? 0.0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      isPassed: json['isPassed'] as bool? ?? false,
      timeSpentSeconds: (json['timeSpentSeconds'] as num?)?.toInt() ?? 0,
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      questionResults:
          (json['questionResults'] as List<dynamic>?)
              ?.map(
                (e) => QuestionResultModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$QuizResultModelToJson(_QuizResultModel instance) =>
    <String, dynamic>{
      'submissionId': instance.submissionId,
      'quizId': instance.quizId,
      'score': instance.score,
      'totalPoints': instance.totalPoints,
      'percentage': instance.percentage,
      'isPassed': instance.isPassed,
      'timeSpentSeconds': instance.timeSpentSeconds,
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'questionResults': instance.questionResults,
    };

_QuestionResultModel _$QuestionResultModelFromJson(Map<String, dynamic> json) =>
    _QuestionResultModel(
      questionId: json['questionId'] as String,
      content: json['content'] as String? ?? '',
      explanation: json['explanation'] as String?,
      points: (json['points'] as num?)?.toDouble() ?? 0.0,
      earnedPoints: (json['earnedPoints'] as num?)?.toDouble() ?? 0.0,
      isCorrect: json['isCorrect'] as bool? ?? false,
      selectedOptionIds:
          (json['selectedOptionIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      correctOptionIds:
          (json['correctOptionIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$QuestionResultModelToJson(
  _QuestionResultModel instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'content': instance.content,
  'explanation': instance.explanation,
  'points': instance.points,
  'earnedPoints': instance.earnedPoints,
  'isCorrect': instance.isCorrect,
  'selectedOptionIds': instance.selectedOptionIds,
  'correctOptionIds': instance.correctOptionIds,
};
