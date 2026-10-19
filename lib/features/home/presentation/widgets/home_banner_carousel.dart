import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';

/// Banner Carousel nổi bật trên Trang Chủ (Đồng nhất theme Pastel / Sổ tay Sinh viên FPT)
class HomeBannerCarousel extends ConsumerStatefulWidget {
  const HomeBannerCarousel({super.key});

  @override
  ConsumerState<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends ConsumerState<HomeBannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % 3;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coursesState = ref.watch(coursesControllerProvider);
    final communityState = ref.watch(communityControllerProvider);

    final featuredCourse = coursesState.allCourses.isNotEmpty
        ? coursesState.allCourses.first
        : null;
    final topPost = communityState.posts.isNotEmpty
        ? communityState.posts.first
        : null;

    final bannerItems = [
      _BannerData(
        tag: 'NEXTUNITY PLUS',
        tagColor: const Color(0xFFB45309),
        tagBgColor: const Color(0xFFFEF3C7),
        title: 'Mở khóa toàn bộ môn học & Trợ lý AI',
        subtitle:
            'Chỉ 2.000đ/tháng • Giải đề PE & tóm tắt Slide không giới hạn',
        ctaText: 'Nâng cấp ngay',
        icon: Icons.workspace_premium_rounded,
        gradient: const [Color(0xFFFFFFFF), Color(0xFFFFFBEB)],
        borderColor: const Color(0xFFFDE68A),
        ctaBgColor: const Color(0xFFF59E0B),
        onTap: () => context.push(AppRoute.upgradePlus.path),
      ),
      _BannerData(
        tag: featuredCourse != null
            ? 'KHÓA HỌC NỔI BẬT • ${featuredCourse.code}'
            : 'KHÓA HỌC NỔI BẬT',
        tagColor: const Color(0xFF1D4ED8),
        tagBgColor: const Color(0xFFDBEAFE),
        title:
            featuredCourse?.title ?? 'Lập trình C# & .NET toàn diện (PRN211)',
        subtitle: featuredCourse != null
            ? '${featuredCourse.totalLessons} bài học • Giảng viên: ${featuredCourse.creatorName ?? "FPT University"}'
            : 'Chuẩn bị thực chiến cho kỳ thi Practical Exam',
        ctaText: 'Khám phá khóa học',
        icon: Icons.menu_book_rounded,
        gradient: const [Color(0xFFFFFFFF), Color(0xFFEFF6FF)],
        borderColor: const Color(0xFFBFDBFE),
        ctaBgColor: AppColors.primary,
        onTap: () {
          if (featuredCourse != null) {
            context.push(
              AppRoute.courseDetail.path.replaceFirst(':id', featuredCourse.id),
            );
          } else {
            context.go(AppRoute.courses.path);
          }
        },
      ),
      _BannerData(
        tag: 'CỘNG ĐỒNG FPT',
        tagColor: const Color(0xFF047857),
        tagBgColor: const Color(0xFFD1FAE5),
        title: topPost?.title ?? 'Kinh nghiệm ôn thi PE & Đồ án tốt nghiệp FPT',
        subtitle: topPost != null
            ? 'Bởi ${topPost.authorName ?? "Sinh viên"} (${topPost.authorUniversity ?? "FPT"}) • ${topPost.reactionCount} lượt quan tâm'
            : 'Chia sẻ đề thi thử, tài liệu môn học và hỏi đáp bài tập khó',
        ctaText: 'Đọc thảo luận',
        icon: Icons.forum_rounded,
        gradient: const [Color(0xFFFFFFFF), Color(0xFFF0FDF4)],
        borderColor: const Color(0xFFBBF7D0),
        ctaBgColor: const Color(0xFF10B981),
        onTap: () {
          if (topPost != null) {
            context.push(
              AppRoute.postDetail.path.replaceFirst(':id', topPost.id),
            );
          } else {
            context.go(AppRoute.community.path);
          }
        },
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 165,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: bannerItems.length,
            itemBuilder: (context, index) {
              final item = bannerItems[index];
              return _buildBannerCard(item);
            },
          ),
        ),
        const SizedBox(height: 10),
        // Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(bannerItems.length, (index) {
            final isActive = _currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 20 : 6,
              height: 5,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBannerCard(_BannerData item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: item.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: item.borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D5AFE).withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Icon Watermark
          Positioned(
            right: -10,
            bottom: -15,
            child: Icon(
              item.icon,
              size: 130,
              color: item.ctaBgColor.withValues(alpha: 0.08),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tag badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: item.tagBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.tag,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: item.tagColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),

                // Title & Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.2,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                // CTA Button
                InkWell(
                  onTap: item.onTap,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 6.5,
                    ),
                    decoration: BoxDecoration(
                      color: item.ctaBgColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: item.ctaBgColor.withValues(alpha: 0.28),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.ctaText,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 13,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerData {
  const _BannerData({
    required this.tag,
    required this.tagColor,
    required this.tagBgColor,
    required this.title,
    required this.subtitle,
    required this.ctaText,
    required this.icon,
    required this.gradient,
    required this.borderColor,
    required this.ctaBgColor,
    required this.onTap,
  });

  final String tag;
  final Color tagColor;
  final Color tagBgColor;
  final String title;
  final String subtitle;
  final String ctaText;
  final IconData icon;
  final List<Color> gradient;
  final Color borderColor;
  final Color ctaBgColor;
  final VoidCallback onTap;
}
