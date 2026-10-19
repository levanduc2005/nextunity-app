import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class AiStudySetPage extends StatelessWidget {
  const AiStudySetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      appBar: AppBar(
        title: const Text(
          'AI Study Set',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const UnderDevelopmentView(
        featureName: 'AI Study Set (Bộ học liệu thông minh)',
        description:
            'Tính năng tự động quét slide, tạo tóm tắt, flashcard và bộ câu hỏi trắc nghiệm bằng Trí tuệ nhân tạo (AI) đang được phát triển.\nTính năng sẽ chính thức ra mắt trong phiên bản sắp tới!',
        icon: Icons.auto_awesome_rounded,
        showBackButton: false,
      ),
    );
  }
}
