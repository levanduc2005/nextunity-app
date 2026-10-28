import 'package:flutter/material.dart';

/// Bảng màu chuẩn (Design Tokens) phong cách NextUnity Electric Blue & Sky Cyan.
///
/// Tông màu chủ đạo là Electric / Royal Blue hiện đại, kết hợp nền trắng ngà dịu mắt
/// và điểm nhấn Sky Cyan đồng bộ với biểu tượng ứng dụng.
abstract final class AppColors {
  // --- Màu thương hiệu NextUnity (Brand Colors) ---
  /// Màu xanh điện chính (Primary Electric / Royal Blue)
  static const Color primary = Color(0xFF3D5AFE);

  /// Màu xanh nhấn phụ (Sky Cyan Accent)
  static const Color accent = Color(0xFF00B0FF);

  /// Màu xanh đậm sâu (Navy Deep / Blue-900) - Dùng cho Banner, Ambient Glow, Bottom Nav
  static const Color primaryDark = Color(0xFF1E3A8A);

  /// Màu xanh tối nhất (Navy Darkest / Slate-950) - Dùng cho gradient nền tối
  static const Color primaryDarkest = Color(0xFF0A1128);

  /// Màu xanh sáng / điểm nhấn tương phản cao trên nền tối (Light Cyan / Sky Accent)
  static const Color primaryLight = Color(0xFF60A5FA);

  /// Màu nền xanh ngọc pastel (Soft Ice Sky Blue Surface - dùng cho Chip, Badge)
  static const Color primaryContainer = Color(0xFFEFF6FF);

  /// Màu đường viền xanh nhạt (Blue Border)
  static const Color primaryBorder = Color(0xFFBFDBFE);

  /// Màu chữ xanh đậm tương phản trên nền xanh pastel (Blue Dark Text)
  static const Color primaryForeground = Color(0xFF1D4ED8);

  // --- Màu văn bản & Biểu tượng (Typography & Icon Colors) ---
  /// Màu chữ chính (Đen than Slate-900) - Dùng cho tiêu đề, văn bản quan trọng
  static const Color textPrimary = Color(0xFF0F172A);

  /// Màu biểu tượng chính (Đen than Slate-900) - Dùng chung cho icon toàn app
  static const Color iconPrimary = Color(0xFF0F172A);

  /// Alias tiện lợi cho màu đen than Slate-900
  static const Color darkIcon = Color(0xFF0F172A);

  /// Màu chữ tiêu đề phụ / số OTP đậm (Đen Slate-800)
  static const Color textDark = Color(0xFF1E293B);

  /// Màu nhãn / tiêu đề mục (Xám Slate-700)
  static const Color textLabel = Color(0xFF334155);

  /// Màu văn bản phụ tối / icon phụ (Xám Slate-600)
  static const Color textSecondaryDark = Color(0xFF475569);

  /// Màu chữ phụ (Xám Slate-500) - Dùng cho phụ đề, nhãn, mô tả
  static const Color textSecondary = Color(0xFF64748B);

  /// Màu chữ làm mờ (Xám nhạt Slate-400) - Dùng cho hint text, ghi chú nhỏ
  static const Color textMuted = Color(0xFF94A3B8);

  // --- Màu nền & Bề mặt (Background & Surface) ---
  /// Nền chính của toàn app (Xanh pastel dịu mắt Soft Ice Sky Blue)
  static const Color background = Color(0xFFE6F0FC);

  /// Nền xanh pastel đồng bộ cho các trang Auth và Profile (Soft Ice Sky Blue)
  static const Color pastelBackground = Color(0xFFE6F0FC);

  /// Bề mặt thẻ, ô nhập, hộp thoại (Trắng tinh khiết)
  static const Color surface = Colors.white;

  /// Bề mặt xám phụ (Slate-100) cho chip, badge, nút phụ, thanh phân cách
  static const Color surfaceSubtle = Color(0xFFF1F5F9);

  /// Màu viền trung bình / viền vô hiệu hóa (Xám Slate-300)
  static const Color borderMedium = Color(0xFFCBD5E1);

  /// Màu viền chuẩn (Xám nhạt Slate-200) cho input, card, divider
  static const Color border = Color(0xFFE2E8F0);

  /// Màu viền khi được chọn (Active / Focused border)
  static const Color borderFocused = Color(0xFF3D5AFE);

  // --- Màu thông báo & Nhắc nhở buổi học (Alert Banner) ---
  /// Nền banner thông báo màu cam đào pastel
  static const Color alertBannerBg = Color(0xFFFFF7ED);

  /// Viền banner thông báo cam đào
  static const Color alertBannerBorder = Color(0xFFFED7AA);

  /// Màu chữ / icon cảnh báo trong banner
  static const Color alertBannerText = Color(0xFFC2410C);

  // --- Màu trạng thái (Feedback Colors - Success, Warning, Error, Info) ---
  /// Trạng thái thành công chính (Xanh lục Emerald-500)
  static const Color success = Color(0xFF10B981);

