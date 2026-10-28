import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Shows the Frequently Asked Questions (FAQ) dialog for NextUnity Plus.
Future<void> showPlusFaqDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      actionsPadding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.help_outline_rounded,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Câu hỏi thường gặp',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _FaqItem(
              question: '1. NextUnity Plus là gì?',
              answer:
                  'NextUnity Plus là gói hội viên cao cấp giúp sinh viên mở khóa 100% video khóa học, kho đề thi PE/FE có giải chi tiết và sử dụng trợ lý AI không giới hạn.',
            ),
            SizedBox(height: 12),
            _FaqItem(
              question: '2. Phương thức thanh toán?',
              answer:
                  'Thanh toán bảo mật 24/7. Bạn có thể mở trực tiếp ứng dụng ngân hàng đang dùng hoặc quét mã VietQR tự động xác thực.',
            ),
            SizedBox(height: 12),
            _FaqItem(
              question: '3. Chính sách hoàn tiền?',
              answer:
                  'NextUnity cam kết hoàn trả 100% trong vòng 48h nếu bạn không hài lòng về chất lượng nội dung.',
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Đã hiểu',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
            ),
          ),
        ),
      ],
    ),
  );
}

class _FaqItem extends StatelessWidget {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryDark,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
