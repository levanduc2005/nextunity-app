/// Utility class định dạng thời gian và ngày tháng dùng chung toàn app.
abstract final class DateTimeFormatter {
  /// Định dạng thời gian tương đối (VD: "Vừa xong", "5 phút trước", "2 giờ trước", "3 ngày trước", "15/10/2026").
  ///
  /// - [includeSuffix]: nếu `true`, thêm "trước" (VD: "5 phút trước"), nếu `false`, bỏ hậu tố (VD: "5 phút").
  /// - [includeYear]: nếu `true`, hiển thị dd/MM/yyyy khi vượt quá 7 ngày, nếu `false`, chỉ hiển thị dd/MM.
  static String formatRelativeTime(
    DateTime? dateTime, {
    bool includeSuffix = true,
    bool includeYear = true,
  }) {
    if (dateTime == null) return 'Vừa xong';

    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'Vừa xong';

    final suffix = includeSuffix ? ' trước' : '';

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} phút$suffix';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours} giờ$suffix';
    }
    if (diff.inDays < 7) {
      return '${diff.inDays} ngày$suffix';
    }

    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    if (includeYear) {
      return '$day/$month/${dateTime.year}';
    }
    return '$day/$month';
  }
}

/// Extension tiện lợi cho phép gọi trực tiếp `createdAt.toRelativeTime()`.
extension DateTimeFormattingExtension on DateTime? {
  String toRelativeTime({bool includeSuffix = true, bool includeYear = true}) {
    return DateTimeFormatter.formatRelativeTime(
      this,
      includeSuffix: includeSuffix,
      includeYear: includeYear,
    );
  }
}
