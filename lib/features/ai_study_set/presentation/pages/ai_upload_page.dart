import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class AiUploadPage extends StatelessWidget {
  const AiUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      appBar: AppBar(
        title: const Text('Tải lên tài liệu AI'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const UnderDevelopmentView(
        featureName: 'Tải lên tài liệu học tập AI',
        description:
            'Chức năng phân tích tài liệu PDF, DOCX, PPTX bằng AI đang được hoàn thiện. Vui lòng quay lại sau!',
        icon: Icons.upload_file_rounded,
      ),
    );
  }
}