  /// Trạng thái thành công đậm (Emerald-600) - Dùng cho icon, nút bấm xác nhận
  static const Color successDark = Color(0xFF059669);

  /// Nền trạng thái thành công pastel (Green-100) - Dùng cho chip, badge, thẻ đã hoàn thành
  static const Color successContainer = Color(0xFFDCFCE7);

  /// Đường viền trạng thái thành công (Green-200)
  static const Color successBorder = Color(0xFFA7F3D0);

  /// Màu chữ trạng thái thành công tương phản cao (Green-800)
  static const Color successForeground = Color(0xFF166534);

  /// Trạng thái cảnh báo chính (Cam vàng Amber-500)
  static const Color warning = Color(0xFFF59E0B);

  /// Nền trạng thái cảnh báo pastel (Amber-100)
  static const Color warningContainer = Color(0xFFFEF3C7);

  /// Đường viền trạng thái cảnh báo (Amber-200)
  static const Color warningBorder = Color(0xFFFDE68A);

  /// Màu chữ trạng thái cảnh báo tương phản cao (Amber-700 / Amber-800)
  static const Color warningForeground = Color(0xFFD97706);

  /// Trạng thái lỗi chính (Đỏ Red-500)
  static const Color error = Color(0xFFEF4444);

  /// Nền trạng thái lỗi pastel (Red-100)
  static const Color errorContainer = Color(0xFFFEE2E2);

  /// Đường viền trạng thái lỗi (Red-200)
  static const Color errorBorder = Color(0xFFFECACA);

  /// Màu chữ trạng thái lỗi tương phản cao (Red-700)
  static const Color errorForeground = Color(0xFFDC2626);

  /// Trạng thái thông tin (Xanh dương Blue-500)
  static const Color info = Color(0xFF3B82F6);

  /// Màu xanh hành động phụ (Royal Blue-600) - Dùng cho nút phụ, liên kết, tag flashcard
  static const Color primaryAction = Color(0xFF2563EB);

  /// Màu xanh cyan đậm (Sky-600) - Dùng cho nhãn ApSkil, tag kỹ năng
  static const Color accentDark = Color(0xFF0284C7);

  // --- Các sắc thái bổ sung dùng chung (Extended Common Palettes) ---
  /// Nền bề mặt sáng phụ (Slate-50) - Dùng cho nền thẻ con, hộp giải thích, bảng câu hỏi
  static const Color surfaceLight = Color(0xFFF8FAFC);

  /// Nền cảnh báo siêu nhẹ (Amber-50) - Dùng cho nền thẻ thông báo nhắc nhở, streak
  static const Color warningLight = Color(0xFFFFFBEB);

  /// Chữ cảnh báo tương phản đậm (Amber-700) - Dùng cho nhãn, chữ cảnh báo
  static const Color warningDark = Color(0xFFB45309);

  /// Trạng thái thành công tươi (Green-600) - Dùng cho nút Đã hoàn thành, huy hiệu Pass
  static const Color successVibrant = Color(0xFF16A34A);

  /// Trạng thái thành công đậm đặc (Green-700) - Dùng cho chữ hoặc viền thẻ đã pass
  static const Color successDarkText = Color(0xFF15803D);

  /// Nền thành công siêu nhẹ (Green-50) - Dùng cho nền thẻ hoàn thành, flashcard thuộc bài
  static const Color successSurfaceLight = Color(0xFFF0FDF4);

  /// Đường viền thành công nhẹ (Green-200) - Dùng cho viền câu trả lời đúng, thẻ hoàn thành
  static const Color successBorderLight = Color(0xFFBBF7D0);

  /// Chữ lỗi/thất bại tương phản đậm (Red-700/800) - Dùng cho chữ rớt bài thi, đáp án sai
  static const Color errorDark = Color(0xFFB91C1C);

  /// Đường viền lỗi nhẹ (Red-300) - Dùng cho viền câu trả lời sai
  static const Color errorBorderLight = Color(0xFFFCA5A5);

  /// Nền lỗi siêu nhẹ (Red-50) - Dùng cho nền câu hỏi sai, thẻ chưa đạt
  static const Color errorSurfaceLight = Color(0xFFFEF2F2);

  // --- Màu trạng thái Hết hạn / Khẩn cấp (Expired / Rose Accent) ---
  /// Màu chữ / icon trạng thái hết hạn hoặc thanh toán quá hạn (Rose-600)
  static const Color expired = Color(0xFFE11D48);

  /// Nền trạng thái hết hạn siêu nhẹ (Rose-50)
  static const Color expiredContainer = Color(0xFFFFF1F2);

  /// Viền trạng thái hết hạn (Rose-200)
  static const Color expiredBorder = Color(0xFFFECDD3);

  // --- Màu nền phụ đậm (Navy Surface) ---
  /// Màu xanh Navy Indigo đậm dùng cho nền card thẻ Plus, bảo mật
  static const Color navySurface = Color(0xFF183A78);
}
