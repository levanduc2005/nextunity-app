import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({
    super.key,
    required this.user,
    required this.onLogout,
  });

  final UserEntity? user;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final isPlus = user?.isPlus == true;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. My Certificates
          _MenuTile(
            icon: Icons.workspace_premium_rounded,
            iconBgColor: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF2563EB),
            title: 'My Certificates',
            subtitle: 'Chứng chỉ & Bằng hoàn thành khóa học',
            trailingBadge: '3 New',
            onTap: () {
              context.showSnackBar(
                'Tính năng chứng chỉ sẽ mở khi bạn hoàn thành khóa học',
              );
            },
          ),
          const _MenuDivider(),

          // 2. Gói thành viên & Nâng cấp PLUS
          _MenuTile(
            icon: Icons.auto_awesome_rounded,
            iconBgColor: const Color(0xFFFEF3C7),
            iconColor: const Color(0xFFD97706),
            title: isPlus ? 'Gói Thành Viên PLUS' : 'Nâng cấp NextUnity PLUS',
            subtitle: isPlus
                ? 'Đang hoạt động (Không giới hạn tính năng)'
                : 'Thanh toán tự động qua PayOS QR',
            trailingBadge: isPlus ? 'ACTIVE' : 'HOT',
            badgeBgColor: isPlus
                ? const Color(0xFFECFDF5)
                : const Color(0xFFFEF3C7),
            badgeTextColor: isPlus
                ? const Color(0xFF059669)
                : const Color(0xFFB45309),
            onTap: () => context.push(AppRoute.upgradePlus.path),
          ),
          const _MenuDivider(),

          // 3. Learning Goals & Streak
          _MenuTile(
            icon: Icons.flag_rounded,
            iconBgColor: const Color(0xFFEEF2FF),
            iconColor: const Color(0xFF4F46E5),
            title: 'Learning Goals & Streak',
            subtitle: 'Mục tiêu tuần: 80% hoàn thành',
            trailingBadge: '80%',
            badgeBgColor: const Color(0xFFEEF2FF),
            badgeTextColor: const Color(0xFF4F46E5),
            onTap: () {
              context.showSnackBar(
                'Chuỗi streak hiện tại: ${user?.streak ?? 0} ngày 🔥',
              );
            },
          ),
          const _MenuDivider(),

          // 4. Saved & Downloads
          _MenuTile(
            icon: Icons.bookmark_rounded,
            iconBgColor: const Color(0xFFECFDF5),
            iconColor: const Color(0xFF059669),
            title: 'Saved & Downloads',
            subtitle: 'Tài liệu và bài giảng ngoại tuyến',
            trailingBadge: '18 files',
            badgeBgColor: const Color(0xFFECFDF5),
            badgeTextColor: const Color(0xFF047857),
            onTap: () {
              context.showSnackBar('Đang đồng bộ tài liệu ngoại tuyến');
            },
          ),
          const _MenuDivider(),

          // 5. Account & Security
          _MenuTile(
            icon: Icons.shield_outlined,
            iconBgColor: const Color(0xFFF1F5F9),
            iconColor: const Color(0xFF475569),
            title: 'Account & Security',
            subtitle: 'Đổi mật khẩu, quyền riêng tư',
            onTap: () => context.push(AppRoute.changePassword.path),
          ),
          const _MenuDivider(),

          // 6. Help & Support
          _MenuTile(
            icon: Icons.support_agent_rounded,
            iconBgColor: const Color(0xFFFAF5FF),
            iconColor: const Color(0xFF9333EA),
            title: 'Help & Support',
            subtitle: 'FAQ, liên hệ trợ giúp NextUnity Studio',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'NextUnity Studio',
                applicationVersion: '2.4.0',
                applicationLegalese:
                    '© 2026 NextUnity Platform. All rights reserved.',
              );
            },
          ),
          const _MenuDivider(),

          // 7. Đăng xuất (Logout) - Màu đỏ nhẹ nhàng
          _MenuTile(
            icon: Icons.logout_rounded,
            iconBgColor: const Color(0xFFFEF2F2),
            iconColor: const Color(0xFFDC2626),
            title: 'Đăng xuất tài khoản',
            subtitle: 'Thoát phiên đăng nhập trên thiết bị này',
            titleColor: const Color(0xFFDC2626),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailingBadge,
    this.badgeBgColor = const Color(0xFFEFF6FF),
    this.badgeTextColor = const Color(0xFF2563EB),
    this.titleColor = const Color(0xFF0F172A),
  });

  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String? trailingBadge;
  final Color badgeBgColor;
  final Color badgeTextColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 1.5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF94A3B8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (trailingBadge != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trailingBadge!,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: badgeTextColor,
                  ),
                ),
              ),
            ],
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 62,
      endIndent: 14,
      color: Color(0xFFF1F5F9),
    );
  }
}
