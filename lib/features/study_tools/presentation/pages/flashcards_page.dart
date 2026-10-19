import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class FlashcardsPage extends StatelessWidget {
  const FlashcardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      appBar: AppBar(
        title: const Text('Ôn tập Flashcards'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const UnderDevelopmentView(
        featureName: 'Bộ thẻ ghi nhớ Flashcards',
        description:
            'Công cụ ôn tập kiến thức nhanh qua thẻ lật thông minh với thuật toán lặp lại ngắt quãng (Spaced Repetition) đang được hoàn thiện.',
        icon: Icons.style_rounded,
      ),
    );
  }
}
