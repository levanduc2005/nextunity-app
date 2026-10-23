import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/payment/presentation/widgets/dialogs/plus_faq_dialog.dart';

class PaymentPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PaymentPageAppBar({super.key, this.title = 'Thanh toán đơn hàng'});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 16,
          color: Color(0xFF0F172A),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0F172A),
            size: 18,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.help_outline_rounded,
            color: AppColors.primary,
          ),
          onPressed: () => showPlusFaqDialog(context),
        ),
      ],
    );
  }
}
