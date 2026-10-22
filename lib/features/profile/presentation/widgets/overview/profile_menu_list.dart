import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';

/// Danh sách Menu trang Hồ sơ cá nhân theo phong cách Grouped Cards hiện đại
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // NHÓM 1: TÀI KHOẢN & BẢO MẬT
        const _SectionHeader(title: 'TÀI KHOẢN & BẢO MẬT'),
        const SizedBox(height: 6),
        _GroupCard(
          children: [
            _MenuTile(
              icon: Icons.lock_reset_rounded,
              iconColor: AppColors.primary,
              iconBgColor: AppColors.primaryContainer,
              title: 'Đổi mật khẩu',
              subtitle: 'Cập nhật mật khẩu bảo vệ tài khoản',
              onTap: () => context.push(AppRoute.changePassword.path),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // NHÓM 2: HỆ THỐNG & HỖ TRỢ
        const _SectionHeader(title: 'HỖ TRỢ & THÔNG TIN'),
        const SizedBox(height: 6),
        _GroupCard(
          children: [
            _MenuTile(
              icon: Icons.help_outline_rounded,
              iconColor: const Color(0xFF0284C7),
              iconBgColor: const Color(0xFFF0F9FF),
              title: 'Trợ giúp & FAQ',
              subtitle: 'Hướng dẫn sử dụng và câu hỏi thường gặp',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'NextUnity Platform',
                  applicationVersion: '2.4.0',
                  applicationLegalese:
                      '© 2026 NextUnity Platform. Nền tảng học tập thông minh cho sinh viên.',
                );
              },
            ),
            const _MenuDivider(),
            _MenuTile(
              icon: Icons.info_outline_rounded,
              iconColor: const Color(0xFF64748B),
              iconBgColor: const Color(0xFFF1F5F9),
              title: 'Về NextUnity Studio',
              subtitle: 'Phiên bản 2.4.0 (Bản phát hành chính thức)',
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
          ],
        ),

        const SizedBox(height: 16),

        // NHÓM 3: ĐĂNG XUẤT
        _GroupCard(
          children: [
            _MenuTile(
              icon: Icons.logout_rounded,
              iconColor: const Color(0xFFDC2626),
              iconBgColor: const Color(0xFFFEF2F2),
              title: 'Đăng xuất tài khoản',
              subtitle: 'Thoát phiên đăng nhập trên thiết bị này',
              titleColor: const Color(0xFFDC2626),
              showChevron: false,
              onTap: onLogout,
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
          color: Color(0xFF94A3B8),
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(children: children),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleColor = AppColors.textPrimary,
    this.showChevron = true,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color titleColor;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
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
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (showChevron)
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Color(0xFF94A3B8),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 64, right: 14),
      child: Divider(height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
    );
  }
}
