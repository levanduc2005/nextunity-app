import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_markdown_reader.dart';

void main() {
  testWidgets('LessonMarkdownReader renders ModernCodeBlockWidget with Mac header, copy button, and line numbers', (tester) async {
    const sampleMarkdown = '''
### 1. Mục tiêu bài học
Học về biến trong ngôn ngữ C và chuẩn conventions.

Khai báo biến inline `int x = 10;` trong hàm main.

```c
#include <stdio.h>

int main() {
    printf("Hello FPT!\\n");
    return 0;
}
```
''';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: LessonMarkdownReader(content: sampleMarkdown),
          ),
        ),
      ),
    );

    // Verify heading without emoji
    expect(find.textContaining('1. Mục tiêu bài học'), findsOneWidget);

    // Verify inline code pill
    expect(find.text('int x = 10;'), findsOneWidget);

    // Verify modern code block widget rendered
    expect(find.byType(ModernCodeBlockWidget), findsOneWidget);

    // Verify language badge
    expect(find.text('C'), findsOneWidget);

    // Verify copy button
    expect(find.text('Sao chép'), findsOneWidget);

    // Tap copy button and check tactile feedback "Đã chép"
    await tester.tap(find.text('Sao chép'));
    await tester.pump();
    expect(find.text('Đã chép'), findsOneWidget);

    // Wait for timer to complete and verify reversion to "Sao chép"
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Sao chép'), findsOneWidget);

    // Verify code lines inside code block
    expect(find.textContaining('printf("Hello FPT!\\n");'), findsOneWidget);
  });
}
