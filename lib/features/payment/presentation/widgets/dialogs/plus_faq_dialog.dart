import 'package:flutter/material.dart';

/// Shows the Frequently Asked Questions (FAQ) dialog for NextUnity Plus.
Future<void> showPlusFaqDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Row(
        children: [
          Icon(Icons.help_outline_rounded, color: Color(0xFF2563EB)),
          SizedBox(width: 8),
          Text(
            'Câu hỏi thường gặp',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ],
      ),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '1. NextUnity Plus là gì?',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              'NextUnity Plus là gói hội viên cao cấp giúp sinh viên mở khóa 100% video khóa học, kho đề thi PE/FE có giải chi tiết và sử dụng trợ lý AI không giới hạn.',
              style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
            ),
            SizedBox(height: 12),
            Text(
              '2. Phương thức thanh toán?',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              'Thanh toán bảo mật 24/7. Bạn có thể mở trực tiếp ứng dụng ngân hàng đang dùng hoặc quét mã QR.',
              style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
            ),
            SizedBox(height: 12),
            Text(
              '3. Chính sách hoàn tiền?',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              'NextUnity cam kết hoàn trả 100% trong vòng 48h nếu bạn không hài lòng về chất lượng nội dung.',
              style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text(
            'Đã hiểu',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}
