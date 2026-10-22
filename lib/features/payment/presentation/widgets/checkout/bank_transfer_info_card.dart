import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Card displaying bank transfer details with one-click copy buttons.
class BankTransferInfoCard extends StatelessWidget {
  const BankTransferInfoCard({
    super.key,
    this.bankName = 'MBBank (Quân Đội)',
    this.accountNumber = '038891028391',
    required this.amountFormatted,
    required this.orderCode,
    required this.onCopy,
  });

  final String bankName;
  final String accountNumber;
  final String amountFormatted;
  final String orderCode;
  final void Function(String text, String label) onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          _buildCopyRow(
            label: 'Ngân hàng thụ hưởng',
            value: bankName,
          ),
          const Divider(height: 16),
          _buildCopyRow(
            label: 'Số tài khoản',
            value: accountNumber,
            canCopy: true,
          ),
          const Divider(height: 16),
          _buildCopyRow(
            label: 'Số tiền',
            value: '$amountFormatted đ',
            isBold: true,
          ),
          const Divider(height: 16),
          _buildCopyRow(
            label: 'Nội dung chuyển khoản (bắt buộc)',
            value: orderCode,
            canCopy: true,
            isWarning: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCopyRow({
    required String label,
    required String value,
    bool canCopy = false,
    bool isBold = false,
    bool isWarning = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: isWarning ? FontWeight.w700 : FontWeight.w500,
                  color: isWarning
                      ? const Color(0xFFB45309)
                      : const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight:
                      isBold || isWarning ? FontWeight.w800 : FontWeight.w600,
                  color: isWarning
                      ? const Color(0xFF92400E)
                      : (isBold
                          ? AppColors.primary
                          : const Color(0xFF0F172A)),
                ),
              ),
            ],
          ),
        ),
        if (canCopy)
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isWarning ? const Color(0xFFF59E0B) : Colors.white,
              foregroundColor:
                  isWarning ? Colors.white : const Color(0xFF1E293B),
              elevation: isWarning ? 1 : 0,
              side: isWarning
                  ? null
                  : const BorderSide(color: Color(0xFFCBD5E1)),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => onCopy(value, label),
            icon: const Icon(Icons.copy_rounded, size: 12),
            label: const Text(
              'Sao chép',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
