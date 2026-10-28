import 'package:flutter/material.dart';
import 'package:rental_car/features/payment/presentation/constants/supported_banks.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/bank_app_grid.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/payment_method_option_card.dart';
import 'package:rental_car/features/payment/presentation/widgets/checkout/vietqr_display_card.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Bộ chọn phương thức thanh toán: Mở app ngân hàng (Option 1) hoặc Quét mã VietQR (Option 2)
class PaymentMethodsSelector extends StatelessWidget {
  const PaymentMethodsSelector({
    super.key,
    required this.selectedOption,
    required this.selectedBankId,
    required this.selectedBankName,
    required this.qrImageUrl,
    required this.onSelectOption,
    required this.onSelectBank,
    required this.onOpenBankApp,
    required this.onSaveQr,
  });

  final String selectedOption;
  final String selectedBankId;
  final String selectedBankName;
  final String qrImageUrl;
  final ValueChanged<String> onSelectOption;
  final void Function(String id, String name) onSelectBank;
  final VoidCallback onOpenBankApp;
  final VoidCallback onSaveQr;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chọn phương thức thanh toán:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),

        // Option 1: Mở app ngân hàng (Deeplink)
        PaymentMethodOptionCard(
          title: 'Mở ứng dụng Ngân hàng',
          badge: 'Chuyển nhanh',
          subtitle:
              'Mở app banking bạn đang dùng. Hệ thống sẽ tự động sao chép mã đơn hàng để bạn dán nếu app chưa tự điền.',
          isSelected: selectedOption == 'bank',
          onTap: () => onSelectOption('bank'),
          child: BankAppGrid(
            banks: SupportedBanks.list,
            selectedBankId: selectedBankId,
            selectedBankName: selectedBankName,
            onSelectBank: onSelectBank,
            onOpenBankApp: onOpenBankApp,
          ),
        ),
        const SizedBox(height: 14),

        // Option 2: Quét mã VietQR
        PaymentMethodOptionCard(
          title: 'Quét mã VietQR',
          badge: 'Chụp/Lưu mã',
          subtitle:
              'Dành cho quét từ thiết bị khác hoặc lưu ảnh QR vào thư viện',
          isSelected: selectedOption == 'qr',
          onTap: () => onSelectOption('qr'),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: VietQrDisplayCard(
              qrImageUrl: qrImageUrl,
              onSaveQr: onSaveQr,
            ),
          ),
        ),
      ],
    );
  }
}
