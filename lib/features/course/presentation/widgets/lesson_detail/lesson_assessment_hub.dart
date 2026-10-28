import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_assessment_result_box.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_assessment_rules_box.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_assessment_spec_grid.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_submission_summary_entity.dart';
import 'package:rental_car/features/quiz/presentation/providers/quiz_providers.dart';
import 'package:rental_car/features/quiz/presentation/widgets/history/quiz_submissions_history_modal.dart';

class LessonAssessmentHub extends ConsumerWidget {
  const LessonAssessmentHub({
    super.key,
    required this.lesson,
    required this.isCompleted,
  });

  final LessonEntity lesson;
  final bool isCompleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizId = lesson.quizId;
    List<QuizSubmissionSummaryEntity> submissions = const [];
    if (quizId != null && quizId.trim().isNotEmpty) {
      final submissionsAsync = ref.watch(myQuizSubmissionsProvider(quizId));
      submissions = submissionsAsync.asData?.value ?? const [];
    }

    final quizState = ref.watch(quizControllerProvider);
    final justPassedQuiz =
        quizState.isSubmitted &&
        quizState.result?.quizId == quizId &&
        (quizState.result?.isPassed ?? false);

    final hasPassed = justPassedQuiz || submissions.any((s) => s.isPassed);
    final effectiveIsCompleted = isCompleted || hasPassed;

    final hasLiveResult =
        quizState.isSubmitted && quizState.result?.quizId == quizId;
    final hasAttempted = submissions.isNotEmpty || hasLiveResult;

    double bestPercentage = 0.0;
    for (final s in submissions) {
      final p = s.percentage > 0
          ? s.percentage
          : (s.totalPoints > 0 ? (s.score / s.totalPoints) * 100 : 0.0);
      if (p > bestPercentage) {
        bestPercentage = p;
      }
    }
    if (hasLiveResult && quizState.result != null) {
      final res = quizState.result!;
      final p = res.percentage > 0
          ? res.percentage
          : (res.totalPoints > 0 ? (res.score / res.totalPoints) * 100 : 0.0);
      if (p > bestPercentage) {
        bestPercentage = p;
      }
    }
    if (effectiveIsCompleted && bestPercentage < 80.0 && hasAttempted) {
      bestPercentage = 100.0;
    }

    final hasActiveDraftInState =
        quizState.quiz?.id == quizId &&
        !quizState.isSubmitted &&
        quizState.answeredCount > 0;
    final hasStoredDraft =
        quizId != null &&
        (ref.watch(hasQuizDraftProvider(quizId)).asData?.value ?? false);
    final hasDraft = hasActiveDraftInState || hasStoredDraft;

    final descriptionText =
        (lesson.content != null && lesson.content!.trim().isNotEmpty)
        ? lesson.content!.trim()
        : (hasDraft
              ? 'Bạn có bài làm dở đang được lưu. Bạn có thể nhấn "Làm tiếp" bất cứ lúc nào.'
              : (effectiveIsCompleted
                    ? 'Bạn đã hoàn thành bài kiểm tra này. Bạn có thể luyện tập lại bất cứ lúc nào để củng cố kiến thức.'
                    : 'Vượt qua bài kiểm tra trắc nghiệm với điểm số từ 80% trở lên để hoàn thành bài học.'));

    final String actionButtonText;
    final IconData actionButtonIcon;

    if (hasDraft) {
      actionButtonText = 'Làm tiếp';
      actionButtonIcon = Icons.arrow_forward_rounded;
    } else if (effectiveIsCompleted) {
      actionButtonText = 'Luyện tập lại';
      actionButtonIcon = Icons.refresh_rounded;
    } else if (submissions.isNotEmpty) {
      actionButtonText = 'Làm lại';
      actionButtonIcon = Icons.replay_rounded;
    } else {
      actionButtonText = 'Bắt đầu làm';
      actionButtonIcon = Icons.play_arrow_rounded;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: effectiveIsCompleted
              ? AppColors.successBorder
              : AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Accent Stripe
            Container(
              height: 4,
              color: effectiveIsCompleted
                  ? AppColors.success
                  : AppColors.primary,
            ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Description nằm trên cùng của card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: effectiveIsCompleted
                          ? const Color(0xFFECFDF5)
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: effectiveIsCompleted
                            ? AppColors.successBorder
                            : AppColors.border,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          effectiveIsCompleted
                              ? Icons.verified_rounded
                              : Icons.info_outline_rounded,
                          size: 18,
                          color: effectiveIsCompleted
                              ? AppColors.successDark
                              : AppColors.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            descriptionText,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: effectiveIsCompleted
                                  ? const Color(0xFF065F46)
                                  : AppColors.textSecondaryDark,
                              height: 1.45,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. 2x2 Bento Grid thông số bài thi
                  LessonAssessmentSpecGrid(lesson: lesson),
                  const SizedBox(height: 16),

                  // 3. Quy chế & Hướng dẫn thi HOẶC Thẻ kết quả thi
                  if (hasAttempted)
                    LessonAssessmentResultBox(
                      isPassed: effectiveIsCompleted,
                      bestPercentage: bestPercentage,
                    )
                  else
                    const LessonAssessmentRulesBox(),
                  const SizedBox(height: 20),

                  // 4. Nút hành động chính
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: effectiveIsCompleted
                          ? AppColors.successDark
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:
                              (effectiveIsCompleted
                                      ? AppColors.successDark
                                      : AppColors.primary)
                                  .withValues(alpha: 0.32),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          final quizId = lesson.quizId;
                          if (quizId != null && quizId.trim().isNotEmpty) {
                            final container = ProviderScope.containerOf(
                              context,
                              listen: false,
                            );
                            await context.push(
                              '${AppRoute.quiz.path}?quizId=$quizId',
                            );
                            container.invalidate(
                              myQuizSubmissionsProvider(quizId),
                            );
                            container.invalidate(hasQuizDraftProvider(quizId));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Bài kiểm tra này đang được cập nhật câu hỏi.',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  actionButtonIcon,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    actionButtonText,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 5. Nút Lịch sử làm bài
                  SizedBox(
                    height: 46,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showQuizSubmissionsHistoryModal(
                          context,
                          submissions: submissions,
                          quizTitle: lesson.title,
                        );
                      },
                      icon: const Icon(
                        Icons.history_rounded,
                        size: 19,
                        color: AppColors.textLabel,
                      ),
                      label: Text(
                        submissions.isNotEmpty
                            ? 'Lịch sử làm bài (${submissions.length} lần)'
                            : 'Lịch sử làm bài',
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textLabel,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.borderMedium),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: AppColors.surfaceLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
