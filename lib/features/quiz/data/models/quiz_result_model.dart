import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';

part 'quiz_result_model.freezed.dart';
part 'quiz_result_model.g.dart';

@freezed
abstract class QuizResultModel with _$QuizResultModel {
  const factory QuizResultModel({
    required String submissionId,
    required String quizId,
    @Default(0.0) double score,
    @Default(0.0) double totalPoints,
    @Default(0.0) double percentage,
    @Default(false) bool isPassed,
    @Default(0) int timeSpentSeconds,
    DateTime? submittedAt,
    @Default([]) List<QuestionResultModel> questionResults,
  }) = _QuizResultModel;

  const QuizResultModel._();

  factory QuizResultModel.fromJson(Map<String, dynamic> json) =>
      _$QuizResultModelFromJson(json);

  QuizResultEntity toEntity() {
    return QuizResultEntity(
      submissionId: submissionId,
      quizId: quizId,
      score: score,
      totalPoints: totalPoints,
      percentage: percentage,
      isPassed: isPassed,
      timeSpentSeconds: timeSpentSeconds,
      submittedAt: submittedAt,
      questionResults: questionResults.map((q) => q.toEntity()).toList(),
    );
  }
}

@freezed
abstract class QuestionResultModel with _$QuestionResultModel {
  const factory QuestionResultModel({
    required String questionId,
    @Default('') String content,
    String? explanation,
    @Default(0.0) double points,
    @Default(0.0) double earnedPoints,
    @Default(false) bool isCorrect,
    @Default([]) List<String> selectedOptionIds,
    @Default([]) List<String> correctOptionIds,
  }) = _QuestionResultModel;

  const QuestionResultModel._();

  factory QuestionResultModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionResultModelFromJson(json);

  QuestionResultEntity toEntity() {
    return QuestionResultEntity(
      questionId: questionId,
      content: content,
      explanation: explanation,
      points: points,
      earnedPoints: earnedPoints,
      isCorrect: isCorrect,
      selectedOptionIds: selectedOptionIds,
      correctOptionIds: correctOptionIds,
    );
  }
}
