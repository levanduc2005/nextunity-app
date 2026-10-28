import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Hàng 6 ô nhập mã OTP dùng chung cho VerifyEmailPage và ForgotPasswordPage.
class AuthOtpRow extends StatelessWidget {
  final int length;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(int index, String value) onChanged;
  final VoidCallback? onCompleted;
  final double boxWidth;
  final double boxHeight;

  const AuthOtpRow({
    super.key,
    this.length = 6,
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    this.onCompleted,
    this.boxWidth = 42,
    this.boxHeight = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(length, (index) {
        return SizedBox(
          width: boxWidth,
          height: boxHeight,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace) {
                if (controllers[index].text.isEmpty && index > 0) {
                  focusNodes[index - 1].requestFocus();
                  controllers[index - 1].text = '';
                }
              }
            },
            child: TextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.borderMedium,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (val) => onChanged(index, val),
              onSubmitted: (_) {
                if (index == length - 1) {
                  onCompleted?.call();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
