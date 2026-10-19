import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class AiResultPage extends StatelessWidget {
  const AiResultPage({required this.setId, super.key});

  final String setId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      appBar: AppBar(
        title: const Text('Chi tiết AI Study Set'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const UnderDevelopmentView(
        featureName: 'Kết quả AI Study Set',
        description:
            'Nội dung bộ tài liệu học tập AI đang được xử lý hoặc đang phát triển.',
        icon: Icons.auto_awesome_rounded,
      ),
    );
  }
}
