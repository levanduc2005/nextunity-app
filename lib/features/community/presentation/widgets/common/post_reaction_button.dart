import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

/// Extension định nghĩa giao diện (nhãn, emoji, màu sắc) ở tầng Presentation
extension ReactionTypeUiX on ReactionType {
  String get label => switch (this) {
    ReactionType.like => 'Thích',
    ReactionType.love => 'Yêu thích',
    ReactionType.haha => 'Haha',
    ReactionType.wow => 'Wow',
    ReactionType.sad => 'Buồn',
    ReactionType.angry => 'Phẫn nộ',
  };

  String get emoji => switch (this) {
    ReactionType.like => '👍',
    ReactionType.love => '❤️',
    ReactionType.haha => '😆',
    ReactionType.wow => '😮',
    ReactionType.sad => '😢',
    ReactionType.angry => '😡',
  };

  Color get color => switch (this) {
    ReactionType.like => const Color(0xFF1877F2),
    ReactionType.love => const Color(0xFFFA3E3E),
    ReactionType.haha => const Color(0xFFF7B125),
    ReactionType.wow => const Color(0xFFF7B125),
    ReactionType.sad => const Color(0xFFF7B125),
    ReactionType.angry => const Color(0xFFE25026),
  };
}

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
    HapticFeedback.mediumImpact();

    final renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    const popupWidth = 310.0;
    const popupHeight = 56.0;

    // Tính toán toạ độ hiển thị nổi ngay phía trên nút bấm
    double left = offset.dx;
    if (left + popupWidth > screenSize.width - 12) {
      left = screenSize.width - popupWidth - 12;
    }
    if (left < 12) left = 12;

    double top = offset.dy - popupHeight - 12;
    // Nếu quá sát mép trên màn hình thì hiện xuống phía dưới nút
    if (top < MediaQuery.of(context).padding.top + 10) {
      top = offset.dy + size.height + 8;
    }

    final double anchorX = ((offset.dx + size.width / 2 - left) / popupWidth)
        .clamp(0.1, 0.9);
    final isAbove = top < offset.dy;

    _animController.reset();
    _animController.forward();

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Lớp nền vô hình bắt sự kiện chạm ra ngoài để đóng popup
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removeOverlay,
                child: const SizedBox.expand(),
              ),
            ),
            // Thanh cảm xúc nổi
            Positioned(
              left: left,
              top: top,
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _animController,
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
                        return _ReactionItem(
                          reaction: reaction,
                          isSelected: widget.currentReaction == reaction,
                          onSelected: () {
                            HapticFeedback.lightImpact();
                            _removeOverlay();
                            widget.onReactionSelected(reaction);
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

    final Color color = isReacted ? reaction.color : const Color(0xFF64748B);
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
                    color: Color(0xFF64748B),
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
                      color: isReacted ? color : const Color(0xFF64748B),
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

class _ReactionItem extends StatefulWidget {
  const _ReactionItem({
    required this.reaction,
    required this.isSelected,
    required this.onSelected,
  });

  final ReactionType reaction;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  State<_ReactionItem> createState() => _ReactionItemState();
}

class _ReactionItemState extends State<_ReactionItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelected,
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        transform: Matrix4.diagonal3Values(
          _isHovered ? 1.35 : 1.0,
          _isHovered ? 1.35 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isHovered)
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.reaction.label,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isSelected
                    ? widget.reaction.color.withAlpha(35)
                    : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: Text(
                widget.reaction.emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
