import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class VietQrDisplayCard extends StatelessWidget {
  const VietQrDisplayCard({
    super.key,
    required this.qrImageUrl,
    required this.onOpenCheckoutUrl,
  });

  final String qrImageUrl;
  final VoidCallback onOpenCheckoutUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.qr_code_2_rounded,
                    color: AppColors.primary,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Mã VietQR động',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Text(
                'Khớp lệnh 24/7',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF059669),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // QR Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              qrImageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          TextButton.icon(
            onPressed: onOpenCheckoutUrl,
            icon: const Icon(Icons.open_in_new_rounded, size: 14),
            label: const Text(
              'Mở trang thanh toán',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
