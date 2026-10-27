// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_submission_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizSubmissionSummaryModel _$QuizSubmissionSummaryModelFromJson(
  Map<String, dynamic> json,
) => _QuizSubmissionSummaryModel(
  id: json['id'] as String,
  quizId: json['quizId'] as String,
  userId: json['userId'] as String?,
  userName: json['userName'] as String?,
  score: (json['score'] as num?)?.toDouble() ?? 0.0,
  totalPoints: (json['totalPoints'] as num?)?.toDouble() ?? 0.0,
  percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
  isPassed: json['isPassed'] as bool? ?? false,
  timeSpentSeconds: (json['timeSpentSeconds'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$QuizSubmissionSummaryModelToJson(
  _QuizSubmissionSummaryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'quizId': instance.quizId,
  'userId': instance.userId,
  'userName': instance.userName,
  'score': instance.score,
  'totalPoints': instance.totalPoints,
  'percentage': instance.percentage,
  'isPassed': instance.isPassed,
  'timeSpentSeconds': instance.timeSpentSeconds,
  'createdAt': instance.createdAt?.toIso8601String(),
};
