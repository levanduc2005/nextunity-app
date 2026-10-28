import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/auth/presentation/widgets/change_password/password_criteria_box.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/edit_profile_text_field.dart';

/// Form Bước 2: Thiết lập và xác nhận mật khẩu mới
class ChangePasswordStep2Form extends StatelessWidget {
  const ChangePasswordStep2Form({
    super.key,
    required this.formKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.hasMin8Chars,
    required this.hasUpperAndLower,
    required this.hasNumber,
    required this.isLoading,
    required this.onBack,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool hasMin8Chars;
  final bool hasUpperAndLower;
  final bool hasNumber;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        key: const ValueKey('step_2'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icon thành công bước 1
          Center(
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Tiêu đề & Phụ đề
          const Text(
            'Thiết Lập Mật Khẩu Mới',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Mật khẩu hiện tại đã chính xác. Hãy tạo mật khẩu mới an toàn cho tài khoản của bạn.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),

          // Ô 1: Mật khẩu mới
          EditProfileTextField(
            controller: newPasswordController,
            label: 'Mật khẩu mới',
            hint: 'Nhập mật khẩu mới',
            prefixIcon: Icons.key_rounded,
            isRequired: true,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Vui lòng nhập mật khẩu mới';
              }
              if (v.length < 8) {
                return 'Mật khẩu phải có ít nhất 8 ký tự';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),

          // Ô 2: Xác nhận mật khẩu mới
          EditProfileTextField(
            controller: confirmPasswordController,
            label: 'Xác nhận mật khẩu mới',
            hint: 'Nhập lại mật khẩu mới',
            prefixIcon: Icons.lock_reset_rounded,
            isRequired: true,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Vui lòng xác nhận mật khẩu mới';
              }
              if (v != newPasswordController.text) {
                return 'Mật khẩu xác nhận không khớp';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),

          // Bảng tiêu chuẩn mật khẩu
          PasswordCriteriaBox(
            hasMin8Chars: hasMin8Chars,
            hasUpperAndLower: hasUpperAndLower,
            hasNumber: hasNumber,
          ),
          const SizedBox(height: 20),

          // Hàng nút: Quay lại bước 1 & Lưu mật khẩu mới
          Row(
            children: [
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.borderMedium),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: isLoading ? null : onBack,
                  child: const Text(
                    'Quay lại',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: ElevatedButton.icon(
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
                  icon: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.check_circle_rounded, size: 20),
                  label: Text(
                    isLoading ? 'Đang lưu...' : 'Lưu Mật Khẩu',
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  onPressed: isLoading ? null : onSubmit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
