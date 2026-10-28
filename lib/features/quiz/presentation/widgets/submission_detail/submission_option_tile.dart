import 'package:flutter/material.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';

import 'package:rental_car/core/theme/app_colors.dart';
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

    Color borderColor = AppColors.border;
    Color bgColor = Colors.white;
    Color textColor = AppColors.textLabel;
    Widget? tag;

    if (isSelected && isCorrectOption) {
      // Nguoi dung chon dung
      borderColor = const Color(0xFF22C55E);
      bgColor = AppColors.successSurfaceLight;
      textColor = AppColors.successDarkText;
      tag = Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
        decoration: BoxDecoration(
          color: AppColors.successContainer,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF86EFAC)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_rounded, size: 13, color: AppColors.successVibrant),
            SizedBox(width: 3),
            Text(
              'Đúng',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: AppColors.successDarkText,
              ),
            ),
          ],
        ),
      );
    } else if (isSelected && !isCorrectOption) {
      // Nguoi dung chon sai
      borderColor = AppColors.error;
      bgColor = AppColors.errorSurfaceLight;
      textColor = AppColors.errorDark;
      tag = Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
        decoration: BoxDecoration(
          color: AppColors.errorContainer,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.errorBorderLight),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close_rounded, size: 13, color: AppColors.errorForeground),
            SizedBox(width: 3),
            Text(
              'Bạn đã chọn (Sai)',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: AppColors.errorDark,
              ),
            ),
          ],
        ),
      );
    } else if (!isSelected && isCorrectOption) {
      // Dap an dung ma nguoi dung bo lo
      borderColor = const Color(0xFF86EFAC);
      bgColor = AppColors.successSurfaceLight;
      textColor = AppColors.successDarkText;
      tag = Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
        decoration: BoxDecoration(
          color: AppColors.successContainer,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF86EFAC)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_rounded, size: 13, color: AppColors.successVibrant),
            SizedBox(width: 3),
            Text(
              'Đáp án đúng',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: AppColors.successDarkText,
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
