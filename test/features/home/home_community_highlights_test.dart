import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/home/presentation/widgets/community/home_community_highlights.dart';
import 'package:rental_car/features/home/presentation/widgets/community/home_community_post_card.dart';

void main() {
  final testPost1 = PostEntity(
    id: 'p-1',
    title: 'Kinh nghiệm ôn thi môn CSD201',
    content: 'Cấu trúc dữ liệu và giải thuật cần chú ý phần Binary Search Tree và Graph.',
    authorId: 'u-1',
    authorName: 'Trần Văn Nam',
    tags: ['CSD201', 'DataStructures'],
    reactionCount: 15,
    commentCount: 8,
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  );

  final testPost2 = PostEntity(
    id: 'p-2',
    title: 'Thảo luận đề thi PE Java Web PRN211',
    content: 'Mọi người cho mình hỏi bài slot 4 kết nối SQL Server nên dùng JDBC hay Hibernate?',
    authorId: 'u-2',
    authorName: 'Nguyễn Thị Hoa',
    tags: ['PRN211'],
    reactionCount: 24,
    commentCount: 12,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  );

  group('HomeCommunityHighlights Tests', () {
    testWidgets('renders empty card when posts list is empty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HomeCommunityHighlights(
              posts: [],
              isLoading: false,
            ),
          ),
        ),
      );

      expect(find.text('Thảo luận nổi bật'), findsOneWidget);
      expect(find.text('Xem tất cả'), findsOneWidget);
      expect(find.text('Cộng đồng thảo luận'), findsOneWidget);
      expect(find.text('Đặt câu hỏi'), findsOneWidget);
    });

    testWidgets('renders loading indicator when isLoading is true and posts is empty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HomeCommunityHighlights(
              posts: [],
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.text('Thảo luận nổi bật'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders list of popular posts correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: HomeCommunityHighlights(
                posts: [testPost1, testPost2],
                isLoading: false,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Thảo luận nổi bật'), findsOneWidget);
      expect(find.byType(HomeCommunityPostCard), findsNWidgets(2));

      // Check Post 1
      expect(find.text('Trần Văn Nam'), findsOneWidget);
      expect(find.text('Kinh nghiệm ôn thi môn CSD201'), findsOneWidget);
      expect(find.text('#CSD201'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
      expect(find.text('8'), findsOneWidget);

      // Check Post 2
      expect(find.text('Nguyễn Thị Hoa'), findsOneWidget);
      expect(find.text('Thảo luận đề thi PE Java Web PRN211'), findsOneWidget);
      expect(find.text('#PRN211'), findsOneWidget);
      expect(find.text('24'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
    });

    testWidgets('tapping post card triggers navigation to post detail', (tester) async {
      String? navigatedRoute;

      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: SingleChildScrollView(
                child: HomeCommunityHighlights(
                  posts: [testPost1],
                  isLoading: false,
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/community/posts/:id',
            builder: (context, state) {
              navigatedRoute = state.uri.toString();
              return const Scaffold(body: Text('Post Detail Mock'));
            },
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Kinh nghiệm ôn thi môn CSD201'));
      await tester.pumpAndSettle();

      expect(navigatedRoute, equals('/community/posts/p-1'));
      expect(find.text('Post Detail Mock'), findsOneWidget);
    });
  });
}

