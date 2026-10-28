import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_assessment_hub.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_markdown_reader.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_slide_attachment_card.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_video_player_box.dart';

/// Card nội dung bài học chuẩn phong cách ApSkil (Materi / Video Player Screen)
/// - Phân tách các khối: Video Player, Assessment Hub, Slide Attachment, Markdown Reader
class LessonContentCard extends ConsumerStatefulWidget {
  const LessonContentCard({
    super.key,
    required this.lesson,
    required this.isCompleted,
    this.instructorName,
  });

  final LessonEntity lesson;
  final bool isCompleted;
  final String? instructorName;

  @override
  ConsumerState<LessonContentCard> createState() => _LessonContentCardState();
}

class _LessonContentCardState extends ConsumerState<LessonContentCard> {
  int _activeContentTab = 0; // 0: Nội dung, 1: Slide

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    final isCompleted = widget.isCompleted;
    final isQuiz = lesson.type == 'QUIZ';
    final isVideoLesson =
        !isQuiz &&
        (lesson.type == 'VIDEO' ||
            (lesson.videoUrl != null && lesson.videoUrl!.trim().isNotEmpty));
    final hasSlide =
        lesson.slideUrl != null && lesson.slideUrl!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Hero Media: Quiz Hub hoặc Video Player
        if (isQuiz) ...[
          LessonAssessmentHub(lesson: lesson, isCompleted: isCompleted),
        ] else if (isVideoLesson) ...[
          LessonVideoPlayerBox(estimatedMinutes: lesson.estimatedMinutes),
          const SizedBox(height: 16),
        ],

        // 2. Tabs chuyển đổi chỉ hiển thị khi có Slide thực tế
        if (hasSlide) ...[_buildTabsHeader(), const SizedBox(height: 16)],

        // 3. Nội dung bài học (Markdown) hoặc Thẻ tài liệu slide
        if (!isQuiz && (!hasSlide || _activeContentTab == 0)) ...[
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: LessonMarkdownReader(content: lesson.content ?? ''),
          ),
        ] else if (hasSlide && _activeContentTab == 1) ...[
          LessonSlideAttachmentCard(slideUrl: lesson.slideUrl!),
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTabsHeader() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubtle,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _activeContentTab = 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _activeContentTab == 0
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _activeContentTab == 0
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF0F172A,
                            ).withValues(alpha: 0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  'Nội dung bài học',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: _activeContentTab == 0
                        ? FontWeight.w800
                        : FontWeight.w600,
                    color: _activeContentTab == 0
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _activeContentTab = 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _activeContentTab == 1
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _activeContentTab == 1
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF0F172A,
                            ).withValues(alpha: 0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  'Tài liệu & Slide',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: _activeContentTab == 1
                        ? FontWeight.w800
                        : FontWeight.w600,
                    color: _activeContentTab == 1
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
