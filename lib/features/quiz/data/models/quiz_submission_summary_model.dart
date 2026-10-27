import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_submission_summary_entity.dart';

part 'quiz_submission_summary_model.freezed.dart';
part 'quiz_submission_summary_model.g.dart';

@freezed
abstract class QuizSubmissionSummaryModel with _$QuizSubmissionSummaryModel {
  const factory QuizSubmissionSummaryModel({
    required String id,
    required String quizId,
    String? userId,
    String? userName,
    @Default(0.0) double score,
    @Default(0.0) double totalPoints,
    @Default(0.0) double percentage,
    @Default(false) bool isPassed,
    @Default(0) int timeSpentSeconds,
    DateTime? createdAt,
  }) = _QuizSubmissionSummaryModel;

  const QuizSubmissionSummaryModel._();

  factory QuizSubmissionSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$QuizSubmissionSummaryModelFromJson(json);

  QuizSubmissionSummaryEntity toEntity() {
    return QuizSubmissionSummaryEntity(
      id: id,
      quizId: quizId,
      userId: userId,
      userName: userName,
      score: score,
      totalPoints: totalPoints,
      percentage: percentage,
      isPassed: isPassed,
      timeSpentSeconds: timeSpentSeconds,
      createdAt: createdAt,
    );
  }
}
