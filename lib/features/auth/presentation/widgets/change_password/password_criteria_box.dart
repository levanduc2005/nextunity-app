import 'package:flutter/material.dart';

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFD2E8F8).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItem('At least 8 characters', hasMin8Chars),
          const SizedBox(height: 6),
          _buildItem('Include uppercase and lowercase', hasUpperAndLower),
          const SizedBox(height: 6),
          _buildItem('Include a number', hasNumber),
        ],
      ),
    );
  }

  Widget _buildItem(String label, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle_rounded : Icons.circle_outlined,
          size: 15,
          color: isValid ? const Color(0xFF047857) : const Color(0xFF0E6F5C),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: isValid ? FontWeight.w700 : FontWeight.w500,
            color: const Color(0xFF0E6F5C),
          ),
        ),
      ],
    );
  }
}
