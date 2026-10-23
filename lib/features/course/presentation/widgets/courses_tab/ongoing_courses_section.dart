import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';

class OngoingCoursesSection extends StatefulWidget {
  const OngoingCoursesSection({
    super.key,
    required this.enrollments,
    required this.onTapCourse,
  });

  final List<EnrollmentEntity> enrollments;
  final ValueChanged<EnrollmentEntity> onTapCourse;

  @override
  State<OngoingCoursesSection> createState() => _OngoingCoursesSectionState();
}

class _OngoingCoursesSectionState extends State<OngoingCoursesSection> {
  bool _showCompleted = false;

  @override
  Widget build(BuildContext context) {
    if (widget.enrollments.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.school_rounded,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bắt đầu học tập cùng NextUnity',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Khám phá danh sách môn học bên dưới để đăng ký môn học đầu tiên của bạn.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final ongoingList = widget.enrollments
        .where((e) => !e.isCompleted)
        .toList();
    final completedList = widget.enrollments
        .where((e) => e.isCompleted)
        .toList();
    final activeList = _showCompleted ? completedList : ongoingList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          children: [
            Container(
              width: 4,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                _showCompleted ? 'Môn học đã hoàn thành' : 'Môn học đang học',
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            // Segmented Pills [Đang học] | [Đã xong]
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPill(
                    title: 'Đang học (${ongoingList.length})',
                    isSelected: !_showCompleted,
                    onTap: () => setState(() => _showCompleted = false),
                  ),
                  _buildPill(
                    title: 'Đã xong (${completedList.length})',
                    isSelected: _showCompleted,
                    onTap: () => setState(() => _showCompleted = true),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        if (activeList.isEmpty)
          Container(
            height: 110,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _showCompleted
                        ? Icons.verified_outlined
                        : Icons.auto_stories_outlined,
                    color: const Color(0xFF94A3B8),
                    size: 26,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _showCompleted
                        ? 'Chưa có môn học nào hoàn thành'
                        : 'Không có môn học nào đang diễn ra',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _showCompleted
                        ? 'Tiếp tục hoàn thành bài giảng để nhận chứng chỉ nhé!'
                        : 'Hãy đăng ký các môn học ở danh sách bên dưới.',
                    style: const TextStyle(
                      fontSize: 10.5,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SizedBox(
            height: 154,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: activeList.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final enr = activeList[index];
                return _OngoingCourseCard(
                  enrollment: enr,
                  onTap: () => widget.onTapCourse(enr),
                );
              },
            ),
          ),
        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildPill({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected ? AppColors.primary : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}

class _OngoingCourseCard extends StatelessWidget {
  const _OngoingCourseCard({required this.enrollment, required this.onTap});

  final EnrollmentEntity enrollment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final code = enrollment.courseCode?.isNotEmpty == true
        ? enrollment.courseCode!
        : 'FPT';
    final completedCount =
        ((enrollment.totalLessons * enrollment.progressPercent) / 100).round();
    final progress = enrollment.progressRatio;
    final imageUrl = enrollment.courseThumbnailUrl;
    final isCompleted = enrollment.isCompleted;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 290,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Thumbnail + Code & Title
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 52,
                    height: 52,
                    child: (imageUrl != null && imageUrl.isNotEmpty)
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                _buildFallbackThumbnail(code),
                          )
                        : _buildFallbackThumbnail(code),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.primaryBorder,
                              ),
                            ),
                            child: Text(
                              code,
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryForeground,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          if (isCompleted) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_rounded,
                                    size: 10,
                                    color: Color(0xFF16A34A),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    'Hoàn thành',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF166534),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        enrollment.courseTitle,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Middle: ApSkil Signature Progress Bar with Endpoint Indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final barWidth = constraints.maxWidth;
                    final activeWidth = (barWidth * progress).clamp(
                      0.0,
                      barWidth,
                    );

                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.centerLeft,
                      children: [
                        // Background track
                        Container(
                          height: 6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        // Active track
                        Container(
                          height: 6,
                          width: activeWidth,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF34D399), Color(0xFF10B981)],
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        // Endpoint circular dot (ApSkil signature style)
                        if (activeWidth > 4)
                          Positioned(
                            left: (activeWidth - 4).clamp(0.0, barWidth - 8),
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFF059669),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 5),

                // Metrics text row (ApSkil style: "4 bài đã học ... 8 bài" or "Đã hoàn thành")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        isCompleted
                            ? 'Đã hoàn thành'
                            : '$completedCount bài đã học',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF059669),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${enrollment.totalLessons} bài học',
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Bottom row: Difficulty & Instructor
            Text(
              '${enrollment.courseDifficultyName ?? enrollment.courseDifficulty} • ${enrollment.instructorName ?? "Ban Đào Tạo FPT"}',
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackThumbnail(String code) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Center(
        child: Text(
          code,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}
