import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/features/shell/presentation/widgets/nextunity_bottom_nav_bar.dart';
import 'package:rental_car/l10n/l10n.dart';

void main() {
  Widget buildTestWidget({
    required int currentIndex,
    required ValueChanged<int> onTap,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('vi'),
      home: Scaffold(
        bottomNavigationBar: NextUnityBottomNavBar(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }

  group('NextUnityBottomNavBar Tests', () {
    testWidgets('renders all 4 navigation tabs', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      await tester.pumpAndSettle();

      expect(find.text('Trang chủ'), findsOneWidget);
      expect(find.text('Khóa học'), findsOneWidget);
      expect(find.text('Cộng đồng'), findsOneWidget);
      expect(find.text('Cá nhân'), findsOneWidget);
    });

    testWidgets('triggers onTap callback when a tab is tapped', (tester) async {
      int? tappedIndex;

      await tester.pumpWidget(
        buildTestWidget(
          currentIndex: 0,
          onTap: (index) {
            tappedIndex = index;
          },
        ),
      );
      await tester.pumpAndSettle();

      // Tap on 'Khóa học' (tab 1)
      await tester.tap(find.text('Khóa học'));
      await tester.pumpAndSettle();
      expect(tappedIndex, equals(1));

      // Tap on 'Cộng đồng' (tab 2)
      await tester.tap(find.text('Cộng đồng'));
      await tester.pumpAndSettle();
      expect(tappedIndex, equals(2));

      // Tap on 'Cá nhân' (tab 3)
      await tester.tap(find.text('Cá nhân'));
      await tester.pumpAndSettle();
      expect(tappedIndex, equals(3));
    });

    testWidgets('displays active indicators for selected index', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 2, onTap: (_) {}));
      await tester.pumpAndSettle();

      // Community tab (index 2) should display selected icon Icons.forum_rounded
      expect(find.byIcon(Icons.forum_rounded), findsOneWidget);
      // Other inactive tabs should display outline icons
      expect(find.byIcon(Icons.explore_outlined), findsOneWidget);
      expect(find.byIcon(Icons.local_library_outlined), findsOneWidget);
      expect(find.byIcon(Icons.person_outline_rounded), findsOneWidget);
    });
  });
}
