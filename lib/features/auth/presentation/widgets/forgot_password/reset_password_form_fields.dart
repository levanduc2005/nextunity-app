import 'package:flutter/material.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_text_field.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Cụm hai ô nhập Mật khẩu mới và Xác nhận mật khẩu kèm icon ẩn/hiện
class ResetPasswordFormFields extends StatelessWidget {
  const ResetPasswordFormFields({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onToggleObscurePassword,
    required this.onToggleObscureConfirmPassword,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onToggleObscurePassword;
  final VoidCallback onToggleObscureConfirmPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Input 1: Password
        const Text(
          'Mật khẩu mới',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textLabel,
          ),
        ),
        const SizedBox(height: 7),
        AuthTextField(
          controller: passwordController,
          hintText: 'Nhập mật khẩu mới',
          obscureText: obscurePassword,
          prefixIcon: const Icon(
            Icons.lock_outline_rounded,
            size: 20,
            color: AppColors.textMuted,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.textMuted,
              size: 20,
            ),
            onPressed: onToggleObscurePassword,
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Vui lòng nhập mật khẩu';
            }
            return null;
          },
        ),
        const SizedBox(height: 14),

        // Input 2: Confirm Password
        const Text(
          'Xác nhận mật khẩu',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textLabel,
          ),
        ),
        const SizedBox(height: 7),
        AuthTextField(
          controller: confirmPasswordController,
          hintText: 'Nhập lại mật khẩu mới',
          obscureText: obscureConfirmPassword,
          prefixIcon: const Icon(
            Icons.lock_reset_rounded,
            size: 20,
            color: AppColors.textMuted,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureConfirmPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.textMuted,
              size: 20,
            ),
            onPressed: onToggleObscureConfirmPassword,
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Vui lòng xác nhận mật khẩu';
            }
            if (val != passwordController.text) {
              return 'Mật khẩu xác nhận không khớp';
            }
            return null;
          },
        ),
      ],
    );
  }
}
