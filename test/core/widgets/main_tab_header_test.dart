import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/core/widgets/main_tab_header.dart';

void main() {
  group('MainTabHeader Tests', () {
    testWidgets(
      'renders avatar, name on left when showSearch is false',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: MainTabHeader(
                displayName: 'Nguyen Van A',
              ),
            ),
          ),
        );

        // Verify display name & fallback initial 'A'
        expect(find.text('Nguyen Van A'), findsOneWidget);
        expect(find.text('A'), findsOneWidget);

        // Verify search icon is NOT rendered
        expect(find.byIcon(Icons.search_rounded), findsNothing);
      },
    );

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

      await tester.tap(find.byIcon(Icons.search_rounded));
      expect(searchTapped, isTrue);
    });

    testWidgets('renders custom trailing widget if provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MainTabHeader(
              displayName: 'Nguyen Van B',
              trailing: Text('Custom Trailing'),
            ),
          ),
        ),
      );

      expect(find.text('Custom Trailing'), findsOneWidget);
    });
  });
}
