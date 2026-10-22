import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

class AiStudySetPage extends ConsumerWidget {
  const AiStudySetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      body: SafeArea(
        child: Column(
          children: [
            MainTabHeader(
              displayName: user?.displayName,
              avatarUrl: user?.avatarUrl,
            ),
            const Expanded(
              child: UnderDevelopmentView(
                featureName: 'AI Study Set (Bộ học liệu thông minh)',
                description:
                    'Tính năng tự động quét slide, tạo tóm tắt, flashcard và bộ câu hỏi trắc nghiệm bằng Trí tuệ nhân tạo (AI) đang được phát triển.\nTính năng sẽ chính thức ra mắt trong phiên bản sắp tới!',
                icon: Icons.auto_awesome_rounded,
                showBackButton: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
