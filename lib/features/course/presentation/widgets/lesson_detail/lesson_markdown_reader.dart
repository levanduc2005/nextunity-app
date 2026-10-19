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
            color: Color(0xFF94A3B8),
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
          color: Color(0xFF0F172A),
          letterSpacing: -0.3,
          height: 1.4,
        ),
        h2: const TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w900,
          color: Color(0xFF0F172A),
          letterSpacing: -0.3,
          height: 1.4,
        ),
        h3: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: Color(0xFF1E293B),
          height: 1.35,
        ),
        p: const TextStyle(
          fontSize: 12.5,
          color: Color(0xFF334155),
          height: 1.6,
        ),
        blockquote: const TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
          color: Color(0xFF1E293B),
        ),
        blockquoteDecoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
        ),
        tableBorder: TableBorder.all(
          color: const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(12),
        ),
        tableHead: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Color(0xFF0F172A),
        ),
        tableBody: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
      ),
    );
  }
}
