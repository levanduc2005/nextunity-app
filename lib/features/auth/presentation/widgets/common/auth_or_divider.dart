import 'package:flutter/material.dart';

/// Đường phân cách "Hoặc" giữa Form và Social Logins.
class AuthOrDivider extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const AuthOrDivider({
    super.key,
    this.text = 'Hoặc',
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF94A3B8),
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
          ),
        ],
      ),
    );
  }
}
