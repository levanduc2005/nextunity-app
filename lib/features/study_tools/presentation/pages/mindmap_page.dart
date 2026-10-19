import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class MindmapPage extends StatelessWidget {
  const MindmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      appBar: AppBar(
        title: const Text('Bản đồ tư duy Mindmap'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const UnderDevelopmentView(
        featureName: 'Sơ đồ tư duy bài học (Mindmap)',
        description:
            'Chức năng trực quan hóa các mối liên kết khái niệm bài học dạng cây Mindmap đang được hoàn thiện.',
        icon: Icons.account_tree_rounded,
      ),
    );
  }
}
