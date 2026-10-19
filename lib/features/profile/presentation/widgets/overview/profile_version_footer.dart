import 'package:flutter/material.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Chân trang hiển thị thông tin phiên bản NextUnity và liên kết điều khoản
class ProfileVersionFooter extends StatelessWidget {
  const ProfileVersionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'NEXTUNITY Studio v2.4',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            '•',
            style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 12),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () {
              context.showSnackBar('Điều khoản sử dụng NextUnity 2026');
            },
            child: const Text(
              'Điều khoản',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3B82F6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
