import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_submission_summary_entity.freezed.dart';

@freezed
abstract class QuizSubmissionSummaryEntity with _$QuizSubmissionSummaryEntity {
  const factory QuizSubmissionSummaryEntity({
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
  }) = _QuizSubmissionSummaryEntity;

  const QuizSubmissionSummaryEntity._();
}
