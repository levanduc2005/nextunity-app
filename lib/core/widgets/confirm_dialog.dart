import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Shows a stylized NextUnity confirmation dialog and resolves to `true`
/// when confirmed, `false` otherwise.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
  bool isDestructive = false,
  IconData? icon,
}) async {
  final result = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withValues(alpha: 0.45),
    transitionDuration: const Duration(milliseconds: 240),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      );
      return ScaleTransition(
        scale: Tween<double>(begin: 0.88, end: 1.0).animate(curved),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return _NextUnityConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
        icon: icon,
      );
    },
  );

  return result ?? false;
}

class _NextUnityConfirmDialog extends StatelessWidget {
  const _NextUnityConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.isDestructive,
    this.icon,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final effectiveIcon =
        icon ??
        (isDestructive ? Icons.logout_rounded : Icons.help_outline_rounded);

    final primaryActionColor = isDestructive
        ? AppColors.errorForeground
        : AppColors.primary;
    final outerRingColor = isDestructive
        ? AppColors.errorSurfaceLight
        : AppColors.primaryContainer;
    final innerRingColor = isDestructive
        ? AppColors.errorContainer
        : AppColors.primaryBorder;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 330,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.surfaceSubtle, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: primaryActionColor.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Badge Icon với 2 vòng tròn đồng tâm mềm mại
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: outerRingColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: innerRingColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      effectiveIcon,
                      size: 26,
                      color: primaryActionColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Tiêu đề
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),

              const SizedBox(height: 10),

              // Nội dung mô tả
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 24),

              // Nút Hủy và Nút Xác nhận
              Row(
                children: [
                  // Nút Hủy
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.surfaceLight,
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          cancelLabel,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Nút Xác nhận (Đăng xuất / Đồng ý)
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryActionColor,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: primaryActionColor.withValues(
                            alpha: 0.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isDestructive) ...[
                              const Icon(
                                Icons.logout_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              confirmLabel,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
