import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/profile_common.dart';

/// Top App Bar hiển thị thương hiệu NextUnity và các nút tác vụ (Thông báo, Hồ sơ)
class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // NextUnity Brand
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(color: const Color(0xFFDBEAFE)),
                  ),
                  child: Image.asset(
                    'public/app_logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.school_rounded,
                      color: Color(0xFF1D4ED8),
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'NEXTUNITY',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E5D97),
                          letterSpacing: 0.8,
                          height: 1.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Learning Studio',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8),
                          height: 1.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Actions: Notification & Profile Button
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nút Thông báo kèm chấm đỏ
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ProfileTopCircleButton(
                    icon: Icons.notifications_none_rounded,
                    tooltip: 'Thông báo',
                    onTap: () {
                      context.showSnackBar('Không có thông báo mới');
                    },
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF43F5E),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),

              // Nút Xem thông tin cá nhân
              ProfileTopCircleButton(
                icon: Icons.person_outline_rounded,
                tooltip: 'Hồ sơ',
                onTap: () => context.push(AppRoute.editProfile.path),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
