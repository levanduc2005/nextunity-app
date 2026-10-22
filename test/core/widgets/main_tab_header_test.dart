import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/core/widgets/main_tab_header.dart';

void main() {
  group('MainTabHeader Tests', () {
    testWidgets('renders avatar, name on left and notification only when showSearch is false', (tester) async {
      bool notificationTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MainTabHeader(
              displayName: 'Nguyen Van A',
              onNotificationTap: () => notificationTapped = true,
            ),
          ),
        ),
      );

      // Verify display name & fallback initial 'A'
      expect(find.text('Nguyen Van A'), findsOneWidget);
      expect(find.text('A'), findsOneWidget);

      // Verify notification button is rendered
      expect(find.byIcon(Icons.notifications_none_rounded), findsOneWidget);

      // Verify search icon is NOT rendered
      expect(find.byIcon(Icons.search_rounded), findsNothing);

      // Tap notification
      await tester.tap(find.byIcon(Icons.notifications_none_rounded));
      expect(notificationTapped, isTrue);
    });

    testWidgets('renders search icon when showSearch is true', (tester) async {
      bool searchTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MainTabHeader(
              displayName: 'Le Van Duc',
              showSearch: true,
              onSearchTap: () => searchTapped = true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
      expect(find.byIcon(Icons.notifications_none_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.search_rounded));
      expect(searchTapped, isTrue);
    });
  });
}
