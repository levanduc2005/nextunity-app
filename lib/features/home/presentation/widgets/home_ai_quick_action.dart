import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Lối tắt nhanh "Tạo bộ học AI từ Slide/PDF"
/// Thiết kế đồng nhất với theme Login (Nền trắng, viền Sky Blue, sổ tay sinh viên)
class HomeAiQuickAction extends ConsumerWidget {
  const HomeAiQuickAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final isPlus = user?.isPlus ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF60A5FA).withValues(alpha: 0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Watermark Icon mờ thanh lịch
          Positioned(
            right: -10,
            bottom: -15,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 130,
              color: AppColors.primary.withValues(alpha: 0.05),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Tag AI & Quota Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Sticky Note Tag phong cách Login
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded,
                            size: 13,
                            color: Color(0xFFD97706),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'GEMINI AI TUTOR',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFB45309),
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Quota Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isPlus
                            ? const Color(0xFFDCFCE7)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isPlus
                              ? const Color(0xFFBBF7D0)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        isPlus ? '👑 Plus Không Giới Hạn' : '⚡ 10 lượt/ngày',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: isPlus
                              ? const Color(0xFF15803D)
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Main Title & Description
                const Text(
                  'Tạo bộ học liệu ôn thi trong 30 giây',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tải lên Slide bài giảng (.pdf) ➔ AI tự động trích xuất lý thuyết trọng tâm, sinh Flashcards & bộ câu hỏi trắc nghiệm PE.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF475569),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),

                // Feature Pills
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _buildFeaturePill(
                      icon: Icons.picture_as_pdf_rounded,
                      label: 'Tóm tắt Slide',
                      bgColor: const Color(0xFFEFF6FF),
                      borderColor: const Color(0xFFDBEAFE),
                      textColor: const Color(0xFF2563EB),
                    ),
                    _buildFeaturePill(
                      icon: Icons.style_rounded,
                      label: 'Flashcards AI',
                      bgColor: const Color(0xFFFFF7ED),
                      borderColor: const Color(0xFFFFEDD5),
                      textColor: const Color(0xFFEA580C),
                    ),
                    _buildFeaturePill(
                      icon: Icons.quiz_rounded,
                      label: 'Đề thi PE/FE',
                      bgColor: const Color(0xFFFAF5FF),
                      borderColor: const Color(0xFFF3E8FF),
                      textColor: const Color(0xFF9333EA),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // CTA Button đồng nhất màu Primary với Login
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.push(AppRoute.aiUpload.path),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_file_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Tải Slide bài giảng lên ngay',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePill({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color borderColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
