import 'package:flutter/material.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.user,
    this.enrolledCoursesCount = 12,
  });

  final UserEntity? user;
  final int enrolledCoursesCount;

  @override
  Widget build(BuildContext context) {
    final streak = user?.streak ?? 0;
    final points = user?.points ?? 0;
    final studentId = (user?.studentId != null && user!.studentId!.isNotEmpty)
        ? user!.studentId!
        : (user?.cohort != null ? 'K${user!.cohort}' : 'SE');

    return Row(
      children: [
        // 1. Khóa học
        Expanded(
          child: _StatCard(
            icon: Icons.menu_book_rounded,
            iconBgColor: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF2563EB),
            value: '$enrolledCoursesCount',
            label: 'Khóa học',
          ),
        ),
        const SizedBox(width: 6),

        // 2. Điểm thưởng (Points) - Khớp với backend!
        Expanded(
          child: _StatCard(
            icon: Icons.monetization_on_rounded,
            iconBgColor: const Color(0xFFFEF3C7),
            iconColor: const Color(0xFFD97706),
            value: '$points',
            label: 'Điểm 🪙',
          ),
        ),
        const SizedBox(width: 6),

        // 3. MSSV / Khoá - Khớp với backend studentId/cohort!
        Expanded(
          child: _StatCard(
            icon: Icons.badge_outlined,
            iconBgColor: const Color(0xFFECFDF5),
            iconColor: const Color(0xFF059669),
            value: studentId,
            label: 'MSSV',
          ),
        ),
        const SizedBox(width: 6),

        // 4. Streak ngày học - Khớp với backend streak!
        Expanded(
          child: _StatCard(
            icon: Icons.local_fire_department_rounded,
            iconBgColor: const Color(0xFFFFEDD5),
            iconColor: const Color(0xFFEA580C),
            value: '${streak}d',
            label: 'Streak 🔥',
            isHighlight: streak > 0,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.value,
    required this.label,
    this.isHighlight = false,
  });

  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String value;
  final String label;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlight
              ? const Color(0xFFFDBA74).withValues(alpha: 0.6)
              : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: iconColor),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: isHighlight
                    ? const Color(0xFFEA580C)
                    : const Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
              letterSpacing: -0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
