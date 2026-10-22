import 'package:flutter/material.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_gradient_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_text_field.dart';
import 'package:rental_car/features/auth/presentation/widgets/decorations/envelope_illustration.dart';

/// Bước 1 của Quên mật khẩu: Nhập email để nhận mã xác thực.
class ForgotPasswordEmailStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback onSendCode;

  const ForgotPasswordEmailStep({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.isLoading,
    required this.onSendCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const EnvelopeIllustration(),
        const SizedBox(height: 16),
        const Text(
          'Quên mật khẩu?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Nhập email của bạn để nhận mã OTP đặt lại mật khẩu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 22),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Email tài khoản',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 7),
              AuthTextField(
                controller: emailController,
                hintText: 'sinhvien@fpt.edu.vn',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.mail_outline_rounded,
                  color: Color(0xFF94A3B8),
                  size: 20,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Vui lòng nhập địa chỉ email';
                  }
                  if (!val.contains('@')) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        AuthGradientButton(
          text: 'Gửi mã xác thực',
          isLoading: isLoading,
          onPressed: onSendCode,
          height: 50,
        ),
      ],
    );
  }
}
