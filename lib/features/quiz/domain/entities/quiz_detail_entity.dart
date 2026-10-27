import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_detail_entity.freezed.dart';

@freezed
abstract class QuizDetailEntity with _$QuizDetailEntity {
  const factory QuizDetailEntity({
    required String id,
    required String lessonId,
    required String title,
    String? description,
    @Default(15) int durationMinutes,
    @Default(80) int passingScore,
    @Default(0) int totalQuestions,
    @Default([]) List<QuizQuestionEntity> questions,
  }) = _QuizDetailEntity;

  const QuizDetailEntity._();
}

@freezed
abstract class QuizQuestionEntity with _$QuizQuestionEntity {
  const factory QuizQuestionEntity({
    required String id,
    required String content,
    @Default('SINGLE_CHOICE') String type,
    @Default(10.0) double points,
    @Default(1) int orderIndex,
    @Default([]) List<QuizOptionEntity> options,
  }) = _QuizQuestionEntity;

  const QuizQuestionEntity._();
}

@freezed
abstract class QuizOptionEntity with _$QuizOptionEntity {
  const factory QuizOptionEntity({
    required String id,
    required String content,
    @Default(1) int orderIndex,
  }) = _QuizOptionEntity;

  const QuizOptionEntity._();
}
