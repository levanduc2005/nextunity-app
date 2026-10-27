import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rental_car/core/error/exceptions.dart';
import 'package:rental_car/core/error/failure.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/storage/key_value_store.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/course_filter_options_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/quiz/data/datasources/quiz_remote_data_source.dart';
import 'package:rental_car/features/quiz/data/models/quiz_result_model.dart';
import 'package:rental_car/features/quiz/data/models/take_quiz_model.dart';
import 'package:rental_car/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_submission_summary_entity.dart';
import 'package:rental_car/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:rental_car/features/quiz/domain/usecases/get_my_quiz_submissions_usecase.dart';
import 'package:rental_car/features/quiz/domain/usecases/get_quiz_detail_usecase.dart';
import 'package:rental_car/features/quiz/domain/usecases/get_quiz_submission_detail_usecase.dart';
import 'package:rental_car/features/quiz/domain/usecases/submit_quiz_usecase.dart';
import 'package:rental_car/features/quiz/presentation/pages/quiz_submission_detail_page.dart';
import 'package:rental_car/features/quiz/presentation/providers/quiz_providers.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_exit_modal.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_option_tile.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_progress_bar.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_question_card.dart';
import 'package:rental_car/features/quiz/presentation/widgets/history/quiz_submissions_history_modal.dart';

class MockQuizRepository extends Mock implements QuizRepository {}

class MockQuizRemoteDataSource extends Mock implements QuizRemoteDataSource {}

class MockCourseRepository extends Mock implements CourseRepository {}

class FakeKeyValueStore implements KeyValueStore {
  final Map<String, dynamic> _data = {};

  @override
  Future<String?> getString(String key) async => _data[key] as String?;

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool?> getBool(String key) async => _data[key] as bool?;

  @override
  Future<bool> setBool(String key, {required bool value}) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }
}

