import 'package:flutter/material.dart';
import 'package:rental_car/core/utils/validators.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_gradient_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_text_field.dart';

/// Form đăng ký tài khoản mới (Họ tên, Email, Mật khẩu, Xác nhận mật khẩu) chuẩn ApSkil.
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Họ và tên
          const Text(
            'Họ và tên',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 4),
          AuthTextField(
            controller: _fullNameController,
            hintText: 'Nguyễn Văn A',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            prefixIcon: const Icon(
              Icons.person_outline_rounded,
              size: 19,
              color: Color(0xFF94A3B8),
            ),
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
          const SizedBox(height: 8),

          // 2. Email sinh viên
          const Text(
            'Email sinh viên',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
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
              color: Color(0xFF94A3B8),
            ),
            validator: (val) => AppValidators.email(
              val,
              requiredMessage: 'Vui lòng nhập email',
              invalidMessage: 'Email không hợp lệ',
            ),
          ),
          const SizedBox(height: 8),

          // 3. Mật khẩu
          const Text(
            'Mật khẩu',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 4),
          AuthTextField(
            controller: _passwordController,
            hintText: 'Tối thiểu 6 ký tự',
            obscureText: _obscurePassword,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              size: 19,
              color: Color(0xFF94A3B8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF94A3B8),
                size: 19,
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
          const SizedBox(height: 8),

          // 4. Xác nhận mật khẩu
          const Text(
            'Xác nhận mật khẩu',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 4),
          AuthTextField(
            controller: _confirmPasswordController,
            hintText: 'Nhập lại mật khẩu',
            obscureText: _obscureConfirmPassword,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            prefixIcon: const Icon(
              Icons.lock_reset_rounded,
              size: 19,
              color: Color(0xFF94A3B8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF94A3B8),
                size: 19,
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
          const SizedBox(height: 12),

          // 5. Nút Đăng ký tài khoản
          AuthGradientButton(
            text: 'Đăng ký tài khoản',
            isLoading: widget.isLoading,
            height: 44,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
