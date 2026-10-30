import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/l10n/l10n.dart';

/// A stationery-inspired bottom navigation bar designed for NextUnity.
///
/// Features active pill indicators, circular icon badges, soft slate shadows,
/// and responsive touch feedback.
class NextUnityBottomNavBar extends StatelessWidget {
  const NextUnityBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final items = [
      _NavItemData(
        icon: Icons.explore_outlined,
        selectedIcon: Icons.explore_rounded,
        label: l10n.tabHome,
      ),
      _NavItemData(
        icon: Icons.local_library_outlined,
        selectedIcon: Icons.local_library_rounded,
        label: l10n.tabCourses,
      ),
      _NavItemData(
        icon: Icons.forum_outlined,
        selectedIcon: Icons.forum_rounded,
        label: l10n.tabCommunity,
      ),
      const _NavItemData(
        icon: Icons.person_outline_rounded,
        selectedIcon: Icons.person_rounded,
        label: 'Cá nhân',
      ),
    ];

    final backgroundColor = isDark ? AppColors.textDark : AppColors.surface;
    final borderColor = isDark ? AppColors.textLabel : AppColors.border;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: borderColor)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12182B55),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              for (int i = 0; i < items.length; i++)
                Expanded(
                  child: _NavBarItemWidget(
                    data: items[i],
                    isSelected: i == currentIndex,
                    isDark: isDark,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

class _NavBarItemWidget extends StatelessWidget {
  const _NavBarItemWidget({
    required this.data,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final _NavItemData data;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const activeColor = AppColors.primary;
    final inactiveColor = isDark
        ? AppColors.textSecondary
        : AppColors.textMuted;
    final activeBgColor = isDark
        ? AppColors.primaryDark.withValues(alpha: 0.5)
        : AppColors.primaryContainer;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Active indicator pill at top
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            width: isSelected ? 28 : 0,
            height: 3,
            decoration: BoxDecoration(
              color: isSelected ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: activeColor.withValues(alpha: 0.35),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(height: 4),
          // Circular icon container
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isSelected ? activeBgColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                isSelected ? data.selectedIcon : data.icon,
                size: isSelected ? 20 : 22,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ),
          const SizedBox(height: 2),
          // Label text
          Text(
            data.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? activeColor : inactiveColor,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
