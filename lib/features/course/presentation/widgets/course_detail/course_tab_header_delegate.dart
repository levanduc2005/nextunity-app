import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thanh Tab dính (Sticky Segmented Tab Bar) chuyển đổi giữa [Giáo trình] và [Tổng quan]
class CourseTabHeaderDelegate extends SliverPersistentHeaderDelegate {
  const CourseTabHeaderDelegate({
    required this.selectedIndex,
    required this.onTabChanged,
    this.totalLessons = 0,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final int totalLessons;

  @override
  double get minExtent => 54.0;

  @override
  double get maxExtent => 54.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border.withValues(alpha: 0.8),
            width: 1,
          ),
        ),
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surfaceSubtle,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Tab 0: Giáo trình
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTabChanged(0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: selectedIndex == 0 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: selectedIndex == 0
                        ? [
                            BoxShadow(
                              color: AppColors.textPrimary.withValues(alpha: 0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: 15,
                          color: selectedIndex == 0
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          totalLessons > 0
                              ? 'Giáo trình ($totalLessons bài)'
                              : 'Giáo trình',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: selectedIndex == 0
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: selectedIndex == 0
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Tab 1: Tổng quan
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTabChanged(1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: selectedIndex == 1 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: selectedIndex == 1
                        ? [
                            BoxShadow(
                              color: AppColors.textPrimary.withValues(alpha: 0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 15,
                          color: selectedIndex == 1
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Tổng quan & CLO',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: selectedIndex == 1
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: selectedIndex == 1
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant CourseTabHeaderDelegate oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.totalLessons != totalLessons;
  }
}
