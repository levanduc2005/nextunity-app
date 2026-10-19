import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_common.dart';

/// Form nhập liệu đăng nhập (Email/Password) bao gồm nút Sign In, Quên MK và Điều khoản.
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tiêu đề Card
          const Text(
            'Sign In To Your Account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),

          // Trường Email / Username
          AuthTextField(
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập Email hoặc Username';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),

          // Trường Password
          AuthTextField(
            controller: _passwordController,
            hintText: 'Password',
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF818CF8),
                size: 20,
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
          const SizedBox(height: 14),

          // Nút Sign In Gradient
          AuthGradientButton(
            text: 'Sign In',
            height: 44,
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
          const SizedBox(height: 12),

          // Link Quên mật khẩu
          GestureDetector(
            onTap: () {
              context.pushNamed(AppRoute.forgotPassword.name);
            },
            child: const Text(
              'Forgot Password ?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0284C7),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Điều khoản & Chính sách
          const AuthTermsText(),
        ],
      ),
    );
  }
}
