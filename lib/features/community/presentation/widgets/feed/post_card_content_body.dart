import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thân nội dung bài viết: Tiêu đề và đoạn trích văn bản 3 dòng có nút 'Xem thêm'
class PostCardContentBody extends StatelessWidget {
  const PostCardContentBody({
    super.key,
    required this.title,
    required this.content,
    required this.onSeeMore,
  });

  final String title;
  final String content;
  final VoidCallback onSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.trim().isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(height: 6),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const textStyle = TextStyle(
                fontSize: 13.5,
                color: Color(0xFF334155),
                height: 1.45,
              );

              final textSpan = TextSpan(text: content, style: textStyle);
              final textPainter = TextPainter(
                text: textSpan,
                maxLines: 3,
                textDirection: Directionality.of(context),
              )..layout(maxWidth: constraints.maxWidth);

              final isOverflowing = textPainter.didExceedMaxLines;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    style: textStyle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isOverflowing)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onSeeMore,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          '... Xem thêm',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
