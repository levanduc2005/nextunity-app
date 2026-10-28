import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_reaction_popup.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_type_ui.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Nút bày tỏ cảm xúc bài viết:
/// - Chạm nhanh: Like / Bỏ cảm xúc hiện tại
/// - Nhấn giữ: Hiện thanh chọn 6 loại cảm xúc với animation nảy mượt mà
class PostReactionButton extends StatefulWidget {
  const PostReactionButton({
    super.key,
    required this.currentReaction,
    required this.onReactionSelected,
    required this.onReactionCleared,
    this.isCompact = false,
    this.showLabel = true,
  });

  final ReactionType? currentReaction;
  final ValueChanged<ReactionType> onReactionSelected;
  final VoidCallback onReactionCleared;
  final bool isCompact;
  final bool showLabel;

  @override
  State<PostReactionButton> createState() => _PostReactionButtonState();
}

class _PostReactionButtonState extends State<PostReactionButton>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _animController;
  final GlobalKey _buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    _animController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void _showReactionPopup() {
    _removeOverlay();
    _overlayEntry = PostReactionPopup.create(
      context: context,
      buttonKey: _buttonKey,
      animationController: _animController,
      currentReaction: widget.currentReaction,
      onReactionSelected: widget.onReactionSelected,
      onDismiss: _removeOverlay,
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _handleTap() {
    if (widget.currentReaction != null) {
      HapticFeedback.selectionClick();
      widget.onReactionCleared();
    } else {
      HapticFeedback.lightImpact();
      widget.onReactionSelected(ReactionType.like);
    }
  }

  @override
  Widget build(BuildContext context) {
    final reaction = widget.currentReaction;
    final isReacted = reaction != null;

    final Color color = isReacted ? reaction.color : AppColors.textSecondary;
    final String label = isReacted ? reaction.label : 'Thích';

    if (widget.isCompact) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          key: _buttonKey,
          onTap: _handleTap,
          onLongPress: _showReactionPopup,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isReacted)
                  const Icon(
                    Icons.thumb_up_alt_outlined,
                    size: 13,
                    color: AppColors.textSecondary,
                  )
                else if (reaction == ReactionType.like)
                  const Icon(
                    Icons.thumb_up_alt_rounded,
                    size: 13,
                    color: Color(0xFF1877F2),
                  )
                else
                  Text(reaction.emoji, style: const TextStyle(fontSize: 13)),
                if (widget.showLabel) ...[
                  const Gap.h(3.5),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isReacted ? color : AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: _buttonKey,
        onTap: _handleTap,
        onLongPress: _showReactionPopup,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isReacted)
                Icon(Icons.thumb_up_outlined, size: 18, color: color)
              else if (reaction == ReactionType.like)
                Icon(Icons.thumb_up_rounded, size: 18, color: color)
              else
                Text(reaction.emoji, style: const TextStyle(fontSize: 16)),
              const Gap.h(6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isReacted ? FontWeight.w700 : FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
