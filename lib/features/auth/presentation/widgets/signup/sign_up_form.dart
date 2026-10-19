import 'package:flutter/material.dart';
import 'package:rental_car/core/utils/validators.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_common.dart';

/// Form đăng ký tài khoản mới (Username, Email, Password, Confirm Password).
class SignUpForm extends StatefulWidget {
  final void Function(String fullName, String email, String password) onSignUp;
  final bool isLoading;

  const SignUpForm({super.key, required this.onSignUp, this.isLoading = false});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSignUp(
      _fullNameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tiêu đề form
          const Text(
            'Create Your Account',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),

          // Họ và tên
          AuthTextField(
            controller: _fullNameController,
            hintText: 'Full Name',
            borderColor: const Color(0xFF5B6CD4),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Vui lòng nhập họ và tên';
              }
              if (val.trim().length < 2) {
                return 'Họ và tên tối thiểu 2 ký tự';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),

          // Email
          AuthTextField(
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            borderColor: const Color(0xFF5B6CD4),
            validator: (val) => AppValidators.email(
              val,
              requiredMessage: 'Vui lòng nhập email',
              invalidMessage: 'Email không hợp lệ',
            ),
          ),
          const SizedBox(height: 10),

          // Password
          AuthTextField(
            controller: _passwordController,
            hintText: 'Password',
            obscureText: _obscurePassword,
            borderColor: const Color(0xFF5B6CD4),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF7988D8),
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              if (val.length < 6) {
                return 'Mật khẩu phải từ 6 ký tự';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),

          // Confirm Password
          AuthTextField(
            controller: _confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: _obscureConfirmPassword,
            borderColor: const Color(0xFF5B6CD4),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF7988D8),
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Vui lòng xác nhận mật khẩu';
              }
              if (val != _passwordController.text) {
                return 'Mật khẩu không khớp';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),

          // Nút Sign Up Gradient
          AuthGradientButton(
            text: 'Sign Up',
            isLoading: widget.isLoading,
            height: 44,
            gradientColors: const [Color(0xFF0D62D0), Color(0xFF518AD9)],
            shadowColor: const Color(0xFF0D62D0),
            onPressed: _submit,
          ),
          const SizedBox(height: 10),

          // Điều khoản & Chính sách
          const AuthTermsText(),
        ],
      ),
    );
  }
}
