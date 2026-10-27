import 'package:flutter/material.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';

class SubmissionOptionTile extends StatelessWidget {
  const SubmissionOptionTile({
    super.key,
    required this.option,
    required this.qResult,
  });

  final QuizOptionEntity option;
  final QuestionResultEntity qResult;

  @override
  Widget build(BuildContext context) {
    final isSelected = qResult.selectedOptionIds.contains(option.id);
    final isCorrectOption = qResult.correctOptionIds.contains(option.id);

    Color borderColor = const Color(0xFFE2E8F0);
    Color bgColor = Colors.white;
    Color textColor = const Color(0xFF334155);
    Widget? tag;

    if (isSelected && isCorrectOption) {
      // Nguoi dung chon dung
      borderColor = const Color(0xFF22C55E);
      bgColor = const Color(0xFFF0FDF4);
      textColor = const Color(0xFF15803D);
      tag = Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
        decoration: BoxDecoration(
          color: const Color(0xFFDCFCE7),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF86EFAC)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_rounded, size: 13, color: Color(0xFF16A34A)),
            SizedBox(width: 3),
            Text(
              'Đúng',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF15803D),
              ),
            ),
          ],
        ),
      );
    } else if (isSelected && !isCorrectOption) {
      // Nguoi dung chon sai
      borderColor = const Color(0xFFEF4444);
      bgColor = const Color(0xFFFEF2F2);
      textColor = const Color(0xFFB91C1C);
      tag = Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
        decoration: BoxDecoration(
          color: const Color(0xFFFEE2E2),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFFCA5A5)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close_rounded, size: 13, color: Color(0xFFDC2626)),
            SizedBox(width: 3),
            Text(
              'Bạn đã chọn (Sai)',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFFB91C1C),
              ),
            ),
          ],
        ),
      );
    } else if (!isSelected && isCorrectOption) {
      // Dap an dung ma nguoi dung bo lo
      borderColor = const Color(0xFF86EFAC);
      bgColor = const Color(0xFFF0FDF4);
      textColor = const Color(0xFF15803D);
      tag = Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
        decoration: BoxDecoration(
          color: const Color(0xFFDCFCE7),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF86EFAC)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_rounded, size: 13, color: Color(0xFF16A34A)),
            SizedBox(width: 3),
            Text(
              'Đáp án đúng',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF15803D),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              option.content,
              style: TextStyle(
                fontSize: 13,
                fontWeight: (isSelected || isCorrectOption)
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          if (tag != null) ...[const SizedBox(width: 8), tag],
        ],
      ),
    );
  }
}
