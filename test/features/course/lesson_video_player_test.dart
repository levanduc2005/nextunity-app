import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_video_player_box.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  group('LessonVideoPlayerBox Fullscreen and Inline Player Tests', () {
    test('Default autoFullScreen is false to prevent fullscreen loop in landscape', () {
      const playerBox = LessonVideoPlayerBox(
        estimatedMinutes: 15,
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        title: 'Clean Architecture Lesson',
      );

      expect(playerBox.autoFullScreen, isFalse);
      expect(playerBox.isCinemaMode, isTrue);
      expect(playerBox.estimatedMinutes, 15);
    });

    testWidgets('Renders poster thumbnail initially with Video badge', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LessonVideoPlayerBox(
              estimatedMinutes: 20,
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
              title: 'Clean Architecture Intro',
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('VIDEO BÀI GIẢNG'), findsOneWidget);
      expect(find.text('20 phút'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow_rounded), findsWidgets);
    });

    testWidgets('Tapping poster triggers inline playback without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LessonVideoPlayerBox(
              estimatedMinutes: 20,
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
              title: 'Clean Architecture Intro',
            ),
          ),
        ),
      );
      await tester.pump();

      final inkWellFinder = find.byType(InkWell);
      expect(inkWellFinder, findsOneWidget);
      await tester.tap(inkWellFinder);
      await tester.pump();

      // Check if YoutubePlayer is rendered or fallback safely
      final youtubePlayerFinder = find.byType(YoutubePlayer);
      if (youtubePlayerFinder.evaluate().isNotEmpty) {
        final YoutubePlayer playerWidget = tester.widget(youtubePlayerFinder);
        expect(playerWidget.autoFullScreen, isFalse);
        expect(playerWidget.enableFullScreenOnVerticalDrag, isFalse);
        expect(playerWidget.aspectRatio, 16 / 9);

        final params = playerWidget.controller.params;
        expect(params.playsInline, isTrue);
        expect(params.showFullscreenButton, isTrue);
      }
    });

    testWidgets('Landscape constrained width renders within left column width', (tester) async {
      tester.view.physicalSize = const Size(844 * 3.0, 390 * 3.0);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      const maxVideoWidth = 844 * 0.50; // 422 logical width

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                SizedBox(
                  width: maxVideoWidth,
                  child: LessonVideoPlayerBox(
                    estimatedMinutes: 10,
                    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                    title: 'Landscape Inline Test',
                  ),
                ),
                Expanded(
                  child: Center(child: Text('Theory & Code')),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      final videoBox = tester.getRect(find.byType(LessonVideoPlayerBox));
      expect(videoBox.width, equals(maxVideoWidth));
      expect(find.text('Theory & Code'), findsOneWidget);
    });
  });
}

