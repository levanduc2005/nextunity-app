import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/presentation/pages/quiz_submission_detail_page.dart';
import 'package:rental_car/features/quiz/presentation/providers/quiz_providers.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_bottom_bar.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_exit_modal.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_hero_header.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_question_view.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({super.key, this.quizId});

  final String? quizId;

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  @override
  void initState() {
    super.initState();
    if (widget.quizId != null && widget.quizId!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(quizControllerProvider.notifier).loadQuiz(widget.quizId!);
      });
    }
  }

  Future<void> _handleExit(QuizState state, QuizDetailEntity? quiz) async {
    if (state.answeredCount > 0 && quiz != null) {
      final shouldExit = await showQuizExitModal(
        context,
        answeredCount: state.answeredCount,
        totalQuestions: quiz.questions.length,
      );
      if (shouldExit == true && mounted) {
        context.pop();
      }
    } else {
      context.pop();
    }
  }

  Future<void> _handleNextOrSubmit(
    int currentIndex,
    QuizDetailEntity quiz,
  ) async {
    if (currentIndex < quiz.questions.length - 1) {
      ref.read(quizControllerProvider.notifier).nextQuestion();
    } else {
      final success = await ref
          .read(quizControllerProvider.notifier)
          .submitQuiz();
      if (!success) {
        final err = ref.read(quizControllerProvider).errorMessage;
        if (err != null && mounted) {
          context.showErrorSnackBar(err);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.quizId == null || widget.quizId!.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildStandardAppBar('Bài kiểm tra'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: EmptyView(
              icon: Icons.quiz_outlined,
              message:
                  'Vui lòng chọn bài học trắc nghiệm trong khóa học để bắt đầu làm bài.',
              actionLabel: 'Xem danh sách khóa học',
              onAction: () => context.goNamed(AppRoute.courses.name),
            ),
          ),
        ),
      );
    }

    final state = ref.watch(quizControllerProvider);
    final quiz = state.quiz;
    final isSubmitted = state.isSubmitted && state.result != null;

    if (state.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.primaryDark,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    if (state.errorMessage != null && quiz == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildStandardAppBar('Lỗi bài thi'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 48,
                  color: Color(0xFFEF4444),
                ),
                const SizedBox(height: 12),
                Text(
                  state.errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(quizControllerProvider.notifier)
                        .loadQuiz(widget.quizId!);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (quiz == null || quiz.questions.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildStandardAppBar('Bài kiểm tra'),
        body: const Center(
          child: Text(
            'Bài kiểm tra chưa có câu hỏi nào.',
            style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
          ),
        ),
      );
    }

    // Khi đã nộp bài: Hiển thị kết quả bằng trang Chi tiết bài làm
    if (isSubmitted) {
      return QuizSubmissionDetailPage(
        submissionId: state.result!.submissionId,
        initialSubmission: state.result,
        quiz: state.quiz,
        onRestart: () {
          ref.read(quizControllerProvider.notifier).restartQuiz();
        },
        onBack: () {
          if (context.canPop()) {
            context.pop(true);
          } else {
            context.goNamed(AppRoute.courses.name);
          }
        },
      );
    }

    // Khi đang làm bài thi: Giao diện hiện đại theo phong cách ApSkil
    return PopScope(
      canPop: isSubmitted || state.answeredCount == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleExit(state, quiz);
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryDark,
        body: _buildQuizLayout(context, quiz, state),
      ),
    );
  }

  AppBar _buildStandardAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        color: const Color(0xFF0F172A),
        onPressed: () => context.pop(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: Color(0xFF0F172A),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildQuizLayout(
    BuildContext context,
    QuizDetailEntity quiz,
    QuizState state,
  ) {
    final currentIndex = state.currentQuestionIndex;
    final question = quiz.questions[currentIndex];
    final selectedIds = state.selectedOptionIds[question.id] ?? [];

    return Container(
      color: const Color(0xFF1E3A8A),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. Top Header Area (Tiêu đề, Nút Close, Chỉ số 03/10, Pill X đã làm, Progress)
            QuizHeroHeader(
              title: quiz.title,
              currentIndex: currentIndex,
              totalQuestions: quiz.questions.length,
              answeredCount: state.answeredCount,
              onExit: () => _handleExit(state, quiz),
            ),

            // 2. White Sheet Body (Khung câu hỏi, Lựa chọn đáp án & Bottom bar)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: QuizQuestionView(
                          questionNumber: currentIndex + 1,
                          question: question,
                          selectedOptionIds: selectedIds,
                          onSelectOption: (optionId, isMultiChoice) {
                            ref
                                .read(quizControllerProvider.notifier)
                                .selectOption(
                                  question.id,
                                  optionId,
                                  isMultiChoice: isMultiChoice,
                                );
                          },
                        ),
                      ),
                      QuizBottomBar(
                        currentIndex: currentIndex,
                        totalQuestions: quiz.questions.length,
                        isSubmitting: state.isSubmitting,
                        onPrevious: () {
                          ref
                              .read(quizControllerProvider.notifier)
                              .previousQuestion();
                        },
                        onNextOrSubmit: () =>
                            _handleNextOrSubmit(currentIndex, quiz),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
