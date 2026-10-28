import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_gradient_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_text_field.dart';

/// Form nhập liệu đăng nhập (Email/Password) chuẩn phong cách ApSkil EdTech.
class LoginForm extends StatefulWidget {
  final void Function(String email, String password) onSignIn;
  final bool isLoading;

  const LoginForm({super.key, required this.onSignIn, this.isLoading = false});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSignIn(_emailController.text.trim(), _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Nhãn & Ô nhập Email
          const Text(
            'Email',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textLabel,
            ),
          ),
          const SizedBox(height: 4),
          AuthTextField(
            controller: _emailController,
            hintText: 'sinhvien@fpt.edu.vn',
            keyboardType: TextInputType.emailAddress,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            prefixIcon: const Icon(
              Icons.mail_outline_rounded,
              size: 19,
              color: AppColors.textMuted,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập Email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),

          // 2. Nhãn & Ô nhập Password
          const Text(
            'Mật khẩu',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textLabel,
            ),
          ),
          const SizedBox(height: 4),
          AuthTextField(
            controller: _passwordController,
            hintText: 'Nhập mật khẩu của bạn',
            obscureText: _obscurePassword,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              size: 19,
              color: AppColors.textMuted,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textMuted,
                size: 19,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              return null;
            },
          ),
          const SizedBox(height: 6),

          // 3. Link Quên mật khẩu
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                context.pushNamed(AppRoute.forgotPassword.name);
              },
              child: const Text(
                'Quên mật khẩu?',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // 4. Nút Đăng nhập
          AuthGradientButton(
            text: 'Đăng nhập',
            height: 46,
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
