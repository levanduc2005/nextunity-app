import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/presentation/widgets/decorations/profile_stationery_decorations.dart';

/// Chế độ xem chi tiết hồ sơ cá nhân (Read-Only Mode)
/// theo phong cách Stationery / Sổ tay sinh viên NextUnity.
class ProfileDetailView extends StatelessWidget {
  const ProfileDetailView({
    super.key,
    required this.user,
    required this.onEdit,
  });

  final UserEntity? user;
  final VoidCallback onEdit;

  IconData _genderIcon(String? gender) {
    final g = gender?.toUpperCase();
    if (g == 'MALE') return Icons.male_rounded;
    if (g == 'FEMALE') return Icons.female_rounded;
    return Icons.transgender_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl = user?.avatarUrl;
    final fullName = user?.fullName?.trim().isNotEmpty == true
        ? user!.fullName!
        : (user?.displayName ?? 'Chưa đặt tên');
    final email = user?.email ?? '';
    final studentId = user?.studentId?.trim().isNotEmpty == true
        ? user!.studentId!
        : 'Chưa cập nhật';
    final university = user?.university?.trim().isNotEmpty == true
        ? user!.university!
        : 'FPT University';
    final major = user?.major?.trim().isNotEmpty == true
        ? user!.major!
        : 'Chưa cập nhật';
    final cohort = user?.cohort != null ? 'K${user!.cohort}' : 'Chưa cập nhật';
    final gender = user?.genderDisplayName ?? 'Chưa cập nhật';
    final bio = user?.bio?.trim().isNotEmpty == true
        ? user!.bio!
        : 'Chưa có lời giới thiệu bản thân.';
    final isPlus = user?.isPlus == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // THẺ STATIONERY HIỂN THỊ CHI TIẾT
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10, bottom: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: Colors.white, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF183A78).withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CustomPaint(
                  painter: const StitchedBorderPainter(),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.95),
                          const Color(0xFFF8FBFF).withValues(alpha: 0.7),
                          const Color(0xFFF2F7FF).withValues(alpha: 0.4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 1. AVATAR & TÊN & BADGES
                        Center(
                          child: Column(
                            children: [
                              AppAvatar(
                                name: fullName,
                                imageUrl: avatarUrl,
                                radius: 46,
                                isPlus: isPlus,
                              ),
                              const SizedBox(height: 12),

                              // Tên người dùng
                              Text(
                                fullName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Email
                              Text(
                                email,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Badge Hàng (MSSV, Gói thành viên)
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  _BadgeChip(
                                    icon: Icons.tag_rounded,
                                    label: studentId,
                                    bgColor: AppColors.primaryContainer,
                                    textColor: AppColors.primary,
                                  ),
                                  _BadgeChip(
                                    icon: isPlus
                                        ? Icons.stars_rounded
                                        : Icons.school_rounded,
                                    label: isPlus ? 'PLUS MEMBER' : 'SINH VIÊN',
                                    bgColor: isPlus
                                        ? const Color(0xFFFEF3C7)
                                        : AppColors.surfaceSubtle,
                                    textColor: isPlus
                                        ? const Color(0xFFD97706)
                                        : AppColors.textSecondaryDark,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 2. NHÓM: THÔNG TIN HỌC TẬP
                        const _SectionHeader(
                          icon: Icons.school_outlined,
                          title: 'Thông tin học tập',
                        ),
                        const SizedBox(height: 10),
                        _InfoRowTile(
                          icon: Icons.account_balance_outlined,
                          label: 'Trường đại học',
                          value: university,
                        ),
                        _InfoRowTile(
                          icon: Icons.tag_rounded,
                          label: 'Mã số sinh viên (MSSV)',
                          value: studentId,
                        ),
                        _InfoRowTile(
                          icon: Icons.computer_rounded,
                          label: 'Chuyên ngành',
                          value: major,
                        ),
                        _InfoRowTile(
                          icon: Icons.layers_outlined,
                          label: 'Khóa học',
                          value: cohort,
                          isLast: true,
                        ),
                        const SizedBox(height: 18),

                        // 3. NHÓM: THÔNG TIN CÁ NHÂN
                        const _SectionHeader(
                          icon: Icons.badge_outlined,
                          title: 'Thông tin cá nhân',
                        ),
                        const SizedBox(height: 10),
                        _InfoRowTile(
                          icon: _genderIcon(user?.gender),
                          label: 'Giới tính',
                          value: gender,
                        ),
                        _InfoRowTile(
                          icon: Icons.alternate_email_rounded,
                          label: 'Email liên kết',
                          value: email,
                          isLast: true,
                        ),
                        const SizedBox(height: 18),

                        // 4. NHÓM: TIỂU SỬ / BIO
                        const _SectionHeader(
                          icon: Icons.format_quote_rounded,
                          title: 'Giới thiệu bản thân',
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceSubtle.withValues(
                              alpha: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            bio,
                            style: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: user?.bio?.trim().isNotEmpty == true
                                  ? AppColors.textLabel
                                  : AppColors.textMuted,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Ghim đỏ 3D Push Pin góc trên bên trái
            const Positioned(top: 0, left: 14, child: PushPinWidget()),

            // Thẻ Sticky Note góc trên bên phải
            const Positioned(top: -2, right: 2, child: ProfileStickyBadge()),
          ],
        ),
        const SizedBox(height: 16),

        // NÚT CHUYỂN SANG CHẾ ĐỘ CHỈNH SỬA
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 3,
            shadowColor: AppColors.primary.withValues(alpha: 0.35),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: const Icon(Icons.edit_note_rounded, size: 22),
          label: const Text(
            'Chỉnh Sửa Hồ Sơ',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          onPressed: onEdit,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.iconPrimary),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

class _InfoRowTile extends StatelessWidget {
  const _InfoRowTile({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.surfaceSubtle.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: AppColors.iconPrimary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  final IconData icon;
  final String label;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
