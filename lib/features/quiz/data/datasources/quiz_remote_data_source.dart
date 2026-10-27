import 'package:dio/dio.dart';
import 'package:rental_car/core/error/exceptions.dart';
import 'package:rental_car/core/network/api_handler.dart';
import 'package:rental_car/features/quiz/data/models/quiz_result_model.dart';
import 'package:rental_car/features/quiz/data/models/quiz_submission_summary_model.dart';
import 'package:rental_car/features/quiz/data/models/take_quiz_model.dart';

abstract interface class QuizRemoteDataSource {
  Future<TakeQuizModel> getQuizDetail(String quizId);

  Future<QuizResultModel> submitQuiz(
    String quizId, {
    required int timeSpentSeconds,
    required Map<String, List<String>> answers,
  });

  Future<List<QuizSubmissionSummaryModel>> getMySubmissions(String quizId);

  Future<QuizResultModel> getSubmissionDetail(String submissionId);
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  QuizRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<TakeQuizModel> getQuizDetail(String quizId) {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>('/quizzes/$quizId');
      final data = response.data?['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw const ParsingException('Không tìm thấy dữ liệu bài kiểm tra.');
      }
      return TakeQuizModel.fromJson(data);
    });
  }

  @override
  Future<QuizResultModel> submitQuiz(
    String quizId, {
    required int timeSpentSeconds,
    required Map<String, List<String>> answers,
  }) {
    return guardApiCall(() async {
      final formattedAnswers = answers.entries
          .where((entry) => entry.value.isNotEmpty)
          .map((entry) {
            return {'questionId': entry.key, 'selectedOptionIds': entry.value};
          })
          .toList();

      final payload = {
        'timeSpentSeconds': timeSpentSeconds,
        'answers': formattedAnswers,
      };

      final response = await _dio.post<Map<String, dynamic>>(
        '/quizzes/$quizId/submit',
        data: payload,
      );

      final rawData = response.data?['data'] ?? response.data;
      if (rawData is! Map<String, dynamic>) {
        throw const ParsingException('Không nhận được kết quả bài thi.');
      }
      return QuizResultModel.fromJson(rawData);
    });
  }

  @override
  Future<List<QuizSubmissionSummaryModel>> getMySubmissions(String quizId) {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/quizzes/$quizId/my-submissions',
      );
      final data = response.data?['data'];
      if (data is! List) {
        return const [];
      }
      return data
          .whereType<Map<String, dynamic>>()
          .map(QuizSubmissionSummaryModel.fromJson)
          .toList();
    });
  }

  @override
  Future<QuizResultModel> getSubmissionDetail(String submissionId) {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/submissions/$submissionId',
      );
      final rawData = response.data?['data'] ?? response.data;
      if (rawData is! Map<String, dynamic>) {
        throw const ParsingException('Không tìm thấy chi tiết bài nộp.');
      }
      return QuizResultModel.fromJson(rawData);
    });
  }
}
