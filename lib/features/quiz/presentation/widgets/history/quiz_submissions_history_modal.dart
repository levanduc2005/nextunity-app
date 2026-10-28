import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_submission_summary_entity.dart';
import 'package:rental_car/features/quiz/presentation/widgets/history/quiz_submission_history_empty.dart';
import 'package:rental_car/features/quiz/presentation/widgets/history/quiz_submission_history_item.dart';

/// Hiển thị modal bottom sheet danh sách lịch sử các lần làm bài kiểm tra
Future<void> showQuizSubmissionsHistoryModal(
  BuildContext context, {
  required List<QuizSubmissionSummaryEntity> submissions,
  required String quizTitle,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (ctx) => QuizSubmissionsHistoryModal(
      submissions: submissions,
      quizTitle: quizTitle,
    ),
  );
}

class QuizSubmissionsHistoryModal extends StatelessWidget {
  const QuizSubmissionsHistoryModal({
    super.key,
    required this.submissions,
    required this.quizTitle,
  });

  final List<QuizSubmissionSummaryEntity> submissions;
  final String quizTitle;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.78;

    final bestAttempt = submissions.isNotEmpty
        ? submissions.reduce(
            (curr, next) => curr.percentage > next.percentage ? curr : next,
          )
        : null;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Drag Handle
            Center(
              child: Container(
                width: 44,
                height: 4.5,
                decoration: BoxDecoration(
                  color: AppColors.borderMedium,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.history_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lịch sử làm bài',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        quizTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                    size: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // 3. Best Attempt Highlight Banner (nếu có bài nộp)
            if (bestAttempt != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: bestAttempt.isPassed
                      ? const Color(0xFFECFDF5)
                      : AppColors.warningLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: bestAttempt.isPassed
                        ? AppColors.successBorder
                        : AppColors.warningBorder,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      bestAttempt.isPassed
                          ? Icons.verified_rounded
                          : Icons.military_tech_rounded,
                      size: 18,
                      color: bestAttempt.isPassed
                          ? AppColors.successDark
                          : AppColors.warningForeground,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Kết quả cao nhất: ${bestAttempt.percentage.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: bestAttempt.isPassed
                              ? const Color(0xFF065F46)
                              : const Color(0xFF92400E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],

            // 4. Danh sách các lần làm bài hoặc Empty state
            if (submissions.isEmpty) ...[
              const QuizSubmissionHistoryEmpty(),
            ] else ...[
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: submissions.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (ctx, index) {
                    final s = submissions[index];
                    final attemptNumber = submissions.length - index;

                    return QuizSubmissionHistoryItem(
                      submission: s,
                      attemptNumber: attemptNumber,
                      onTap: () {
                        Navigator.of(ctx).pop();
                        context.push(
                          AppRoute.quizSubmissionDetail.path.replaceAll(
                            ':id',
                            s.id,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
