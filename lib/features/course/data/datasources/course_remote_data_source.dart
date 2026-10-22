import 'package:dio/dio.dart';
import 'package:rental_car/core/network/api_handler.dart';
import 'package:rental_car/features/course/data/models/course_model.dart';
import 'package:rental_car/features/course/data/models/enrollment_model.dart';
import 'package:rental_car/features/course/data/models/lesson_model.dart';
import 'package:rental_car/features/course/data/models/module_model.dart';
import 'package:rental_car/features/course/domain/entities/course_filter_options_entity.dart';

abstract interface class CourseRemoteDataSource {
  Future<CourseFilterOptionsEntity> getFilterOptions();

  Future<List<CourseModel>> getCourses({
    String? category,
    String? difficulty,
    String? search,
  });

  Future<List<CourseModel>> getPopularCourses({int limit = 5});

  Future<List<EnrollmentModel>> getMyEnrollments();

  Future<CourseModel> getCourseDetail(String courseId);

  Future<EnrollmentModel> enrollCourse(String courseId);

  Future<List<ModuleModel>> getCourseModules(String courseId);

  Future<LessonModel> getLessonById(String lessonId);

  Future<int> updateLessonProgress(
    String lessonId, {
    required bool isCompleted,
  });
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  CourseRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<CourseFilterOptionsEntity> getFilterOptions() {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>('/courses/filters');
      final data = response.data?['data'];
      final categoriesMap = <String, String>{};
      final difficultiesMap = <String, String>{};

      if (data is Map<String, dynamic>) {
        final categoriesList = data['categories'];
        if (categoriesList is List) {
          for (final item in categoriesList) {
            if (item is Map) {
              final code = item['code']?.toString() ?? '';
              final name = item['displayName']?.toString() ?? code;
              if (code.isNotEmpty) categoriesMap[code] = name;
            }
          }
        }

        final difficultiesList = data['difficulties'];
        if (difficultiesList is List) {
          for (final item in difficultiesList) {
            if (item is Map) {
              final code = item['code']?.toString() ?? '';
              final name = item['displayName']?.toString() ?? code;
              if (code.isNotEmpty) difficultiesMap[code] = name;
            }
          }
        }
      }

      return CourseFilterOptionsEntity(
        categories: categoriesMap,
        difficulties: difficultiesMap,
      );
    });
  }

  @override
  Future<List<CourseModel>> getCourses({
    String? category,
    String? difficulty,
    String? search,
  }) {
    return guardApiCall(() async {
      final queryParams = <String, dynamic>{};
      if (category != null && category.isNotEmpty && category != 'Tất cả') {
        queryParams['category'] = category;
      }
      if (difficulty != null && difficulty.isNotEmpty) {
        queryParams['difficulty'] = difficulty;
      }
      if (search != null && search.trim().isNotEmpty) {
        queryParams['search'] = search.trim();
      }

      final response = await _dio.get<Map<String, dynamic>>(
        '/courses',
        queryParameters: queryParams,
      );

      final data = response.data?['data'];
      List<dynamic> list = [];
      if (data is Map<String, dynamic> && data['content'] is List) {
        list = data['content'] as List<dynamic>;
      } else if (data is List) {
        list = data;
      }

      return list
          .map((item) => CourseModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<List<CourseModel>> getPopularCourses({int limit = 5}) {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/courses/popular',
        queryParameters: {'limit': limit},
      );

      final data = response.data?['data'];
      List<dynamic> list = [];
      if (data is List) {
        list = data;
      } else if (data is Map<String, dynamic> && data['content'] is List) {
        list = data['content'] as List<dynamic>;
      }

      return list
          .map((item) => CourseModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<List<EnrollmentModel>> getMyEnrollments() {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/enrollments/my-courses',
      );
      final list = response.data?['data'] as List<dynamic>? ?? [];
      return list
          .map((item) => EnrollmentModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<CourseModel> getCourseDetail(String courseId) {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/courses/$courseId',
      );
      final data = response.data?['data'] as Map<String, dynamic>;
      return CourseModel.fromJson(data);
    });
  }

  @override
  Future<EnrollmentModel> enrollCourse(String courseId) {
    return guardApiCall(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '/courses/$courseId/enroll',
      );
      final data = response.data?['data'] as Map<String, dynamic>;
      return EnrollmentModel.fromJson(data);
    });
  }

  @override
  Future<List<ModuleModel>> getCourseModules(String courseId) {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/courses/$courseId',
      );
      final data = response.data?['data'] as Map<String, dynamic>;
      final rawModules = data['modules'] as List<dynamic>? ?? [];
      return rawModules
          .map((item) => ModuleModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<LessonModel> getLessonById(String lessonId) {
    return guardApiCall(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/lessons/$lessonId',
      );
      final data = response.data?['data'] as Map<String, dynamic>;
      return LessonModel.fromJson(data);
    });
  }

  @override
  Future<int> updateLessonProgress(
    String lessonId, {
    required bool isCompleted,
  }) {
    return guardApiCall(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '/lessons/$lessonId/progress',
        data: {'status': isCompleted ? 'COMPLETED' : 'IN_PROGRESS'},
      );
      final data = response.data?['data'] as Map<String, dynamic>?;
      return data?['courseProgressPercent'] as int? ?? (isCompleted ? 100 : 0);
    });
  }
}
