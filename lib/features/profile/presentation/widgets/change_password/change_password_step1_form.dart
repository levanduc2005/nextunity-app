import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/edit_profile_text_field.dart';

/// Form Bước 1: Xác thực mật khẩu hiện tại
class ChangePasswordStep1Form extends StatelessWidget {
  const ChangePasswordStep1Form({
    super.key,
    required this.formKey,
    required this.currentPasswordController,
    required this.isLoading,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController currentPasswordController;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        key: const ValueKey('step_1'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icon bảo mật
          Center(
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.lock_person_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Tiêu đề & Phụ đề
          const Text(
            'Xác Thực Mật Khẩu Hiện Tại',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Để bảo vệ an toàn cho tài khoản của bạn, vui lòng nhập mật khẩu hiện tại trước khi thiết lập mật khẩu mới.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          // Ô nhập mật khẩu hiện tại
          EditProfileTextField(
            controller: currentPasswordController,
            label: 'Mật khẩu hiện tại',
            hint: 'Nhập mật khẩu hiện tại của bạn',
            prefixIcon: Icons.lock_outline_rounded,
            isRequired: true,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Vui lòng nhập mật khẩu hiện tại';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),

          // Quên mật khẩu link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.push(AppRoute.forgotPassword.path),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Bạn quên mật khẩu?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Nút Xác thực & Tiếp tục
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              elevation: 3,
              shadowColor: const Color(0xFF2563EB).withValues(alpha: 0.35),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.arrow_forward_rounded, size: 20),
            label: Text(
              isLoading ? 'Đang kiểm tra...' : 'Tiếp Tục',
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            onPressed: isLoading ? null : onSubmit,
          ),
        ],
      ),
    );
  }
}
