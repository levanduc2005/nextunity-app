import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/profile_top_circle_button.dart';

/// Top App Bar linh hoạt giữa chế độ Xem hồ sơ và chế độ Chỉnh sửa hồ sơ
class EditProfileTopBar extends StatelessWidget {
  const EditProfileTopBar({
    super.key,
    required this.isEditing,
    required this.isUpdating,
    required this.onBack,
    required this.onCancel,
    required this.onStartEdit,
    required this.onSave,
  });

  final bool isEditing;
  final bool isUpdating;
  final VoidCallback onBack;
  final VoidCallback onCancel;
  final VoidCallback onStartEdit;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nút Back hoặc Nút Hủy
          ProfileTopCircleButton(
            icon: isEditing
                ? Icons.close_rounded
                : Icons.arrow_back_ios_new_rounded,
            tooltip: isEditing ? 'Hủy' : 'Quay lại',
            onTap: isEditing ? onCancel : onBack,
          ),

          // Tiêu đề App Bar
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEditing ? 'Chỉnh Sửa Hồ Sơ' : 'Hồ Sơ Cá Nhân',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                isEditing
                    ? 'Cập nhật thông tin sinh viên'
                    : 'Thông tin sinh viên NextUnity',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),

          // Nút góc trên: Sửa (chế độ xem) hoặc Lưu nhanh (chế độ sửa)
          ProfileTopCircleButton(
            icon: isEditing ? Icons.check_rounded : Icons.edit_outlined,
            iconColor: AppColors.primary,
            tooltip: isEditing ? 'Lưu' : 'Chỉnh sửa',
            onTap: isEditing ? (isUpdating ? () {} : onSave) : onStartEdit,
          ),
        ],
      ),
    );
  }
}
