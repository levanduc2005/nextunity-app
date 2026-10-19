import 'package:flutter/material.dart';

/// Hàng 2 nút Hủy và Lưu Thay Đổi trên trang chỉnh sửa thông tin
class EditProfileActionButtons extends StatelessWidget {
  const EditProfileActionButtons({
    super.key,
    required this.isUpdating,
    required this.onCancel,
    required this.onSubmit,
  });

  final bool isUpdating;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Nút Hủy
        Expanded(
          flex: 2,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: isUpdating ? null : onCancel,
            child: const Text(
              'Hủy',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Nút Lưu Thay Đổi
        Expanded(
          flex: 3,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              elevation: 3,
              shadowColor: const Color(0xFF2563EB).withValues(alpha: 0.35),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: isUpdating
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.check_circle_rounded, size: 20),
            label: Text(
              isUpdating ? 'Đang lưu...' : 'Lưu Thay Đổi',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            onPressed: isUpdating ? null : onSubmit,
          ),
        ),
      ],
    );
  }
}
