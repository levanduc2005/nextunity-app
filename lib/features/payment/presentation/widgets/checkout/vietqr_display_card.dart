import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class VietQrDisplayCard extends StatelessWidget {
  const VietQrDisplayCard({
    super.key,
    required this.qrImageUrl,
    required this.onSaveQr,
  });

  final String qrImageUrl;
  final VoidCallback onSaveQr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
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
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Text(
                'Khớp lệnh 24/7',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.successDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

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
          const SizedBox(height: 14),

          // Nút Lưu mã
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1.5,
              ),
              onPressed: onSaveQr,
              icon: const Icon(Icons.download_rounded, size: 18),
              label: const Text(
                'Lưu mã',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
