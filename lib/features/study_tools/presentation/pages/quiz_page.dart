import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      appBar: AppBar(
        title: const Text('Luyện tập Quiz trắc nghiệm'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const UnderDevelopmentView(
        featureName: 'Luyện tập Quiz trắc nghiệm',
        description:
            'Chức năng làm bài kiểm tra trắc nghiệm tương tác tính điểm và giải thích chi tiết đang được phát triển.',
        icon: Icons.quiz_rounded,
      ),
    );
  }
}
