import 'package:flutter/material.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_common.dart';
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
          'Forgot Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Enter your email to receive a password reset code',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF475569),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Form(
          key: formKey,
          child: AuthTextField(
            controller: emailController,
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(
              Icons.mail_outline_rounded,
              color: Color(0xFF3B82F6),
              size: 20,
            ),
            fillColor: const Color(0xFFF8FAFC),
            borderColor: const Color(0xFF60A5FA),
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
        ),
        const SizedBox(height: 18),
        AuthGradientButton(
          text: 'Send Reset Code',
          isLoading: isLoading,
          onPressed: onSendCode,
          height: 46,
        ),
      ],
    );
  }
}
