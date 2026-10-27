import 'package:flutter/material.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_type_ui.dart';

/// Một biểu tượng cảm xúc trong thanh chọn nổi với hiệu ứng hover phóng to
class ReactionPickerItem extends StatefulWidget {
  const ReactionPickerItem({
    super.key,
    required this.reaction,
    required this.isSelected,
    required this.onSelected,
  });

  final ReactionType reaction;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  State<ReactionPickerItem> createState() => _ReactionPickerItemState();
}

class _ReactionPickerItemState extends State<ReactionPickerItem> {
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
