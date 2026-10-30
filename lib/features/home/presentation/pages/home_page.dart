import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/main_tab_header.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/home/presentation/providers/home_providers.dart';
import 'package:rental_car/features/home/presentation/widgets/community/home_community_highlights.dart';
import 'package:rental_car/features/home/presentation/widgets/ongoing_courses/home_ongoing_courses.dart';
import 'package:rental_car/features/home/presentation/widgets/overview/home_app_banner.dart';
import 'package:rental_car/features/home/presentation/widgets/popular_courses/home_popular_courses.dart';

/// Màn hình Trang Chủ (Home Page) thiết kế chuẩn 100% theo phong cách ApSkil E-Learning
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final userProfile = ref.watch(currentUserProvider);
    final coursesState = ref.watch(coursesControllerProvider);
    final communityState = ref.watch(communityControllerProvider);

    final displayName = userProfile?.displayName ?? 'Sinh viên FPT';
    final enrollments = coursesState.myEnrollments;

    // Khóa học nổi bật: Sử dụng danh sách top các khóa học được nhiều học viên đăng ký nhất từ Backend (/api/courses/popular).
    // Nếu dữ liệu API đang load hoặc fallback, lấy tối đa 5 khóa học đầu tiên từ danh sách chung.
    final popularCourses = coursesState.popularCourses.isNotEmpty
        ? coursesState.popularCourses
        : coursesState.allCourses.take(5).toList();

    // Bài viết thảo luận nổi bật từ Backend (/api/posts/popular) theo thuật toán Trending Score
    final popularPosts = communityState.popularPosts.isNotEmpty
        ? communityState.popularPosts
        : communityState.posts.take(3).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: Colors.white,
          onRefresh: () async {
            await Future.wait([
              ref.read(homeControllerProvider.notifier).refresh(),
              ref.read(communityControllerProvider.notifier).loadPopularPosts(),
            ]);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (homeState.isRefreshing)
                  const LinearProgressIndicator(
                    minHeight: 2,
                    color: AppColors.primary,
                  ),

                // 1. HEADING: Avatar + Tên bên trái | Icon Search bên phải
                MainTabHeader(
                  displayName: displayName,
                  avatarUrl: userProfile?.avatarUrl,
                  isPlus: userProfile?.isPlus == true,
                  showSearch: true,
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: 18),

                // 2. BANNER GIỚI THIỆU ỨNG DỤNG (HERO APP BANNER)
                const HomeAppBanner(),
                const SizedBox(height: 22),

                // 3. KHÓA HỌC ĐANG DIỄN RA (KELAS BERLANGSUNG - ONGOING COURSES)
                HomeOngoingCourses(
                  enrollments: enrollments,
                  isLoading: coursesState.isLoading,
                ),
                const SizedBox(height: 20),

                // 4. KHÓA HỌC NỔI BẬT (KELAS POPULER - POPULAR COURSES)
                HomePopularCourses(
                  courses: popularCourses,
                  isLoading: coursesState.isLoading,
                ),
                const SizedBox(height: 22),

                // 5. THẢO LUẬN NỔI BẬT TỪ CỘNG ĐỒNG (COMMUNITY HIGHLIGHTS)
                HomeCommunityHighlights(
                  posts: popularPosts,
                  isLoading: communityState.isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
