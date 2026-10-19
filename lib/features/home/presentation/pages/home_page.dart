import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/home/presentation/providers/home_providers.dart';
import 'package:rental_car/features/home/presentation/widgets/home_ai_quick_action.dart';
import 'package:rental_car/features/home/presentation/widgets/home_banner_carousel.dart';
import 'package:rental_car/features/home/presentation/widgets/home_courses_carousel.dart';
import 'package:rental_car/features/home/presentation/widgets/home_momentum_card.dart';
import 'package:rental_car/features/home/presentation/widgets/home_study_tools_bento.dart';
import 'package:rental_car/features/home/presentation/widgets/home_top_bar.dart';

/// Màn hình Trang Chủ (Home Page) thiết kế theo chuẩn Sổ tay Sinh viên Bento hiện đại
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final userProfile = ref.watch(currentUserProvider);

    final displayName = userProfile?.displayName ?? 'Học viên';
    final streak = userProfile?.streak ?? 15;
    final points = userProfile?.points ?? 2500;
    final isPlus = userProfile?.isPlus ?? true;
    final avatarUrl = userProfile?.avatarUrl;
    final university = userProfile?.university ?? 'Đại học FPT';
    final major = userProfile?.major ?? 'Software Engineering';
    final cohort = userProfile?.cohort ?? 18;

    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(homeControllerProvider.notifier).refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (homeState.isRefreshing)
                  const LinearProgressIndicator(minHeight: 2),

                // 1. TOP APP BAR & USER IDENTITY
                HomeTopBar(
                  displayName: displayName,
                  streak: streak,
                  isPlus: isPlus,
                  avatarUrl: avatarUrl,
                  university: university,
                  major: major,
                  cohort: cohort,
                ),
                const SizedBox(height: 12),

                // 2. DAILY MOMENTUM & GAMIFICATION CARD (Bento Notebook)
                HomeMomentumCard(points: points, isPlus: isPlus),
                const SizedBox(height: 16),

                // 3. BANNER CAROUSEL (Mục 3: Nâng cấp Plus, Khóa học hot, Workshop)
                const HomeBannerCarousel(),
                const SizedBox(height: 18),

                // 4. SMART STUDY TOOLS (Flashcards, Quiz AI, Mindmap, PDF)
                const HomeStudyToolsBento(),
                const SizedBox(height: 18),

                // 5. HERO CTA: TẠO BỘ HỌC LIỆU VỚI AI (Mục 5: Lối tắt tạo bộ học từ Slide/PDF)
                const HomeAiQuickAction(),
                const SizedBox(height: 20),

                // 6. CURRENT ENROLLED COURSES CAROUSEL
                const HomeCoursesCarousel(),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
