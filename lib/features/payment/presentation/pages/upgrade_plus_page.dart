import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class UpgradePlusPage extends StatelessWidget {
  const UpgradePlusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      appBar: AppBar(
        title: const Text('Nâng cấp NextUnity Plus'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const UnderDevelopmentView(
        featureName: 'Gói thành viên NextUnity Plus',
        description:
            'Chương trình nâng cấp tài khoản Plus với các đặc quyền mở khóa toàn bộ khóa học nâng cao và không giới hạn AI đang được chuẩn bị ra mắt.',
        icon: Icons.workspace_premium_rounded,
      ),
    );
  }
}
