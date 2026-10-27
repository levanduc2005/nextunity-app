import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/features/home/presentation/widgets/overview/home_app_banner.dart';

void main() {
  testWidgets('HomeAppBanner renders title, CTA and triggers onTap', (
    tester,
  ) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: HomeAppBanner(onTap: () => tapped = true)),
      ),
    );

    // Verify texts
    expect(find.text('Học tập & Ôn thi thông minh'), findsOneWidget);
    expect(find.text('Khám phá ngay'), findsOneWidget);

    // Tap banner
    await tester.tap(find.byType(HomeAppBanner));
    expect(tapped, isTrue);
  });
}
