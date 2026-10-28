import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Bộ công cụ ôn luyện thông minh dạng Bento hiện đại (Flashcards, Quiz AI, Mindmap, Đọc Slide/PDF)
class HomeStudyToolsBento extends StatelessWidget {
  const HomeStudyToolsBento({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tiêu đề
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Công cụ ôn luyện thông minh',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 2.5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Text(
                  '4 công cụ',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Hàng 4 công cụ ôn luyện Bento với sắc màu nhận diện riêng biệt
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildToolItem(
                  context: context,
                  icon: Icons.style_rounded,
                  label: 'Flashcards',
                  iconColor: AppColors.primaryAction,
                  bgColor: AppColors.primaryContainer,
                  borderColor: const Color(0xFFDBEAFE),
                  route: AppRoute.flashcards.path,
                ),
              ),
              Expanded(
                child: _buildToolItem(
                  context: context,
                  icon: Icons.quiz_rounded,
                  label: 'Quiz AI',
                  iconColor: const Color(0xFF7C3AED),
                  bgColor: const Color(0xFFF5F3FF),
                  borderColor: const Color(0xFFDDD6FE),
                  route: AppRoute.quiz.path,
                ),
              ),
              Expanded(
                child: _buildToolItem(
                  context: context,
                  icon: Icons.hub_rounded,
                  label: 'Mindmap',
                  iconColor: AppColors.successDark,
                  bgColor: const Color(0xFFECFDF5),
                  borderColor: AppColors.successBorder,
                  route: AppRoute.mindmap.path,
                ),
              ),
              Expanded(
                child: _buildToolItem(
                  context: context,
                  icon: Icons.picture_as_pdf_rounded,
                  label: 'Slide & PDF',
                  iconColor: AppColors.warningForeground,
                  bgColor: AppColors.warningLight,
                  borderColor: AppColors.warningBorder,
                  route: AppRoute.slidePdfViewer.path,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
    required String route,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(route),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(icon, color: iconColor, size: 23),
              ),
              const SizedBox(height: 7),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textLabel,
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
