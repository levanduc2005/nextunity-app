import 'package:flutter/material.dart';

/// Trust and security badges displayed on payment and upgrade screens.
class PaymentTrustBadges extends StatelessWidget {
  const PaymentTrustBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.verified_user_rounded,
              color: Color(0xFF059669),
              size: 15,
            ),
            SizedBox(width: 4),
            Text(
              'Bảo mật 100%',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '•',
            style: TextStyle(color: Color(0xFFCBD5E1)),
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.bolt_rounded,
              color: Color(0xFF2563EB),
              size: 16,
            ),
            SizedBox(width: 3),
            Text(
              'Kích hoạt tức thì 24/7',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '•',
            style: TextStyle(color: Color(0xFFCBD5E1)),
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.sync_rounded,
              color: Color(0xFFF59E0B),
              size: 15,
            ),
            SizedBox(width: 4),
            Text(
              'Hoàn tiền 48h',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
