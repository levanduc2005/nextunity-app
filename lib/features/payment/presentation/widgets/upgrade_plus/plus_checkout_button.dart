import 'package:flutter/material.dart';

class PlusCheckoutButton extends StatelessWidget {
  const PlusCheckoutButton({
    super.key,
    required this.canProceed,
    required this.isLoading,
    required this.onTap,
  });

  final bool canProceed;
  final bool isLoading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: canProceed ? 1.0 : 0.6,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2563EB),
                Color(0xFF3D5AFE),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: canProceed
                ? [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.28),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: canProceed && !isLoading ? onTap : null,
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.2,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tiếp tục thanh toán',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.5,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
