import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class PdfViewerPage extends StatelessWidget {
  const PdfViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      appBar: AppBar(
        title: const Text('Tài liệu Slide & PDF'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const UnderDevelopmentView(
        featureName: 'Trình đọc tài liệu Slide / PDF',
        description:
            'Chức năng xem và ghi chú trực tiếp trên tài liệu giáo trình trực tuyến đang được tích hợp.',
        icon: Icons.picture_as_pdf_rounded,
      ),
    );
  }
}
