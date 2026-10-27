import 'package:flutter/material.dart';

/// Huy hiệu nổi góc trên bên phải thẻ gói cước (ví dụ: Phổ biến nhất)
class PlusPlanFloatingBadge extends StatelessWidget {
  const PlusPlanFloatingBadge({
    super.key,
    required this.tag,
    required this.isSelected,
  });

  final String tag;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -11,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                )
              : null,
          color: isSelected ? null : const Color(0xFF475569),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFFF59E0B).withValues(alpha: 0.38)
                  : Colors.black26,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.local_fire_department_rounded,
              color: Colors.white,
              size: 13,
            ),
            const SizedBox(width: 3),
            Text(
              tag,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
