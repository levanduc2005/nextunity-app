import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Top App Bar & Thông tin sinh viên (Logo, Streak, Thông báo, Avatar PLUS, Trường ĐH)
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
    required this.displayName,
    required this.streak,
    required this.isPlus,
    this.avatarUrl,
    this.university,
    this.major,
    this.cohort,
  });

  final String displayName;
  final int streak;
  final bool isPlus;
  final String? avatarUrl;
  final String? university;
  final String? major;
  final int? cohort;

  @override
  Widget build(BuildContext context) {
    final schoolText = StringBuffer(university ?? 'Đại học FPT');
    if (cohort != null && cohort! > 0) {
      schoolText.write(' • K$cohort');
    }
    if (major != null && major!.isNotEmpty) {
      schoolText.write(' $major');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainTabHeader(
          subtitle: 'Chào $displayName 👋',
          streak: streak,
          showAvatar: true,
          avatarUrl: avatarUrl,
          isPlus: isPlus,
          padding: EdgeInsets.zero,
        ),
        const SizedBox(height: 10),

        // Hàng 2: Chip Trường ĐH & Học kỳ
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE).withValues(alpha: 0.7),
                  border: Border.all(
                    color: const Color(0xFFBFDBFE).withValues(alpha: 0.8),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.school_rounded,
                      size: 13,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        schoolText.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF1E40AF),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Kỳ Fall 2024',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
