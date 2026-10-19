import 'package:flutter/material.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_reaction_button.dart';

/// Huy hiệu hiển thị các loại cảm xúc nổi bật xếp chồng kèm tổng số lượt tương tác
class ReactionCounterBadge extends StatelessWidget {
  const ReactionCounterBadge({
    super.key,
    required this.topReactions,
    required this.totalCount,
    this.onTap,
  });

  final List<ReactionType> topReactions;
  final int totalCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (totalCount <= 0) return const SizedBox.shrink();

    // Lấy tối đa 2 loại cảm xúc cao nhất
    final iconsToShow = topReactions.take(2).toList();
    if (iconsToShow.isEmpty) {
      iconsToShow.add(ReactionType.like);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cụm các icon cảm xúc xếp chồng nhau (Overlapping emojis)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < iconsToShow.length; i++) ...[
                  Transform.translate(
                    offset: Offset(i == 0 ? 0 : -5.0 * i, 0),
                    child: Container(
                      padding: const EdgeInsets.all(0.5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Text(
                        iconsToShow[i].emoji,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(width: iconsToShow.length > 1 ? 1 : 3),
            Text(
              '$totalCount',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
