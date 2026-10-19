import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/core/utils/string_utils.dart';

void main() {
  group('StringUtils Tests', () {
    test(
      'getInitials extracts last two words initials for multi-word names',
      () {
        expect(StringUtils.getInitials('Nguyen Van A'), 'VA');
        expect(StringUtils.getInitials('Tran Minh Khoa'), 'MK');
        expect(StringUtils.getInitials('Le Van Duc'), 'VD');
        expect(StringUtils.getInitials('Lê Văn Đức'), 'VĐ');
      },
    );

    test('getInitials extracts first 2 letters for single-word name', () {
      expect(StringUtils.getInitials('Alex'), 'AL');
      expect(StringUtils.getInitials('Bob'), 'BO');
      expect(StringUtils.getInitials('A'), 'A');
    });

    test('getInitials returns fallback for empty or null strings', () {
      expect(StringUtils.getInitials(null), 'NU');
      expect(StringUtils.getInitials(''), 'NU');
      expect(StringUtils.getInitials('   ', fallback: 'U'), 'U');
    });

    test('formatHashtag adds # prefix or preserves existing #', () {
      expect(StringUtils.formatHashtag('SWP391'), '#SWP391');
      expect(StringUtils.formatHashtag('#SWP391'), '#SWP391');
      expect(StringUtils.formatHashtag(null), '#FPTU');
      expect(StringUtils.formatHashtag(''), '#FPTU');
      expect(StringUtils.formatHashtag('  PRM392  '), '#PRM392');
    });
  });
}
