import 'package:flutter/material.dart';

/// Đường phân cách "Or" giữa Form và Social Logins.
class AuthOrDivider extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const AuthOrDivider({
    super.key,
    this.text = 'Or',
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: const Color(0xFF94A3B8).withValues(alpha: 0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: const Color(0xFF94A3B8).withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
