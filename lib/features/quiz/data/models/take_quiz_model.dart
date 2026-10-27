import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';

part 'take_quiz_model.freezed.dart';
part 'take_quiz_model.g.dart';

@freezed
abstract class TakeQuizModel with _$TakeQuizModel {
  const factory TakeQuizModel({
    required String id,
    required String lessonId,
    required String title,
    String? description,
    @Default(15) int durationMinutes,
    @Default(80) int passingScore,
    @Default(0) int totalQuestions,
    @Default([]) List<TakeQuestionModel> questions,
  }) = _TakeQuizModel;

  const TakeQuizModel._();

  factory TakeQuizModel.fromJson(Map<String, dynamic> json) =>
      _$TakeQuizModelFromJson(json);

  QuizDetailEntity toEntity() {
    return QuizDetailEntity(
      id: id,
      lessonId: lessonId,
      title: title,
      description: description,
      durationMinutes: durationMinutes,
      passingScore: passingScore,
      totalQuestions: totalQuestions,
      questions: questions.map((q) => q.toEntity()).toList(),
    );
  }
}

@freezed
abstract class TakeQuestionModel with _$TakeQuestionModel {
  const factory TakeQuestionModel({
    required String id,
    required String content,
    @Default('SINGLE_CHOICE') String type,
    @Default(10.0) double points,
    @Default(1) int orderIndex,
    @Default([]) List<TakeOptionModel> options,
  }) = _TakeQuestionModel;

  const TakeQuestionModel._();

  factory TakeQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$TakeQuestionModelFromJson(json);

  QuizQuestionEntity toEntity() {
    return QuizQuestionEntity(
      id: id,
      content: content,
      type: type,
      points: points,
      orderIndex: orderIndex,
      options: options.map((o) => o.toEntity()).toList(),
    );
  }
}

@freezed
abstract class TakeOptionModel with _$TakeOptionModel {
  const factory TakeOptionModel({
    required String id,
    required String content,
    @Default(1) int orderIndex,
  }) = _TakeOptionModel;

  const TakeOptionModel._();

  factory TakeOptionModel.fromJson(Map<String, dynamic> json) =>
      _$TakeOptionModelFromJson(json);

  QuizOptionEntity toEntity() {
    return QuizOptionEntity(id: id, content: content, orderIndex: orderIndex);
  }
}
