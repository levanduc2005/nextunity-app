import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/app_snack_bar.dart';

/// Top App Bar thống nhất cho toàn bộ các Tab chính (Home, Courses, AI, Community, Profile).
/// - Bên trái: Avatar người dùng (ảnh hoặc chữ cái đầu) + Lời chào / Phụ đề & Tên sinh viên
/// - Bên phải: Nút Chuông thông báo (và nút Tìm kiếm tùy chọn ở Home)
class MainTabHeader extends StatelessWidget {
  const MainTabHeader({
    super.key,
    this.displayName,
    this.avatarUrl,
    this.greeting,
    this.subtitle,
    this.showSearch = false,
    this.onSearchTap,
    this.onNotificationTap,
    this.notificationCount = 3,
    this.trailing,
    this.bottom,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.backgroundColor,
  });

  /// Tên hiển thị người dùng (mặc định 'Sinh viên FPT').
  final String? displayName;

  /// Đường dẫn ảnh đại diện người dùng.
  final String? avatarUrl;

  /// Lời chào tùy chỉnh (mặc định theo thời gian trong ngày: Chào buổi sáng / chiều / tối).
  final String? greeting;

  /// Phụ đề tùy chọn (nếu có và không có greeting, sẽ hiển thị phụ đề này).
  final String? subtitle;

  /// Hiển thị nút tìm kiếm khóa học bên cạnh chuông thông báo (mặc định false, chỉ true ở Home).
  final bool showSearch;

  /// Callback khi ấn vào icon tìm kiếm khóa học.
  final VoidCallback? onSearchTap;

  /// Callback khi ấn vào icon chuông thông báo.
  final VoidCallback? onNotificationTap;

  /// Số lượng thông báo chưa đọc để hiển thị chấm đỏ (mặc định 3).
  final int notificationCount;

  /// Widget tùy chọn thêm vào sau chuông thông báo.
  final Widget? trailing;

  /// Widget mở rộng phía dưới header (vd: search bar, chips).
  final Widget? bottom;

  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  String get _defaultGreeting {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Chào buổi sáng,';
    if (hour >= 12 && hour < 18) return 'Chào buổi chiều,';
    return 'Chào buổi tối,';
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDisplayName =
        (displayName != null && displayName!.trim().isNotEmpty)
            ? displayName!.trim()
            : 'Sinh viên FPT';
    final effectiveGreeting = greeting ?? subtitle ?? _defaultGreeting;
    final initial = effectiveDisplayName.isNotEmpty
        ? effectiveDisplayName.split(' ').last[0].toUpperCase()
        : 'S';

    return Container(
      color: backgroundColor,
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // 1. Bên trái: Avatar + Lời chào / Phụ đề & Tên người dùng
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    try {
                      context.go(AppRoute.profile.path);
                    } catch (_) {}
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryBorder,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: avatarUrl != null &&
                                  avatarUrl!.trim().isNotEmpty
                              ? Image.network(
                                  avatarUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) =>
                                      _buildFallbackAvatar(initial),
                                )
                              : _buildFallbackAvatar(initial),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              effectiveGreeting,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 1.5),
                            Text(
                              effectiveDisplayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // 2. Bên phải: Nút Search (nếu có) + Nút chuông thông báo
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showSearch) ...[
                    _HeaderIconButton(
                      icon: Icons.search_rounded,
                      tooltip: 'Tìm kiếm khóa học',
                      onTap: onSearchTap ??
                          () {
                            try {
                              context.go(AppRoute.courses.path);
                            } catch (_) {}
                          },
                    ),
                    const SizedBox(width: 8),
                  ],

                  // Nút Chuông thông báo
                  _HeaderIconButton(
                    icon: Icons.notifications_none_rounded,
                    tooltip: 'Thông báo',
                    hasBadge: notificationCount > 0,
                    onTap: onNotificationTap ??
                        () =>
                            context.showSnackBar('Chưa có thông báo mới nào.'),
                  ),

                  if (trailing != null) ...[
                    const SizedBox(width: 8),
                    trailing!,
                  ],
                ],
              ),
            ],
          ),

          if (bottom != null) ...[
            const SizedBox(height: 10),
            bottom!,
          ],
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar(String initial) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.hasBadge = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
  final bool hasBadge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Icon(
                  icon,
                  size: 21,
                  color: AppColors.iconPrimary,
                ),
              ),
              if (hasBadge)
                Positioned(
                  top: 9,
                  right: 9,
                  child: Container(
                    width: 7.5,
                    height: 7.5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
