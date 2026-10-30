import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/core/widgets/main_tab_header.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/auth/presentation/pages/login_page.dart';
import 'package:rental_car/features/auth/presentation/pages/sign_up_page.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/nextunity_logo.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/home/presentation/widgets/community/home_community_highlights.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_bottom_bar.dart';
import 'package:rental_car/features/payment/domain/entities/subscription_plan_entity.dart';
import 'package:rental_car/features/payment/presentation/pages/upgrade_plus_page.dart';
import 'package:rental_car/features/payment/presentation/providers/payment_providers.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_header_card.dart';

class _MockProfileController extends ProfileController {
  @override
  ProfileState build() {
    return const ProfileState();
  }
}

class _MockAuthController extends AuthController {
  @override
  AuthState build() => const AuthState();
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
    isPlus: true,
  );

  testWidgets('Test MainTabHeader layout on 360px screen', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0; // 360 logical width
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: MainTabHeader())),
      ),
    );
    await tester.pump();
    expect(find.byType(MainTabHeader), findsOneWidget);
  });

  testWidgets('Test MainTabHeader layout on compact 320px screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(640, 1280);
    tester.view.devicePixelRatio = 2.0; // 320 logical width
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: MainTabHeader())),
      ),
    );
    await tester.pump();
    expect(find.byType(MainTabHeader), findsOneWidget);
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

  testWidgets('Test LessonBottomBar layout on 360px screen', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: LessonBottomBar(
            isCompleted: false,
            isUpdating: false,
            onTapPrevious: () {},
            onToggleComplete: () {},
            onTapNext: () {},
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(LessonBottomBar), findsOneWidget);
  });

  testWidgets('Test LessonBottomBar layout on compact 320px screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(640, 1280);
    tester.view.devicePixelRatio = 2.0; // 320 logical width
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: LessonBottomBar(
            isCompleted: false,
            isUpdating: false,
            onTapPrevious: () {},
            onToggleComplete: () {},
            onTapNext: () {},
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(LessonBottomBar), findsOneWidget);
  });

  testWidgets(
    'Test LoginPage and SignUpPage render without overflow on 390x844 screen',
    (tester) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3.0; // 390x844 logical width & height
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authControllerProvider.overrideWith(_MockAuthController.new),
          ],
          child: const MaterialApp(home: Scaffold(body: LoginPage())),
        ),
      );
      await tester.pump();
      expect(find.byType(LoginPage), findsOneWidget);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authControllerProvider.overrideWith(_MockAuthController.new),
          ],
          child: const MaterialApp(home: Scaffold(body: SignUpPage())),
        ),
      );
      await tester.pump();
      expect(find.byType(SignUpPage), findsOneWidget);
    },
  );

  testWidgets(
    'Test UpgradePlusPage renders without overflow on compact 320px screen',
    (tester) async {
      tester.view.physicalSize = const Size(640, 1280);
      tester.view.devicePixelRatio = 2.0; // 320 logical width
      addTearDown(() => tester.view.resetPhysicalSize());

      final mockPlans = <SubscriptionPlanEntity>[
        const SubscriptionPlanEntity(
          name: 'Gói 1 Học kỳ (4 tháng)',
          code: 'PLUS_SEMESTER',
          price: 129000,
          durationDays: 120,
          description: 'Trọn gói học kỳ, tiết kiệm tối đa chi phí học tập',
        ),
        const SubscriptionPlanEntity(
          name: 'Gói 1 Tháng',
          code: 'PLUS_MONTHLY',
          price: 59000,
          durationDays: 30,
          description: 'Gia hạn linh hoạt hàng tháng',
        ),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            availablePlansProvider.overrideWith((ref) async => mockPlans),
          ],
          child: const MaterialApp(home: UpgradePlusPage()),
        ),
      );
      await tester.pump();
      expect(find.byType(UpgradePlusPage), findsOneWidget);
    },
  );

  testWidgets(
    'Test HomeCommunityHighlights renders without overflow on compact 320px screen',
    (tester) async {
      tester.view.physicalSize = const Size(640, 1280);
      tester.view.devicePixelRatio = 2.0; // 320 logical width
      addTearDown(() => tester.view.resetPhysicalSize());

      final testPost = PostEntity(
        id: 'p-1',
        title: 'Kinh nghiệm ôn thi môn CSD201 cho sinh viên CNTT FPT',
        content: 'Cấu trúc dữ liệu và giải thuật cần chú ý phần Binary Search Tree và Graph.',
        authorId: 'u-1',
        authorName: 'Nguyen Dinh Thach Thao Very Long Name In The University',
        tags: ['CSD201', 'DataStructures'],
        reactionCount: 155,
        commentCount: 88,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: HomeCommunityHighlights(
                posts: [testPost],
                isLoading: false,
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Thảo luận nổi bật'), findsOneWidget);
    },
  );
}
