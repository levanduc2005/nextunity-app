import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/nextunity_logo.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_header_card.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_stats_row.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_top_bar.dart';

class _MockProfileController extends ProfileController {
  @override
  ProfileState build() {
    return const ProfileState();
  }
}

void main() {
  const userLongData = UserEntity(
    id: '1',
    email: 'long.user.email.address@fpt.edu.vn',
    fullName: 'Nguyen Dinh Thach Thao Longest Name In The World',
    university: 'Truong Dai Hoc FPT Phan Thiet Binh Thuan Campus Very Long',
    studentId: 'SE18999999999',
    major: 'Software Engineering Specialization Mobile Development Enterprise',
    cohort: 18,
    streak: 15,
    points: 2500,
    isPlus: true,
  );

  testWidgets('Test ProfileTopBar layout on 360px screen', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0; // 360 logical width
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: ProfileTopBar())),
      ),
    );
    await tester.pump();
    expect(find.byType(ProfileTopBar), findsOneWidget);
  });

  testWidgets('Test ProfileTopBar layout on compact 320px screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(640, 1280);
    tester.view.devicePixelRatio = 2.0; // 320 logical width
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: ProfileTopBar())),
      ),
    );
    await tester.pump();
    expect(find.byType(ProfileTopBar), findsOneWidget);
  });

  testWidgets('Test ProfileHeaderCard layout on 360px with very long data', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0; // 360 logical width
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileControllerProvider.overrideWith(_MockProfileController.new),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ProfileHeaderCard(user: userLongData),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(ProfileHeaderCard), findsOneWidget);
  });

  testWidgets('Test ProfileHeaderCard layout on compact 320px screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(640, 1280);
    tester.view.devicePixelRatio = 2.0; // 320 logical width
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileControllerProvider.overrideWith(_MockProfileController.new),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ProfileHeaderCard(user: userLongData),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(ProfileHeaderCard), findsOneWidget);
  });

  testWidgets('Test ProfileStatsRow layout', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: ProfileStatsRow(user: userLongData)),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(ProfileStatsRow), findsOneWidget);
  });

  testWidgets('Test NextUnityHeader layout', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: NextUnityHeader())),
    );
    await tester.pump();
    expect(find.byType(NextUnityHeader), findsOneWidget);
  });
}