void main() {
  const testQuizDetail = QuizDetailEntity(
    id: 'quiz-1',
    lessonId: 'lesson-1',
    title: 'Kiểm tra chương 1',
    description: 'Bài kiểm tra kiến thức',
    totalQuestions: 2,
    questions: [
      QuizQuestionEntity(
        id: 'q-1',
        content: 'Flutter là gì?',
        options: [
          QuizOptionEntity(id: 'opt-1', content: 'Framework UI'),
          QuizOptionEntity(id: 'opt-2', content: 'Database', orderIndex: 2),
        ],
      ),
      QuizQuestionEntity(
        id: 'q-2',
        content: 'Dart là gì?',
        type: 'MULTIPLE_CHOICE',
        orderIndex: 2,
        options: [
          QuizOptionEntity(id: 'opt-3', content: 'Ngôn ngữ OOP'),
          QuizOptionEntity(id: 'opt-4', content: 'Type-safe', orderIndex: 2),
        ],
      ),
    ],
  );

  const testQuizResult = QuizResultEntity(
    submissionId: 'sub-1',
    quizId: 'quiz-1',
    score: 20,
    totalPoints: 20,
    percentage: 100,
    isPassed: true,
    timeSpentSeconds: 120,
  );

  group('Quiz UseCases Tests', () {
    late MockQuizRepository repository;
    late GetQuizDetailUseCase getQuizDetailUseCase;
    late SubmitQuizUseCase submitQuizUseCase;

    setUp(() {
      repository = MockQuizRepository();
      getQuizDetailUseCase = GetQuizDetailUseCase(repository);
      submitQuizUseCase = SubmitQuizUseCase(repository);
    });

    test('GetQuizDetailUseCase returns QuizDetailEntity on success', () async {
      when(
        () => repository.getQuizDetail('quiz-1'),
      ).thenAnswer((_) async => const Result.ok(testQuizDetail));

      final result = await getQuizDetailUseCase.call('quiz-1');

      expect(result, isA<Ok<QuizDetailEntity>>());
      result.when(
        ok: (quiz) {
          expect(quiz.id, equals('quiz-1'));
          expect(quiz.title, equals('Kiểm tra chương 1'));
          expect(quiz.questions.length, equals(2));
        },
        err: (_) => fail('Expected Ok but got Err'),
      );
    });

    test('GetQuizDetailUseCase returns Failure on error', () async {
      when(() => repository.getQuizDetail('quiz-1')).thenAnswer(
        (_) async =>
            const Result.err(ServerFailure(message: 'Không tìm thấy bài thi')),
      );

      final result = await getQuizDetailUseCase.call('quiz-1');

      expect(result, isA<Err<QuizDetailEntity>>());
      result.when(
        ok: (_) => fail('Expected Err but got Ok'),
        err: (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, equals('Không tìm thấy bài thi'));
        },
      );
    });

    test('SubmitQuizUseCase returns QuizResultEntity on success', () async {
      when(
        () => repository.submitQuiz(
          'quiz-1',
          timeSpentSeconds: 120,
          answers: {
            'q-1': ['opt-1'],
          },
        ),
      ).thenAnswer((_) async => const Result.ok(testQuizResult));

      final result = await submitQuizUseCase.call(
        'quiz-1',
        timeSpentSeconds: 120,
        answers: {
          'q-1': ['opt-1'],
        },
      );

      expect(result, isA<Ok<QuizResultEntity>>());
      result.when(
        ok: (res) {
          expect(res.isPassed, isTrue);
          expect(res.percentage, equals(100));
        },
        err: (_) => fail('Expected Ok but got Err'),
      );
    });
  });

  group('QuizRepositoryImpl Tests', () {
    late MockQuizRemoteDataSource remoteDataSource;
    late QuizRepositoryImpl repository;

    setUp(() {
      remoteDataSource = MockQuizRemoteDataSource();
      repository = QuizRepositoryImpl(remoteDataSource: remoteDataSource);
    });

    test('getQuizDetail maps model to entity successfully', () async {
      const model = TakeQuizModel(
        id: 'quiz-1',
        lessonId: 'lesson-1',
        title: 'Kiểm tra chương 1',
        totalQuestions: 1,
        questions: [
          TakeQuestionModel(
            id: 'q-1',
            content: 'Câu hỏi 1',
            options: [TakeOptionModel(id: 'opt-1', content: 'Lựa chọn A')],
          ),
        ],
      );

      when(
        () => remoteDataSource.getQuizDetail('quiz-1'),
      ).thenAnswer((_) async => model);

      final result = await repository.getQuizDetail('quiz-1');

      expect(result, isA<Ok<QuizDetailEntity>>());
      result.when(
        ok: (entity) {
          expect(entity.id, equals('quiz-1'));
          expect(entity.questions.first.content, equals('Câu hỏi 1'));
        },
        err: (_) => fail('Expected Ok'),
      );
    });

    test('getQuizDetail maps ServerException to ServerFailure', () async {
      when(
        () => remoteDataSource.getQuizDetail('quiz-1'),
      ).thenThrow(const ServerException(message: 'Lỗi máy chủ'));

      final result = await repository.getQuizDetail('quiz-1');

      expect(result, isA<Err<QuizDetailEntity>>());
      result.when(
        ok: (_) => fail('Expected Err'),
        err: (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, equals('Lỗi máy chủ'));
        },
      );
    });

    test('submitQuiz maps model to entity successfully', () async {
      const model = QuizResultModel(
        submissionId: 'sub-1',
        quizId: 'quiz-1',
        score: 20,
        totalPoints: 20,
        percentage: 100,
        isPassed: true,
        timeSpentSeconds: 60,
      );

      when(
        () => remoteDataSource.submitQuiz(
          'quiz-1',
          timeSpentSeconds: 60,
          answers: {
            'q-1': ['opt-1'],
          },
        ),
      ).thenAnswer((_) async => model);

      final result = await repository.submitQuiz(
        'quiz-1',
        timeSpentSeconds: 60,
        answers: {
          'q-1': ['opt-1'],
        },
      );

      expect(result, isA<Ok<QuizResultEntity>>());
      result.when(
        ok: (res) {
          expect(res.submissionId, equals('sub-1'));
          expect(res.score, equals(20));
          expect(res.totalPoints, equals(20));
          expect(res.isPassed, isTrue);
        },
        err: (_) => fail('Expected Ok'),
      );
    });

    test(
      'QuizResultModel.fromJson correctly deserializes backend JSON payload with score and totalPoints',
      () {
        final json = {
          'submissionId': 'sub-uuid-123',
          'quizId': 'quiz-uuid-456',
          'score': 10.0,
          'totalPoints': 20.0,
          'percentage': 50.0,
          'isPassed': false,
          'timeSpentSeconds': 120,
          'submittedAt': '2026-10-27T10:30:00Z',
          'questionResults': [
            {
              'questionId': 'q-1',
              'content': 'Question 1',
              'points': 10.0,
              'earnedPoints': 0.0,
              'isCorrect': false,
              'selectedOptionIds': ['opt-1'],
              'correctOptionIds': ['opt-2'],
            },
          ],
        };

        final model = QuizResultModel.fromJson(json);

        expect(model.submissionId, equals('sub-uuid-123'));
        expect(model.score, equals(10.0));
        expect(model.totalPoints, equals(20.0));
        expect(model.percentage, equals(50.0));
        expect(model.isPassed, isFalse);
        expect(model.questionResults.length, equals(1));
        expect(model.questionResults.first.points, equals(10.0));
        expect(model.questionResults.first.isCorrect, isFalse);
      },
    );
  });

  group('QuizController Tests', () {
    test('loads quiz successfully and handles answering flow', () async {
      final mockRepo = MockQuizRepository();
      when(
        () => mockRepo.getQuizDetail('quiz-1'),
      ).thenAnswer((_) async => const Result.ok(testQuizDetail));
      when(
        () => mockRepo.submitQuiz(
          'quiz-1',
          timeSpentSeconds: any(named: 'timeSpentSeconds'),
          answers: any(named: 'answers'),
        ),
      ).thenAnswer((_) async => const Result.ok(testQuizResult));

      final mockCourseRepo = MockCourseRepository();
      when(
        () => mockCourseRepo.getFilterOptions(),
      ).thenAnswer((_) async => const Result.ok(CourseFilterOptionsEntity()));
      when(
        () => mockCourseRepo.getMyEnrollments(),
      ).thenAnswer((_) async => const Result.ok([]));
      when(
        () => mockCourseRepo.getCourses(
          category: any(named: 'category'),
          difficulty: any(named: 'difficulty'),
          search: any(named: 'search'),
        ),
      ).thenAnswer((_) async => const Result.ok([]));
      when(
        () => mockCourseRepo.getPopularCourses(),
      ).thenAnswer((_) async => const Result.ok([]));

      final container = ProviderContainer(
        overrides: [
          quizRepositoryProvider.overrideWithValue(mockRepo),
          courseRepositoryProvider.overrideWithValue(mockCourseRepo),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(quizControllerProvider.notifier);

      // Initial state
      expect(container.read(quizControllerProvider).isLoading, isFalse);
      expect(container.read(quizControllerProvider).quiz, isNull);

      // Load quiz
      await controller.loadQuiz('quiz-1');
      var state = container.read(quizControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.quiz?.id, equals('quiz-1'));
      expect(state.currentQuestionIndex, equals(0));
      expect(state.answeredCount, equals(0));

      // Select single choice option
      controller.selectOption('q-1', 'opt-1');
      state = container.read(quizControllerProvider);
      expect(state.selectedOptionIds['q-1'], equals(['opt-1']));
      expect(state.answeredCount, equals(1));

      // Navigate next
      controller.nextQuestion();
      state = container.read(quizControllerProvider);
      expect(state.currentQuestionIndex, equals(1));
      expect(state.answeredCount, equals(1));

      // Select multi choice option
      controller.selectOption('q-2', 'opt-3', isMultiChoice: true);
      controller.selectOption('q-2', 'opt-4', isMultiChoice: true);
      state = container.read(quizControllerProvider);
      expect(state.selectedOptionIds['q-2'], equals(['opt-3', 'opt-4']));
      expect(state.answeredCount, equals(2));

      // Toggle multi choice option to remove
      controller.selectOption('q-2', 'opt-4', isMultiChoice: true);
      state = container.read(quizControllerProvider);
      expect(state.selectedOptionIds['q-2'], equals(['opt-3']));
      expect(state.answeredCount, equals(2));

      // Timer update
      controller.updateTimeSpent(45);
      state = container.read(quizControllerProvider);
      expect(state.timeSpentSeconds, equals(45));

      // Submit
      final success = await controller.submitQuiz();
      expect(success, isTrue);
      state = container.read(quizControllerProvider);
      expect(state.isSubmitted, isTrue);
      expect(state.result?.isPassed, isTrue);

      await Future<void>.delayed(const Duration(milliseconds: 50));

      // Restart
      controller.restartQuiz();
      state = container.read(quizControllerProvider);
      expect(state.isSubmitted, isFalse);
      expect(state.currentQuestionIndex, equals(0));
      expect(state.selectedOptionIds, isEmpty);
      expect(state.answeredCount, equals(0));
      expect(state.result, isNull);

      await Future<void>.delayed(const Duration(milliseconds: 50));
    });

    test(
      'submitting a passed quiz immediately marks lesson completed',
      () async {
        final mockRepo = MockQuizRepository();
        when(
          () => mockRepo.getQuizDetail('quiz-1'),
        ).thenAnswer((_) async => const Result.ok(testQuizDetail));
        when(
          () => mockRepo.submitQuiz(
            'quiz-1',
            timeSpentSeconds: any(named: 'timeSpentSeconds'),
            answers: any(named: 'answers'),
          ),
        ).thenAnswer((_) async => const Result.ok(testQuizResult));

        final mockCourseRepo = MockCourseRepository();
        when(
          () => mockCourseRepo.getFilterOptions(),
        ).thenAnswer((_) async => const Result.ok(CourseFilterOptionsEntity()));
        when(
          () => mockCourseRepo.getMyEnrollments(),
        ).thenAnswer((_) async => const Result.ok([]));
        when(
          () => mockCourseRepo.getCourses(
            category: any(named: 'category'),
            difficulty: any(named: 'difficulty'),
            search: any(named: 'search'),
          ),
        ).thenAnswer((_) async => const Result.ok([]));
        when(
          () => mockCourseRepo.getPopularCourses(),
        ).thenAnswer((_) async => const Result.ok([]));

        final container = ProviderContainer(
          overrides: [
            quizRepositoryProvider.overrideWithValue(mockRepo),
            courseRepositoryProvider.overrideWithValue(mockCourseRepo),
          ],
        );
        addTearDown(container.dispose);

        final controller = container.read(quizControllerProvider.notifier);
        await controller.loadQuiz('quiz-1');

        final success = await controller.submitQuiz();
        expect(success, isTrue);

        final lessonDetailState = container.read(
          lessonDetailControllerProvider,
        );
        expect(lessonDetailState.isCompleted, isTrue);

        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
    );

    test(
      'automatically saves unsubmitted draft and restores progress on next load',
      () async {
        final mockRepo = MockQuizRepository();
        when(
          () => mockRepo.getQuizDetail('quiz-1'),
        ).thenAnswer((_) async => const Result.ok(testQuizDetail));
        when(
          () => mockRepo.submitQuiz(
            'quiz-1',
            timeSpentSeconds: any(named: 'timeSpentSeconds'),
            answers: any(named: 'answers'),
          ),
        ).thenAnswer((_) async => const Result.ok(testQuizResult));

        final mockCourseRepo = MockCourseRepository();
        when(
          () => mockCourseRepo.getFilterOptions(),
        ).thenAnswer((_) async => const Result.ok(CourseFilterOptionsEntity()));
        when(
          () => mockCourseRepo.getMyEnrollments(),
        ).thenAnswer((_) async => const Result.ok([]));
        when(
          () => mockCourseRepo.getCourses(
            category: any(named: 'category'),
            difficulty: any(named: 'difficulty'),
            search: any(named: 'search'),
          ),
        ).thenAnswer((_) async => const Result.ok([]));
        when(
          () => mockCourseRepo.getPopularCourses(),
        ).thenAnswer((_) async => const Result.ok([]));

        final fakeStore = FakeKeyValueStore();

        // 1. First session: student answers 1 question and moves to next
        final container1 = ProviderContainer(
          overrides: [
            quizRepositoryProvider.overrideWithValue(mockRepo),
            keyValueStoreProvider.overrideWithValue(fakeStore),
            courseRepositoryProvider.overrideWithValue(mockCourseRepo),
          ],
        );

        final controller1 = container1.read(quizControllerProvider.notifier);
        await controller1.loadQuiz('quiz-1');
        controller1.selectOption('q-1', 'opt-1');
        controller1.nextQuestion();

        // Ensure draft was stored in fakeStore
        final draftJson = await fakeStore.getString('quiz_draft_quiz-1');
        expect(draftJson, isNotNull);
        expect(draftJson, contains('opt-1'));

        // 2. Second session: student returns to quiz later in a fresh container
        final container2 = ProviderContainer(
          overrides: [
            quizRepositoryProvider.overrideWithValue(mockRepo),
            keyValueStoreProvider.overrideWithValue(fakeStore),
            courseRepositoryProvider.overrideWithValue(mockCourseRepo),
          ],
        );

        final controller2 = container2.read(quizControllerProvider.notifier);
        await controller2.loadQuiz('quiz-1');
        final state2 = container2.read(quizControllerProvider);

        // Progress and answer are restored seamlessly!
        expect(state2.selectedOptionIds['q-1'], equals(['opt-1']));
        expect(state2.currentQuestionIndex, equals(1));
        expect(state2.answeredCount, equals(1));

        // 3. Submit quiz: draft is cleared
        await controller2.submitQuiz();
        final draftAfterSubmit = await fakeStore.getString('quiz_draft_quiz-1');
        expect(draftAfterSubmit, isNull);

        // Allow microtasks from coursesController.refresh() to settle before disposing
        await Future<void>.delayed(const Duration(milliseconds: 80));
        container1.dispose();
        container2.dispose();
      },
    );
  });

  group('QuizProgressBar Tests', () {
    testWidgets(
      'progress percentage only counts answered questions, not current index',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: QuizProgressBar(
                currentIndex: 4, // User is at Question 5
                totalQuestions: 10,
                answeredCount: 0, // But has answered 0 questions
              ),
            ),
          ),
        );
        await tester.pump();

        expect(find.text('05 / 10'), findsOneWidget);
        expect(find.text('0 đã làm'), findsOneWidget);

        // When 2 questions are answered
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: QuizProgressBar(
                currentIndex: 4,
                totalQuestions: 10,
                answeredCount: 2,
              ),
            ),
          ),
        );
        await tester.pump();

        expect(find.text('05 / 10'), findsOneWidget);
        expect(find.text('2 đã làm'), findsOneWidget);
      },
    );
  });

  group('QuizOptionTile & BottomBar Widget Tests', () {
    testWidgets('QuizOptionTile renders unselected and selected states', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                QuizOptionTile(
                  content: 'Vector Networks',
                  isSelected: false,
                  onTap: () {},
                ),
                QuizOptionTile(
                  content: 'Auto Layout',
                  isSelected: true,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Vector Networks'), findsOneWidget);
      expect(find.text('Auto Layout'), findsOneWidget);
    });

    testWidgets('QuizQuestionCard renders Câu 1 label and no points', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuizQuestionCard(
              questionNumber: 1,
              content: 'What is Clean Architecture?',
              isMultiChoice: true,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Câu 1'), findsOneWidget);
      expect(find.text('Chọn nhiều đáp án'), findsOneWidget);
      expect(find.text('What is Clean Architecture?'), findsOneWidget);
      expect(find.textContaining('điểm'), findsNothing);
    });

    testWidgets('QuizExitModal renders progress and buttons correctly', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuizExitModal(answeredCount: 4, totalQuestions: 10),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Thoát bài kiểm tra?'), findsOneWidget);
      expect(find.text('4/10 câu'), findsOneWidget);
      expect(find.text('Thoát bài'), findsOneWidget);
      expect(find.text('Tiếp tục làm bài'), findsOneWidget);
    });
  });

  group('Quiz Submission Tests', () {
    late MockQuizRepository repository;
    late GetMyQuizSubmissionsUseCase getMySubmissionsUseCase;
    late GetQuizSubmissionDetailUseCase getSubmissionDetailUseCase;

    setUp(() {
      repository = MockQuizRepository();
      getMySubmissionsUseCase = GetMyQuizSubmissionsUseCase(repository);
      getSubmissionDetailUseCase = GetQuizSubmissionDetailUseCase(repository);
    });

    test('GetMyQuizSubmissionsUseCase returns list on success', () async {
      const testSummary = QuizSubmissionSummaryEntity(
        id: 'sub-1',
        quizId: 'quiz-1',
        score: 8.0,
        totalPoints: 10.0,
        percentage: 80.0,
        isPassed: true,
        timeSpentSeconds: 90,
      );
      when(
        () => repository.getMySubmissions('quiz-1'),
      ).thenAnswer((_) async => const Result.ok([testSummary]));

      final result = await getMySubmissionsUseCase.call('quiz-1');
      expect(result, isA<Ok<List<QuizSubmissionSummaryEntity>>>());
      result.when(
        ok: (list) {
          expect(list.length, equals(1));
          expect(list.first.isPassed, isTrue);
          expect(list.first.percentage, equals(80.0));
        },
        err: (_) => fail('Expected Ok'),
      );
    });

    test(
      'GetQuizSubmissionDetailUseCase returns QuizResultEntity on success',
      () async {
        when(
          () => repository.getSubmissionDetail('sub-1'),
        ).thenAnswer((_) async => const Result.ok(testQuizResult));

        final result = await getSubmissionDetailUseCase.call('sub-1');
        expect(result, isA<Ok<QuizResultEntity>>());
      },
    );

    testWidgets(
      'QuizSubmissionDetailPage renders submission details correctly',
      (tester) async {
        final container = ProviderContainer(
          overrides: [
            quizSubmissionDetailProvider('sub-1').overrideWith(
              (ref) async => const QuizResultEntity(
                submissionId: 'sub-1',
                quizId: 'quiz-1',
                score: 8.0,
                totalPoints: 10.0,
                percentage: 80.0,
                isPassed: true,
                timeSpentSeconds: 120,
                questionResults: [
                  QuestionResultEntity(
                    questionId: 'q-1',
                    content: 'Flutter là gì?',
                    explanation: 'Framework UI hàng đầu của Google.',
                    points: 10.0,
                    earnedPoints: 10.0,
                    isCorrect: true,
                  ),
                ],
              ),
            ),
            quizDetailFutureProvider(
              'quiz-1',
            ).overrideWith((ref) async => testQuizDetail),
          ],
        );

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(
              home: QuizSubmissionDetailPage(submissionId: 'sub-1'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Chi tiết bài làm'), findsOneWidget);
        expect(find.text('ĐẠT CHUẨN ĐẦU RA'), findsOneWidget);
        expect(find.text('80%'), findsOneWidget);
        expect(find.text('8.0 / 10.0'), findsOneWidget);
        expect(find.text('Flutter là gì?'), findsOneWidget);
        expect(find.text('Framework UI hàng đầu của Google.'), findsOneWidget);
        expect(find.text('Làm lại bài kiểm tra này'), findsOneWidget);
      },
    );

    testWidgets(
      'QuizSubmissionDetailPage renders failed submission with wrong and correct answers',
      (tester) async {
        final container = ProviderContainer(
          overrides: [
            quizSubmissionDetailProvider('sub-fail').overrideWith(
              (ref) async => const QuizResultEntity(
                submissionId: 'sub-fail',
                quizId: 'quiz-1',
                totalPoints: 10.0,
                timeSpentSeconds: 60,
                questionResults: [
                  QuestionResultEntity(
                    questionId: 'q-1',
                    content: 'Flutter là gì?',
                    explanation: 'Framework UI hàng đầu của Google.',
                    points: 10.0,
                    selectedOptionIds: ['opt-2'],
                    correctOptionIds: ['opt-1'],
                  ),
                ],
              ),
            ),
            quizDetailFutureProvider(
              'quiz-1',
            ).overrideWith((ref) async => testQuizDetail),
          ],
        );

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(
              home: QuizSubmissionDetailPage(submissionId: 'sub-fail'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('CHƯA ĐẠT CHUẨN'), findsOneWidget);
        expect(find.text('0%'), findsOneWidget);
        expect(find.text('Chưa đúng'), findsOneWidget);
        expect(find.textContaining('Database'), findsWidgets);
        expect(find.textContaining('Framework UI'), findsWidgets);
        expect(find.text('Bạn đã chọn (Sai)'), findsOneWidget);
        expect(find.text('Đáp án đúng'), findsOneWidget);
        expect(find.text('Quay lại bài học'), findsOneWidget);
      },
    );

    testWidgets(
      'QuizSubmissionDetailPage renders with initialSubmission and quiz directly for live quiz result',
      (tester) async {
        bool restarted = false;
        const initialSub = QuizResultEntity(
          submissionId: 'sub-live',
          quizId: 'quiz-1',
          score: 10.0,
          totalPoints: 10.0,
          percentage: 100.0,
          isPassed: true,
          timeSpentSeconds: 90,
          questionResults: [
            QuestionResultEntity(
              questionId: 'q-1',
              content: 'Flutter là gì?',
              isCorrect: true,
              selectedOptionIds: ['opt-1'],
              correctOptionIds: ['opt-1'],
            ),
          ],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: QuizSubmissionDetailPage(
              submissionId: 'sub-live',
              initialSubmission: initialSub,
              quiz: testQuizDetail,
              onRestart: () => restarted = true,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Chi tiết bài làm'), findsOneWidget);
        expect(find.text('100%'), findsOneWidget);
        expect(find.text('ĐẠT CHUẨN ĐẦU RA'), findsOneWidget);
        expect(find.text('Làm lại bài kiểm tra này'), findsOneWidget);
        expect(find.text('Quay lại bài học'), findsOneWidget);

        await tester.ensureVisible(find.text('Làm lại bài kiểm tra này'));
        await tester.tap(find.text('Làm lại bài kiểm tra này'));
        expect(restarted, isTrue);
      },
    );

    testWidgets(
      'QuizSubmissionsHistoryModal renders submissions list and best score banner',
      (tester) async {
        final submissions = [
          const QuizSubmissionSummaryEntity(
            id: 'sub-2',
            quizId: 'quiz-1',
            score: 9.0,
            totalPoints: 10.0,
            percentage: 90.0,
            isPassed: true,
            timeSpentSeconds: 150,
          ),
          const QuizSubmissionSummaryEntity(
            id: 'sub-1',
            quizId: 'quiz-1',
            score: 5.0,
            totalPoints: 10.0,
            percentage: 50.0,
            timeSpentSeconds: 90,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: QuizSubmissionsHistoryModal(
                submissions: submissions,
                quizTitle: 'Kiểm tra chương 1',
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Lịch sử làm bài'), findsOneWidget);
        expect(find.text('Kiểm tra chương 1'), findsOneWidget);
        expect(find.textContaining('Kết quả cao nhất: 90%'), findsOneWidget);
        expect(find.text('Lần làm bài #2'), findsOneWidget);
        expect(find.text('Lần làm bài #1'), findsOneWidget);
        expect(find.text('90%'), findsOneWidget);
        expect(find.text('50%'), findsOneWidget);
        expect(find.text('Đạt'), findsOneWidget);
        expect(find.text('Chưa đạt'), findsOneWidget);
      },
    );

    testWidgets(
      'QuizSubmissionsHistoryModal renders empty state when no submissions',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: QuizSubmissionsHistoryModal(
                submissions: [],
                quizTitle: 'Kiểm tra chương 1',
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Chưa có lượt làm bài nào'), findsOneWidget);
        expect(
          find.text('Hãy làm bài kiểm tra để lưu kết quả và theo dõi tiến độ.'),
          findsOneWidget,
        );
      },
    );
  });
}
