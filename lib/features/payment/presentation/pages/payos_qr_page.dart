import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class PayosQrPage extends StatelessWidget {
  const PayosQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      appBar: AppBar(
        title: const Text('Thanh toán VietQR'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const UnderDevelopmentView(
        featureName: 'Cổng thanh toán tự động VietQR',
        description:
            'Cổng thanh toán trực tuyến tự động kích hoạt gói thành viên đang được kết nối và kiểm thử an toàn.',
        icon: Icons.qr_code_2_rounded,
      ),
    );
  }
}
