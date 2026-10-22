import 'package:flutter/material.dart';

/// Bảng màu chuẩn (Design Tokens) lấy cảm hứng từ phong cách ApSkil E-Learning.
///
/// Tông màu chủ đạo là Sage / Forest Green dịu mắt, kết hợp nền trắng ngà ấm áp
/// và điểm nhấn cam đào pastel cho các thông báo học tập.
abstract final class AppColors {
  // --- Màu thương hiệu ApSkil (Brand Colors) ---
  /// Màu xanh lá chủ đạo chuẩn ApSkil (Forest / Sage Green)
  static const Color primary = Color(0xFF2E7D32);

  /// Màu xanh lá nhấn phụ (Emerald Accent)
  static const Color accent = Color(0xFF16A34A);

  /// Màu xanh lá đậm sâu (Forest Deep / Tailwind Green-900) - Dùng cho Banner, Ambient Glow, Bottom Nav
  static const Color primaryDark = Color(0xFF14532D);

  /// Màu xanh lá tối nhất (Forest Darkest) - Dùng cho gradient nền tối
  static const Color primaryDarkest = Color(0xFF0F3923);

  /// Màu xanh lá sáng / điểm nhấn tương phản cao trên nền tối (Light Green / Mint Accent)
  static const Color primaryLight = Color(0xFF4ADE80);

  /// Màu nền xanh ngọc pastel (Soft Mint Surface - dùng cho Chip, Badge)
  static const Color primaryContainer = Color(0xFFDCFCE7);

  /// Màu đường viền xanh nhạt (Mint Border)
  static const Color primaryBorder = Color(0xFFBBF7D0);

  /// Màu chữ xanh đậm tương phản trên nền xanh pastel (Forest Dark Text)
  static const Color primaryForeground = Color(0xFF166534);

  // --- Màu văn bản & Biểu tượng (Typography & Icon Colors) ---
  /// Màu chữ chính (Đen than Slate-900) - Dùng cho tiêu đề, văn bản quan trọng
  static const Color textPrimary = Color(0xFF0F172A);

  /// Màu biểu tượng chính (Đen than Slate-900) - Dùng chung cho icon toàn app
  static const Color iconPrimary = Color(0xFF0F172A);

  /// Alias tiện lợi cho màu đen than Slate-900
  static const Color darkIcon = Color(0xFF0F172A);

  /// Màu chữ phụ (Xám Slate-500) - Dùng cho phụ đề, nhãn, mô tả
  static const Color textSecondary = Color(0xFF64748B);

  /// Màu chữ làm mờ (Xám nhạt Slate-400) - Dùng cho hint text, ghi chú nhỏ
  static const Color textMuted = Color(0xFF94A3B8);

  // --- Màu nền & Bề mặt (Background & Surface) ---
  /// Nền chính của toàn app (Trắng xám ngà dịu mắt chuẩn ApSkil)
  static const Color background = Color(0xFFF8F9FA);

  /// Nền pastel thanh thoát (Soft Pale Sage)
  static const Color pastelBackground = Color(0xFFF8F9FA);

  /// Bề mặt thẻ, ô nhập, hộp thoại (Trắng tinh khiết)
  static const Color surface = Colors.white;

  /// Màu viền chuẩn (Xám nhạt Slate-200) cho input, card, divider
  static const Color border = Color(0xFFE2E8F0);

  /// Màu viền khi được chọn (Active / Focused border)
  static const Color borderFocused = Color(0xFF2E7D32);

  // --- Màu thông báo & Nhắc nhở buổi học (ApSkil Alert Banner) ---
  /// Nền banner thông báo màu cam đào pastel
  static const Color alertBannerBg = Color(0xFFFFF7ED);

  /// Viền banner thông báo cam đào
  static const Color alertBannerBorder = Color(0xFFFED7AA);

  /// Màu chữ / icon cảnh báo trong banner
  static const Color alertBannerText = Color(0xFFC2410C);

  // --- Màu trạng thái (Feedback Colors) ---
  /// Trạng thái thành công (Xanh lục)
  static const Color success = Color(0xFF16A34A);

  /// Trạng thái cảnh báo (Cam vàng)
  static const Color warning = Color(0xFFF59E0B);

  /// Trạng thái lỗi (Đỏ)
  static const Color error = Color(0xFFEF4444);

  /// Trạng thái thông tin (Xanh dương)
  static const Color info = Color(0xFF2563EB);
}
