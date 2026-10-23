import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Nút tròn góc trên tiêu chuẩn cho toàn bộ màn hình Profile & Edit Profile
class ProfileTopCircleButton extends StatelessWidget {
  const ProfileTopCircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.textLabel,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.white.withValues(alpha: 0.85),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
