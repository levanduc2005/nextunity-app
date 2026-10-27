import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Modal xác nhận thoát bài kiểm tra chuẩn thiết kế NextUnity
/// - Badge icon cảnh báo với 2 vòng tròn đồng tâm
/// - Thẻ thống kê tiến độ câu hỏi đã làm
/// - Nút "Tiếp tục làm bài" (Primary Electric Blue) & Nút "Thoát bài" (Destructive Soft Red)
Future<bool> showQuizExitModal(
  BuildContext context, {
  required int answeredCount,
  required int totalQuestions,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (ctx) => QuizExitModal(
      answeredCount: answeredCount,
      totalQuestions: totalQuestions,
    ),
  );

  return result ?? false;
}

class QuizExitModal extends StatelessWidget {
  const QuizExitModal({
    super.key,
    required this.answeredCount,
    required this.totalQuestions,
  });

  final int answeredCount;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thanh gạt (Drag Handle)
            Center(
              child: Container(
                width: 44,
                height: 4.5,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Badge Icon cảnh báo thoát
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFFEF2F2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEE2E2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.exit_to_app_rounded,
                    size: 24,
                    color: Color(0xFFEF4444),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tiêu đề
            const Text(
              'Thoát bài kiểm tra?',
              style: TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),

            // Mô tả
            const Text(
              'Các đáp án bạn đã chọn được tự động lưu lại. Bạn có thể quay lại làm tiếp bất kỳ lúc nào.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: Color(0xFF64748B),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18),

            // Thẻ thống kê tiến độ hiện tại
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primaryBorder),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.assignment_outlined,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Tiến độ hiện tại',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF334155),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$answeredCount/$totalQuestions câu',
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryForeground,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Các nút hành động
            Row(
              children: [
                // Nút Thoát bài
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFEF4444),
                        side: const BorderSide(color: Color(0xFFFECACA)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: const Color(0xFFFEF2F2),
                      ),
                      child: const Text(
                        'Thoát bài',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Nút Tiếp tục làm bài (Electric Blue)
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        shadowColor: AppColors.primary.withValues(alpha: 0.35),
                      ),
                      child: const Text(
                        'Tiếp tục làm bài',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
