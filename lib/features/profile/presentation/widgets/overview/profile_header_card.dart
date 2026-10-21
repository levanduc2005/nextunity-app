import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/profile_avatar_badge.dart';
import 'package:rental_car/features/profile/presentation/widgets/decorations/profile_stationery_decorations.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_stats_row.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    final displayName = user?.displayName ?? 'Sinh viên NextUnity';
    final isPlus = user?.isPlus == true;
    final university = user?.university ?? 'FPT University';
    final studentId = user?.studentId;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Thẻ nền trắng Stationery với bo góc lớn
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
                padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Avatar với vòng gradient và nút camera
                    ProfileAvatarBadge(
                      avatarUrl: user?.avatarUrl,
                      displayName: displayName,
                      radius: 38,
                    ),
                    const SizedBox(height: 8),

                    // Tên người dùng & PRO Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            displayName,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.4,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (isPlus)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFDE68A), Color(0xFFF59E0B)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFFBBF24),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFD97706,
                                  ).withValues(alpha: 0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Text(
                              'PLUS ✦',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF78350F),
                                letterSpacing: 0.2,
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () =>
                                context.push(AppRoute.upgradePlus.path),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFCBD5E1),
                                ),
                              ),
                              child: const Text(
                                'FREE',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Thông tin Trường Đại học
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          size: 13,
                          color: Color(0xFF2563EB),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            university,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Badges: MSSV & Chuyên ngành (Wrap an toàn, không bao giờ overflow)
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (studentId != null && studentId.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Text(
                              'MSSV: $studentId',
                              style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF475569),
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1.5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFDBEAFE)),
                          ),
                          child: Text(
                            user?.major ?? (user?.role ?? 'Sinh viên'),
                            style: const TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Nút Hồ sơ cá nhân
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: const Color(
                            0xFF2563EB,
                          ).withValues(alpha: 0.3),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.person_outline_rounded,
                          size: 18,
                        ),
                        label: const Text(
                          'Hồ sơ cá nhân',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () =>
                            context.push(AppRoute.editProfile.path),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 4 ô thống kê Khóa học • Điểm thưởng • MSSV • Streak
                    ProfileStatsRow(user: user),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Ghim đỏ 3D (Push Pin) góc trên bên trái
        const Positioned(top: 0, left: 14, child: PushPinWidget()),

        // Thẻ Sticky Note góc trên bên phải
        const Positioned(top: -2, right: 2, child: ProfileStickyBadge()),
      ],
    );
  }
}
