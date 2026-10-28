import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class BankAppGrid extends StatelessWidget {
  const BankAppGrid({
    super.key,
    required this.banks,
    required this.selectedBankId,
    required this.selectedBankName,
    required this.onSelectBank,
    required this.onOpenBankApp,
  });

  final List<Map<String, dynamic>> banks;
  final String selectedBankId;
  final String selectedBankName;
  final void Function(String id, String name) onSelectBank;
  final VoidCallback onOpenBankApp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          'CHỌN NGÂN HÀNG CỦA BẠN:',
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: AppColors.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),

        // Grid Ngân hàng
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.95,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: banks.length,
          itemBuilder: (context, index) {
            final bank = banks[index];
            final isBankSelected = selectedBankId == bank['id'];
            return GestureDetector(
              onTap: () {
                onSelectBank(bank['id'] as String, bank['name'] as String);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: isBankSelected
                      ? AppColors.successContainer
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isBankSelected
                        ? AppColors.primary
                        : AppColors.border,
                    width: isBankSelected ? 2 : 1,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: bank['color'] as Color,
                            child: Text(
                              bank['short'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            bank['name'] as String,
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: isBankSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isBankSelected
                                  ? AppColors.primaryDark
                                  : AppColors.textLabel,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (isBankSelected)
                      const Positioned(
                        top: 3,
                        right: 3,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 8,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 14),

        // Open Banking App Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            onPressed: onOpenBankApp,
            icon: const Icon(Icons.account_balance_rounded, size: 18),
            label: const Text(
              'Thanh toán',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Tip text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 14,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Hệ thống sẽ tự động sao chép mã đơn hàng để bạn dán vào app ngân hàng.',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
