import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_result_entity.freezed.dart';

@freezed
abstract class QuizResultEntity with _$QuizResultEntity {
  const factory QuizResultEntity({
    required String submissionId,
    required String quizId,
    @Default(0.0) double score,
    @Default(0.0) double totalPoints,
    @Default(0.0) double percentage,
    @Default(false) bool isPassed,
    @Default(0) int timeSpentSeconds,
    DateTime? submittedAt,
    @Default([]) List<QuestionResultEntity> questionResults,
  }) = _QuizResultEntity;

  const QuizResultEntity._();
}

@freezed
abstract class QuestionResultEntity with _$QuestionResultEntity {
  const factory QuestionResultEntity({
    required String questionId,
    @Default('') String content,
    String? explanation,
    @Default(0.0) double points,
    @Default(0.0) double earnedPoints,
    @Default(false) bool isCorrect,
    @Default([]) List<String> selectedOptionIds,
    @Default([]) List<String> correctOptionIds,
  }) = _QuestionResultEntity;

  const QuestionResultEntity._();
}
