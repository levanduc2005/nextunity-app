/// Utility class cung cấp các hàm xử lý và định dạng chuỗi dùng chung toàn app.
abstract final class StringUtils {
  /// Lấy 1-2 chữ cái viết tắt đại diện từ họ tên (VD: "Nguyen Van A" -> "VA", "Alex" -> "AL").
  static String getInitials(String? name, {String fallback = 'NU'}) {
    if (name == null) return fallback;
    final trimmed = name.trim();
    if (trimmed.isEmpty) return fallback;

    final parts = trimmed
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.length >= 2) {
      final secondLast = parts[parts.length - 2];
      final last = parts.last;
      return '${secondLast[0]}${last[0]}'.toUpperCase();
    }
    return trimmed.substring(0, trimmed.length >= 2 ? 2 : 1).toUpperCase();
  }

  /// Đảm bảo thẻ hashtag bắt đầu bằng '#' (VD: "SWP391" -> "#SWP391").
  static String formatHashtag(String? tag, {String fallback = '#FPTU'}) {
    if (tag == null || tag.trim().isEmpty) return fallback;
    final trimmed = tag.trim();
    return trimmed.startsWith('#') ? trimmed : '#$trimmed';
  }
}
