import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thẻ lựa chọn đáp án trắc nghiệm chuẩn thiết kế hiện đại
/// - Trạng thái chưa chọn: Nền xám nhạt dịu mắt, radio outline tinh gọn
/// - Trạng thái đã chọn: Nền màu thương hiệu (Primary Blue/Navy), chữ trắng tương phản cao, radio active
class QuizOptionTile extends StatelessWidget {
  const QuizOptionTile({
    super.key,
    required this.content,
    required this.isSelected,
    required this.onTap,
    this.label,
    this.isMultiChoice = false,
  });

  final String content;
  final bool isSelected;
  final VoidCallback onTap;
  final String? label;
  final bool isMultiChoice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.6 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.32),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Radio / Checkbox Indicator
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: isMultiChoice ? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: isMultiChoice ? BorderRadius.circular(6) : null,
                  color: isSelected ? Colors.white : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Colors.white : AppColors.textMuted,
                    width: 2.0,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: isMultiChoice
                            ? const Icon(
                                Icons.check_rounded,
                                size: 15,
                                color: AppColors.primary,
                              )
                            : Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                              ),
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textLabel,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
