import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_picker_item.dart';

/// Lớp hỗ trợ tính toán vị trí và khởi tạo Overlay thanh chọn 6 cảm xúc reaction
class PostReactionPopup {
  const PostReactionPopup._();

  static OverlayEntry create({
    required BuildContext context,
    required GlobalKey buttonKey,
    required AnimationController animationController,
    required ReactionType? currentReaction,
    required ValueChanged<ReactionType> onReactionSelected,
    required VoidCallback onDismiss,
  }) {
    HapticFeedback.mediumImpact();

    final renderBox =
        buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return OverlayEntry(builder: (_) => const SizedBox.shrink());
    }

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    const popupWidth = 310.0;
    const popupHeight = 56.0;

    double left = offset.dx;
    if (left + popupWidth > screenSize.width - 12) {
      left = screenSize.width - popupWidth - 12;
    }
    if (left < 12) left = 12;

    double top = offset.dy - popupHeight - 12;
    if (top < MediaQuery.of(context).padding.top + 10) {
      top = offset.dy + size.height + 8;
    }

    final double anchorX = ((offset.dx + size.width / 2 - left) / popupWidth)
        .clamp(0.1, 0.9);
    final isAbove = top < offset.dy;

    animationController.reset();
    animationController.forward();

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Lớp bắt sự kiện chạm ra ngoài
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onDismiss,
                child: const SizedBox.expand(),
              ),
            ),
            // Thanh chọn cảm xúc nổi
            Positioned(
              left: left,
              top: top,
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animationController,
                    curve: Curves.easeOutBack,
                  ),
                  alignment: Alignment(anchorX * 2 - 1, isAbove ? 1.0 : -1.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(40),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: ReactionType.values.map((reaction) {
                        return ReactionPickerItem(
                          reaction: reaction,
                          isSelected: currentReaction == reaction,
                          onSelected: () {
                            HapticFeedback.lightImpact();
                            onDismiss();
                            onReactionSelected(reaction);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
