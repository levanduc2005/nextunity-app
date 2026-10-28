import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class LessonMarkdownReader extends StatelessWidget {
  const LessonMarkdownReader({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    if (content.trim().isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        alignment: Alignment.center,
        child: const Text(
          'Nội dung bài học đang được cập nhật...',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textMuted,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return MarkdownBody(
      data: content,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        h1: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
          height: 1.4,
        ),
        h2: const TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
          height: 1.4,
        ),
        h3: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: AppColors.textDark,
          height: 1.35,
        ),
        p: const TextStyle(
          fontSize: 12.5,
          color: AppColors.textLabel,
          height: 1.6,
        ),
        blockquote: const TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
          color: AppColors.textDark,
        ),
        blockquoteDecoration: const BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
        ),
        tableBorder: TableBorder.all(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(12),
        ),
        tableHead: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        tableBody: const TextStyle(fontSize: 11, color: AppColors.textSecondaryDark),
      ),
    );
  }
}
