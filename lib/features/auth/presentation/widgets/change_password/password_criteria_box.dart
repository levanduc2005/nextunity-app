import 'package:flutter/material.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Hộp hiển thị các tiêu chí mật khẩu mạnh (Password Criteria Box).
class PasswordCriteriaBox extends StatelessWidget {
  final bool hasMin8Chars;
  final bool hasUpperAndLower;
  final bool hasNumber;

  const PasswordCriteriaBox({
    super.key,
    required this.hasMin8Chars,
    required this.hasUpperAndLower,
    required this.hasNumber,
  });

  @override
  Widget build(BuildContext context) {
    final isAllValid = hasMin8Chars && hasUpperAndLower && hasNumber;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isAllValid ? AppColors.successSurfaceLight : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAllValid ? AppColors.successContainer : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItem('Tối thiểu 8 ký tự', hasMin8Chars),
          const SizedBox(height: 6),
          _buildItem('Bao gồm chữ hoa và chữ thường', hasUpperAndLower),
          const SizedBox(height: 6),
          _buildItem('Bao gồm ít nhất 1 chữ số', hasNumber),
        ],
      ),
    );
  }

  Widget _buildItem(String label, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
          size: 16,
          color: isValid ? const Color(0xFF2E7D32) : AppColors.textMuted,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: isValid ? FontWeight.w600 : FontWeight.w400,
            color: isValid ? const Color(0xFF1B5E20) : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
