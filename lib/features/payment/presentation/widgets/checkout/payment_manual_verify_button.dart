import 'package:flutter/material.dart';

class PaymentManualVerifyButton extends StatelessWidget {
  const PaymentManualVerifyButton({
    super.key,
    required this.isChecking,
    required this.onPressed,
  });

  final bool isChecking;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        onPressed: isChecking ? null : onPressed,
        child: isChecking
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text(
                'Tôi đã chuyển khoản xong',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: Color(0xFF0F172A),
                ),
              ),
      ),
    );
  }
}
