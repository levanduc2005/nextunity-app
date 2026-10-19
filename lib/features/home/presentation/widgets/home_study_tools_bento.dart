import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';

/// Bộ công cụ ôn luyện thông minh dạng icon ngắn gọn (Flashcards, Quiz AI, Mindmap, Đọc PDF)
class HomeStudyToolsBento extends StatelessWidget {
  const HomeStudyToolsBento({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D5AFE).withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tiêu đề ngắn gọn
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bộ công cụ ôn luyện thông minh',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 2.5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '4 công cụ',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF4F46E5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Hàng 4 icon công cụ ngắn gọn
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildToolItem(
                  context: context,
                  icon: Icons.style_rounded,
                  label: 'Flashcards',
                  bgColor: const Color(0xFFFFF7ED),
                  borderColor: const Color(0xFFFFEDD5),
                  iconColor: const Color(0xFFEA580C),
                  route: AppRoute.flashcards.path,
                ),
              ),
              Expanded(
                child: _buildToolItem(
                  context: context,
                  icon: Icons.quiz_rounded,
                  label: 'Quiz AI',
                  bgColor: const Color(0xFFEEF2FF),
                  borderColor: const Color(0xFFE0E7FF),
                  iconColor: const Color(0xFF4F46E5),
                  route: AppRoute.quiz.path,
                ),
              ),
              Expanded(
                child: _buildToolItem(
                  context: context,
                  icon: Icons.hub_rounded,
                  label: 'Mindmap',
                  bgColor: const Color(0xFFFAF5FF),
                  borderColor: const Color(0xFFF3E8FF),
                  iconColor: const Color(0xFF9333EA),
                  route: AppRoute.mindmap.path,
                ),
              ),
              Expanded(
                child: _buildToolItem(
                  context: context,
                  icon: Icons.picture_as_pdf_rounded,
                  label: 'Đọc PDF',
                  bgColor: const Color(0xFFECFDF5),
                  borderColor: const Color(0xFFD1FAE5),
                  iconColor: const Color(0xFF059669),
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
    required Color bgColor,
    required Color borderColor,
    required Color iconColor,
    required String route,
  }) {
    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF334155),
                letterSpacing: -0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
