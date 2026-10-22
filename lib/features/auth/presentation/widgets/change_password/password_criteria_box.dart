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
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCFCE7)),
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
          color: isValid ? const Color(0xFF2E7D32) : const Color(0xFF94A3B8),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: isValid ? FontWeight.w600 : FontWeight.w400,
            color: isValid ? const Color(0xFF1B5E20) : const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
