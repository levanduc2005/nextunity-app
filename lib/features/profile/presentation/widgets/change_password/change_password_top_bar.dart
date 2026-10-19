import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/profile_top_circle_button.dart';

/// Thanh top bar của trang Đổi Mật Khẩu
class ChangePasswordTopBar extends StatelessWidget {
  const ChangePasswordTopBar({
    super.key,
    required this.step,
    required this.onBackStep,
  });

  final int step;
  final VoidCallback onBackStep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileTopCircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            tooltip: 'Quay lại',
            onTap: () {
              if (step == 1) {
                onBackStep();
              } else {
                context.pop();
              }
            },
          ),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Đổi Mật Khẩu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'Bảo mật tài khoản NextUnity',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(width: 36), // Cân bằng với nút back
        ],
      ),
    );
  }
}
