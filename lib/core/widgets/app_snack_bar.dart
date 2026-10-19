import 'package:flutter/material.dart';

/// Phân loại thông báo Toast / SnackBar
enum SnackType { info, success, error, warning }

/// Helper hiển thị thông báo Toast / SnackBar đồng bộ với thiết kế NextUnity
///
/// Cách dùng:
/// `context.showSnackBar('Đăng ký thành công!', type: SnackType.success);`
/// Hoặc:
/// `context.showSuccessSnackBar('Đã lưu thay đổi');`
/// `context.showErrorSnackBar('Mật khẩu không chính xác');`
extension AppSnackBar on BuildContext {
  void showSnackBar(
    String message, {
    SnackType type = SnackType.info,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: _AppToastContent(message: message, type: type, title: title),
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          duration: duration,
        ),
      );
  }

  void showSuccessSnackBar(
    String message, {
    String? title,
    Duration? duration,
  }) {
    showSnackBar(
      message,
      type: SnackType.success,
      title: title,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  void showErrorSnackBar(String message, {String? title, Duration? duration}) {
    showSnackBar(
      message,
      type: SnackType.error,
      title: title,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  void showWarningSnackBar(
    String message, {
    String? title,
    Duration? duration,
  }) {
    showSnackBar(
      message,
      type: SnackType.warning,
      title: title,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  void showInfoSnackBar(String message, {String? title, Duration? duration}) {
    showSnackBar(
      message,
      title: title,
      duration: duration ?? const Duration(seconds: 3),
    );
  }
}

class _AppToastContent extends StatelessWidget {
  const _AppToastContent({
    required this.message,
    required this.type,
    this.title,
  });

  final String message;
  final SnackType type;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final (icon, iconColor, iconBg, borderColor, bgColor) = switch (type) {
      SnackType.success => (
        Icons.check_circle_rounded,
        const Color(0xFF059669),
        const Color(0xFFD1FAE5),
        const Color(0xFFA7F3D0),
        const Color(0xFFF0FDF4),
      ),
      SnackType.error => (
        Icons.error_rounded,
        const Color(0xFFDC2626),
        const Color(0xFFFEE2E2),
        const Color(0xFFFECACA),
        const Color(0xFFFEF2F2),
      ),
      SnackType.warning => (
        Icons.warning_amber_rounded,
        const Color(0xFFD97706),
        const Color(0xFFFEF3C7),
        const Color(0xFFFDE68A),
        const Color(0xFFFFFBEB),
      ),
      SnackType.info => (
        Icons.info_rounded,
        const Color(0xFF2563EB),
        const Color(0xFFDBEAFE),
        const Color(0xFFBFDBFE),
        const Color(0xFFEFF6FF),
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: iconColor.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon huy hiệu bo tròn
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),

          // Nội dung text
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null && title!.isNotEmpty) ...[
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                ],
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
