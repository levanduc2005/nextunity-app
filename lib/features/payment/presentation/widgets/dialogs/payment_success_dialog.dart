import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';

Future<void> showPaymentSuccessDialog(
  BuildContext context, {
  required String planName,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: const Column(
        children: [
          Icon(
            Icons.workspace_premium_rounded,
            color: Color(0xFFF59E0B),
            size: 54,
          ),
          SizedBox(height: 8),
          Text(
            'Thanh toán thành công!',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        'Chúc mừng bạn đã nâng cấp thành công $planName. Toàn bộ đặc quyền thành viên PLUS đã được kích hoạt!',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoute.home.path);
              }
            },
            child: const Text(
              'Bắt đầu trải nghiệm ngay',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}
