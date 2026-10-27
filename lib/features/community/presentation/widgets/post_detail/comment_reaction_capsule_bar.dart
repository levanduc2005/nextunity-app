import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_type_ui.dart';

/// Thanh viên thuốc cảm xúc nổi hiển thị khi nhấn giữ bình luận
class CommentReactionCapsuleBar extends StatelessWidget {
  const CommentReactionCapsuleBar({
    super.key,
    required this.width,
    required this.height,
    required this.currentReaction,
    required this.onReactionSelected,
    required this.onReactionCleared,
  });

  final double width;
  final double height;
  final ReactionType? currentReaction;
  final ValueChanged<ReactionType> onReactionSelected;
  final VoidCallback onReactionCleared;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ReactionType.values.map((reaction) {
          final isSelected = currentReaction == reaction;
          return InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
              if (isSelected) {
                onReactionCleared();
              } else {
                onReactionSelected(reaction);
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? reaction.color.withAlpha(35)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: reaction.color, width: 1.5)
                    : null,
              ),
              child: Text(reaction.emoji, style: const TextStyle(fontSize: 22)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
