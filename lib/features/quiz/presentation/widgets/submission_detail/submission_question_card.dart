import 'package:flutter/material.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';
import 'package:rental_car/features/quiz/presentation/widgets/submission_detail/submission_explanation_box.dart';
import 'package:rental_car/features/quiz/presentation/widgets/submission_detail/submission_option_tile.dart';

class SubmissionQuestionCard extends StatelessWidget {
  const SubmissionQuestionCard({
    super.key,
    required this.questionNumber,
    required this.qResult,
    this.questionEntity,
  });

  final int questionNumber;
  final QuestionResultEntity qResult;
  final QuizQuestionEntity? questionEntity;

  @override
  Widget build(BuildContext context) {
    final isCorrect = qResult.isCorrect;

    // Lay chuoi dap an hoc vien chon va dap an dung
    String userSelectedAnswersText = '';
    String correctAnswersText = '';
    if (questionEntity != null && questionEntity!.options.isNotEmpty) {
      final userSelectedOptions = questionEntity!.options
          .where((o) => qResult.selectedOptionIds.contains(o.id))
          .map((o) => o.content)
          .toList();
      userSelectedAnswersText = userSelectedOptions.isNotEmpty
          ? userSelectedOptions.join('; ')
          : 'Chưa chọn đáp án';

      final correctOptions = questionEntity!.options
          .where((o) => qResult.correctOptionIds.contains(o.id))
          .map((o) => o.content)
          .toList();
      correctAnswersText = correctOptions.isNotEmpty
          ? correctOptions.join('; ')
          : 'Đang cập nhật';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isCorrect ? const Color(0xFFBBF7D0) : const Color(0xFFFECACA),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header cau hoi: So cau & Trang thai dung/sai
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isCorrect
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Câu $questionNumber',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: isCorrect
                        ? const Color(0xFF15803D)
                        : const Color(0xFFB91C1C),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: isCorrect
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isCorrect
                        ? const Color(0xFF86EFAC)
                        : const Color(0xFFFCA5A5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isCorrect
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      size: 14,
                      color: isCorrect
                          ? const Color(0xFF16A34A)
                          : const Color(0xFFEF4444),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isCorrect ? 'Chính xác' : 'Chưa đúng',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: isCorrect
                            ? const Color(0xFF15803D)
                            : const Color(0xFFB91C1C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Noi dung cau hoi
          Text(
            qResult.content.isNotEmpty
                ? qResult.content
                : (questionEntity?.content ?? 'Nội dung câu hỏi'),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // Doi voi cau sai: Khoi so sanh dap an da chon vs dap an dung
          if (!isCorrect && userSelectedAnswersText.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFECDD3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.cancel_outlined,
                        size: 15,
                        color: Color(0xFFE11D48),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF881337),
                              height: 1.35,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Bạn đã chọn: ',
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                              TextSpan(
                                text: userSelectedAnswersText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 15,
                        color: Color(0xFF059669),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF065F46),
                              height: 1.35,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Đáp án đúng: ',
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                              TextSpan(
                                text: correctAnswersText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          // Danh sach cac dap an
          if (questionEntity != null && questionEntity!.options.isNotEmpty) ...[
            ...questionEntity!.options.map(
              (option) =>
                  SubmissionOptionTile(option: option, qResult: qResult),
            ),
          ],

          // Giai thich chi tiet neu co
          if (qResult.explanation != null && qResult.explanation!.isNotEmpty)
            SubmissionExplanationBox(explanation: qResult.explanation!),
        ],
      ),
    );
  }
}
