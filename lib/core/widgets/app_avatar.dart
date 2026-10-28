import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Circular avatar hiển thị ảnh đại diện hoặc chữ cái đầu.
/// Tích hợp sẵn hiệu ứng thành viên NextUnity PLUS (viền gradient vàng hổ phách,
/// đổ bóng phát sáng và huy hiệu PLUS Gemini-style tự động co giãn theo kích thước bán kính `radius`).
/// Hỗ trợ cả nút camera thay đổi ảnh và overlay xoay tròn khi đang upload.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.radius = 20,
    this.isPlus = false,
    this.onTap,
    this.isUploading = false,
    this.showCameraBadge = false,
    this.onCameraTap,
  });

  /// Tên người dùng dùng để tạo chữ cái viết tắt khi chưa có ảnh.
  final String name;

  /// Đường dẫn URL ảnh đại diện.
  final String? imageUrl;

  /// Bán kính avatar (mặc định 20, tức đường kính 40).
  final double radius;

  /// Cờ xác định thành viên NextUnity PLUS.
  final bool isPlus;

  /// Callback khi chạm vào avatar.
  final VoidCallback? onTap;

  /// Hiển thị overlay xoay tròn khi đang tải ảnh lên Cloudinary.
  final bool isUploading;

  /// Hiển thị nút camera nhỏ ở góc dưới bên phải (chỉ dùng cho tài khoản FREE).
  final bool showCameraBadge;

  /// Callback khi ấn vào nút camera.
  final VoidCallback? onCameraTap;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;
    final initial = _getInitial(name);

    // Tỉ lệ scale các phần tử trang trí dựa theo radius chuẩn 20
    final scale = (radius / 20.0).clamp(0.8, 2.5);
    final badgeFontSize = (6.5 * scale).clamp(6.5, 9.5);
    final badgeIconSize = (6.5 * scale).clamp(6.5, 10.0);
    final badgeHPadding = (4.5 * scale).clamp(4.0, 8.5);
    final badgeVPadding = (1.0 * scale).clamp(1.0, 2.5);
    final badgeBottom = (-3.5 * scale).clamp(-6.0, -3.0);
    final ringPadding = isPlus ? (2.0 * scale).clamp(1.8, 3.5) : 0.0;
    final whiteBorderWidth = isPlus ? (1.5 * scale).clamp(1.2, 2.5) : 0.0;

    final Widget avatarCore = Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isPlus ? AppColors.warningContainer : AppColors.primaryContainer,
        border: Border.all(
          color: isPlus ? Colors.white : AppColors.primaryBorder,
          width: isPlus ? whiteBorderWidth : 1.5,
        ),
      ),
      child: ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasImage)
              Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _buildFallbackInitial(initial),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return _buildFallbackInitial(initial);
                },
              )
            else
              _buildFallbackInitial(initial),

            if (isUploading)
              Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: Center(
                  child: SizedBox(
                    width: (radius * 0.55).clamp(16.0, 32.0),
                    height: (radius * 0.55).clamp(16.0, 32.0),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    final Widget decoratedAvatar = isPlus
        ? Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Vòng viền Gradient vàng hổ phách phát sáng
              Container(
                padding: EdgeInsets.all(ringPadding),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.warning,
                      AppColors.warningBorder,
                      AppColors.warningForeground,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.warningForeground.withValues(alpha: 0.35),
                      blurRadius: (6.0 * scale).clamp(5.0, 14.0),
                      offset: Offset(0, (2.0 * scale).clamp(1.5, 4.0)),
                    ),
                  ],
                ),
                child: avatarCore,
              ),

              // Huy hiệu PLUS Gemini-style ở mép dưới
              Positioned(
                bottom: badgeBottom,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: badgeHPadding,
                    vertical: badgeVPadding,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.warning, AppColors.warningForeground],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: (1.0 * scale).clamp(1.0, 1.8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.warningForeground.withValues(alpha: 0.45),
                        blurRadius: (4.0 * scale).clamp(3.0, 7.0),
                        offset: Offset(0, (1.5 * scale).clamp(1.0, 2.5)),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        size: badgeIconSize,
                        color: Colors.white,
                      ),
                      SizedBox(width: (1.5 * scale).clamp(1.5, 2.5)),
                      Text(
                        'PLUS',
                        style: TextStyle(
                          fontSize: badgeFontSize,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.5,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      blurRadius: (6.0 * scale).clamp(4.0, 10.0),
                      offset: Offset(0, (2.0 * scale).clamp(1.5, 3.0)),
                    ),
                  ],
                ),
                child: avatarCore,
              ),

              // Nút Camera nhỏ ở góc dưới nếu có yêu cầu (chỉ cho free)
              if (showCameraBadge)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: isUploading ? null : (onCameraTap ?? onTap),
                    child: Container(
                      width: (radius * 0.7).clamp(24.0, 34.0),
                      height: (radius * 0.7).clamp(24.0, 34.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 1.5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.photo_camera_rounded,
                        size: (radius * 0.35).clamp(12.0, 16.0),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );

    if (onTap != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isUploading ? null : onTap,
        child: decoratedAvatar,
      );
    }

    return decoratedAvatar;
  }

  Widget _buildFallbackInitial(String initial) {
    return Container(
      color: isPlus ? AppColors.warningContainer : AppColors.primaryContainer,
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: radius * 0.7,
          fontWeight: FontWeight.w800,
          color: isPlus ? AppColors.warningDark : AppColors.primaryForeground,
        ),
      ),
    );
  }

  String _getInitial(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'U';
    final parts = trimmed
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isNotEmpty) {
      return parts.last[0].toUpperCase();
    }
    return 'U';
  }
}
