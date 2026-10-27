import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';
import 'package:rental_car/features/quiz/presentation/providers/quiz_providers.dart';
import 'package:rental_car/features/quiz/presentation/widgets/submission_detail/submission_question_card.dart';
import 'package:rental_car/features/quiz/presentation/widgets/submission_detail/submission_score_banner.dart';

class QuizSubmissionDetailPage extends ConsumerWidget {
  const QuizSubmissionDetailPage({
    super.key,
    required this.submissionId,
    this.initialSubmission,
    this.quiz,
    this.title,
    this.onRestart,
    this.onBack,
  });

  final String submissionId;
  final QuizResultEntity? initialSubmission;
  final QuizDetailEntity? quiz;
  final String? title;
  final VoidCallback? onRestart;
  final VoidCallback? onBack;

  void _handleBack(
    BuildContext context,
    WidgetRef ref,
    QuizResultEntity? submission,
    QuizDetailEntity? quiz,
  ) {
    if (submission != null && submission.isPassed) {
      ref.invalidate(myQuizSubmissionsProvider(submission.quizId));
      ref
          .read(lessonDetailControllerProvider.notifier)
          .markCompleted(isCompleted: true);
      if (quiz != null) {
        ref
            .read(courseDetailControllerProvider.notifier)
            .markLessonCompleted(quiz.lessonId, isCompleted: true);
      }
    }
    if (onBack != null) {
      onBack!();
    } else if (context.canPop()) {
      context.pop(true);
    } else {
      context.goNamed(AppRoute.courses.name);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (initialSubmission != null) {
      final quizAsync = quiz != null
          ? null
          : ref.watch(quizDetailFutureProvider(initialSubmission!.quizId));
      final quizToUse = quiz ?? quizAsync?.asData?.value;

      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: _buildAppBar(context, ref, initialSubmission, quizToUse),
        body: _buildContent(context, ref, initialSubmission!, quizToUse),
      );
    }

    final submissionAsync = ref.watch(
      quizSubmissionDetailProvider(submissionId),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context, ref, submissionAsync.asData?.value, null),
      body: submissionAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
        error: (error, _) => Center(
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
                  'Không thể tải chi tiết bài làm: $error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(
                    quizSubmissionDetailProvider(submissionId),
                  ),
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
        data: (submission) {
          final quizAsync = ref.watch(
            quizDetailFutureProvider(submission.quizId),
          );
          final quiz = quizAsync.asData?.value;

          return _buildContent(context, ref, submission, quiz);
        },
      ),
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
    WidgetRef ref,
    QuizResultEntity? submission,
    QuizDetailEntity? quiz,
  ) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        color: const Color(0xFF0F172A),
        onPressed: () => _handleBack(context, ref, submission, quiz),
      ),
      title: Text(
        title ?? 'Chi tiết bài làm',
        style: const TextStyle(
          fontSize: 16.5,
          fontWeight: FontWeight.w800,
          color: Color(0xFF0F172A),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    QuizResultEntity submission,
    QuizDetailEntity? quiz,
  ) {
    final totalQuestions = submission.questionResults.length;
    final correctCount = submission.questionResults
        .where((q) => q.isCorrect)
        .length;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Hero Score Banner
          SubmissionScoreBanner(submission: submission),
          const SizedBox(height: 22),

          // 2. Tieu de danh sach cau hoi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chi tiết từng câu hỏi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Text(
                  '$correctCount đúng • ${totalQuestions - correctCount} sai',
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 3. Danh sach cau hoi
          ...submission.questionResults.asMap().entries.map((entry) {
            final index = entry.key;
            final qResult = entry.value;

            QuizQuestionEntity? questionEntity;
            if (quiz != null) {
              final found = quiz.questions.where(
                (q) => q.id == qResult.questionId,
              );
              if (found.isNotEmpty) {
                questionEntity = found.first;
              }
            }

            return SubmissionQuestionCard(
              questionNumber: index + 1,
              qResult: qResult,
              questionEntity: questionEntity,
            );
          }),

          const SizedBox(height: 16),

          // 4. Cac nut hanh dong
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                if (onRestart != null) {
                  onRestart!();
                } else {
                  context.pushReplacement(
                    '${AppRoute.quiz.path}?quizId=${submission.quizId}',
                  );
                }
              },
              icon: const Icon(Icons.replay_rounded, size: 20),
              label: const Text(
                'Làm lại bài kiểm tra này',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => _handleBack(context, ref, submission, quiz),
              icon: const Icon(Icons.arrow_back_rounded, size: 18),
              label: const Text(
                'Quay lại bài học',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF334155),
                side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
