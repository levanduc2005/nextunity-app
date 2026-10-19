import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/core/utils/date_time_formatter.dart';

void main() {
  group('DateTimeFormatter Tests', () {
    test('returns "Vừa xong" when null or under 1 minute', () {
      expect(DateTimeFormatter.formatRelativeTime(null), 'Vừa xong');
      expect(
        DateTimeFormatter.formatRelativeTime(
          DateTime.now().subtract(const Duration(seconds: 30)),
        ),
        'Vừa xong',
      );
    });

    test('formats minutes relative time with and without suffix', () {
      final fiveMinutesAgo = DateTime.now().subtract(
        const Duration(minutes: 5),
      );
      expect(
        DateTimeFormatter.formatRelativeTime(fiveMinutesAgo),
        '5 phút trước',
      );
      expect(
        DateTimeFormatter.formatRelativeTime(
          fiveMinutesAgo,
          includeSuffix: false,
        ),
        '5 phút',
      );
    });

    test('formats hours relative time with and without suffix', () {
      final twoHoursAgo = DateTime.now().subtract(const Duration(hours: 2));
      expect(twoHoursAgo.toRelativeTime(), '2 giờ trước');
      expect(twoHoursAgo.toRelativeTime(includeSuffix: false), '2 giờ');
    });

    test('formats days relative time with and without suffix', () {
      final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
      expect(threeDaysAgo.toRelativeTime(), '3 ngày trước');
      expect(threeDaysAgo.toRelativeTime(includeSuffix: false), '3 ngày');
    });

    test('formats date when older than 7 days', () {
      final date = DateTime(2026, 5, 20);
      expect(date.toRelativeTime(), '20/05/2026');
      expect(date.toRelativeTime(includeYear: false), '20/05');
    });
  });
}
