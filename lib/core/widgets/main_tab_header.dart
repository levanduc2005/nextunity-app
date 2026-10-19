import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/app_snack_bar.dart';

/// Top App Bar thống nhất cho toàn bộ các Tab chính (Home, Courses, AI, Community, Profile).
/// Bên trái: Logo NextUnity AI & phụ đề tab / lời chào sinh viên.
/// Bên phải: Huy hiệu Streak (🔥) và Nút Chuông thông báo như trang Home.
class MainTabHeader extends StatelessWidget {
  const MainTabHeader({
    super.key,
    this.subtitle,
    this.streak,
    this.displayName,
    this.showAvatar = false,
    this.avatarUrl,
    this.isPlus,
    this.onNotificationTap,
    this.trailing,
    this.bottom,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.backgroundColor,
  });

  /// Phụ đề bên dưới thương hiệu NEXTUNITY (vd: 'Chào Nam 👋', 'Học tập & Lộ trình', v.v.)
  final String? subtitle;

  /// Số ngày streak học tập (mặc định 15).
  final int? streak;

  /// Tên hiển thị người dùng (mặc định 'Học viên').
  final String? displayName;

  /// Có hiển thị avatar người dùng ở góc phải hay không (như trang Home).
  final bool showAvatar;

  final String? avatarUrl;
  final bool? isPlus;

  /// Callback khi ấn vào icon chuông thông báo.
  final VoidCallback? onNotificationTap;

  /// Widget tùy chọn thêm vào sau chuông thông báo.
  final Widget? trailing;

  /// Widget mở rộng phía dưới header (vd: search bar, chip trường).
  final Widget? bottom;

  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final effectiveStreak = streak ?? 15;
    final effectiveDisplayName = displayName ?? 'Học viên';
    final displaySubtitle = subtitle ?? 'Chào $effectiveDisplayName 👋';

    final effectiveAvatarUrl = avatarUrl;
    final effectiveIsPlus = isPlus ?? false;

    return Container(
      color: backgroundColor,
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. Bên trái: Logo App & Thương hiệu NEXTUNITY AI
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFDBEAFE)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF1E3A8A,
                            ).withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'public/app_logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.school_rounded,
                          color: Color(0xFF1D4ED8),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'NEXT',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF0F172A),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const Text(
                                  'UNITY',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primary,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDBEAFE),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'AI',
                                    style: TextStyle(
                                      color: Color(0xFF1D4ED8),
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            displaySubtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // 2. Bên phải: Streak Badge & Icon Chuông thông báo
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Huy hiệu Streak (🔥)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFED7AA)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 3),
                        Text(
                          '${effectiveStreak}d',
                          style: const TextStyle(
                            color: Color(0xFFEA580C),
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Nút Chuông thông báo kèm chấm đỏ
                  InkWell(
                    onTap:
                        onNotificationTap ??
                        () =>
                            context.showSnackBar('Chưa có thông báo mới nào.'),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_none_rounded,
                            size: 19,
                            color: Color(0xFF475569),
                          ),
                          Positioned(
                            top: 7,
                            right: 7,
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF43F5E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Avatar tùy chọn
                  if (showAvatar) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => context.push(AppRoute.profile.path),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFBBF24),
                                  Color(0xFFF97316),
                                  Color(0xFF3D5AFE),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  (effectiveAvatarUrl != null &&
                                      effectiveAvatarUrl.isNotEmpty)
                                  ? NetworkImage(effectiveAvatarUrl)
                                  : null,
                              onBackgroundImageError:
                                  (effectiveAvatarUrl != null &&
                                      effectiveAvatarUrl.isNotEmpty)
                                  ? (_, _) {}
                                  : null,
                              child: const Icon(
                                Icons.person,
                                size: 18,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                          if (effectiveIsPlus)
                            Positioned(
                              bottom: -2,
                              right: -3,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFF59E0B),
                                      Color(0xFFD97706),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'PLUS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 7,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],

                  if (trailing != null) ...[
                    const SizedBox(width: 8),
                    trailing!,
                  ],
                ],
              ),
            ],
          ),

          if (bottom != null) ...[const SizedBox(height: 10), bottom!],
        ],
      ),
    );
  }
}
