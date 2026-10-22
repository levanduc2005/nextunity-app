import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/ai_study_set/presentation/pages/ai_result_page.dart';
import 'package:rental_car/features/ai_study_set/presentation/pages/ai_study_set_page.dart';
import 'package:rental_car/features/ai_study_set/presentation/pages/ai_upload_page.dart';
import 'package:rental_car/features/auth/presentation/pages/account_created_page.dart';
import 'package:rental_car/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:rental_car/features/auth/presentation/pages/login_page.dart';
import 'package:rental_car/features/auth/presentation/pages/reset_password_page.dart';
import 'package:rental_car/features/auth/presentation/pages/sign_up_page.dart';
import 'package:rental_car/features/auth/presentation/pages/verify_email_page.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/community/presentation/pages/community_page.dart';
import 'package:rental_car/features/community/presentation/pages/create_post_page.dart';
import 'package:rental_car/features/community/presentation/pages/post_detail_page.dart';
import 'package:rental_car/features/course/presentation/pages/course_detail_page.dart';
import 'package:rental_car/features/course/presentation/pages/courses_page.dart';
import 'package:rental_car/features/course/presentation/pages/lesson_detail_page.dart';
import 'package:rental_car/features/home/presentation/pages/home_page.dart';
import 'package:rental_car/features/payment/domain/entities/payment_result_entity.dart';
import 'package:rental_car/features/payment/presentation/pages/payment_page.dart';
import 'package:rental_car/features/payment/presentation/pages/upgrade_plus_page.dart';
import 'package:rental_car/features/profile/presentation/pages/change_password_page.dart';
import 'package:rental_car/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:rental_car/features/profile/presentation/pages/profile_page.dart';
import 'package:rental_car/features/shell/presentation/scaffold_with_nav_bar.dart';
import 'package:rental_car/features/study_tools/presentation/pages/flashcards_page.dart';
import 'package:rental_car/features/study_tools/presentation/pages/mindmap_page.dart';
import 'package:rental_car/features/study_tools/presentation/pages/pdf_viewer_page.dart';
import 'package:rental_car/features/study_tools/presentation/pages/quiz_page.dart';
import 'package:rental_car/l10n/l10n.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Rebuild redirect logic whenever auth state changes
  final refresh = _AuthRefreshNotifier(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: refresh,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final loggedIn = authState.isAuthenticated;
      final isInitial = authState.status == AuthStatus.initial;
      final onSplash = state.matchedLocation == AppRoute.splash.path;
      final onAuthPage =
          state.matchedLocation == AppRoute.login.path ||
          state.matchedLocation == AppRoute.signUp.path ||
          state.matchedLocation == AppRoute.otp.path ||
          state.matchedLocation == AppRoute.verifyEmail.path ||
          state.matchedLocation == AppRoute.accountCreated.path ||
          state.matchedLocation == AppRoute.forgotPassword.path ||
          state.matchedLocation == AppRoute.resetPassword.path;

      // Đang kiểm tra token / cache người dùng khi mới bật app
      if (isInitial) {
        return onSplash ? null : AppRoute.splash.path;
      }

      // Chưa đăng nhập
      if (!loggedIn) {
        return onAuthPage ? null : AppRoute.login.path;
      }

      // Đã đăng nhập: nếu đang ở splash hoặc các trang auth thì tự động vào home
      if (onAuthPage || onSplash) {
        if (state.matchedLocation == AppRoute.accountCreated.path ||
            state.matchedLocation == AppRoute.resetPassword.path) {
          return null;
        }
        return AppRoute.home.path;
      }
      return null;
    },
    routes: [
      // Splash route
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (_, _) => const Scaffold(
          backgroundColor: Color(0xFFF8FAFC),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage('public/app_logo.png'),
                  width: 72,
                  height: 72,
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Auth routes
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (_, _) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoute.signUp.path,
        name: AppRoute.signUp.name,
        builder: (_, _) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRoute.otp.path,
        name: AppRoute.otp.name,
        builder: (_, state) => VerifyEmailPage(email: state.extra as String?),
      ),
      GoRoute(
        path: AppRoute.verifyEmail.path,
        name: AppRoute.verifyEmail.name,
        builder: (_, state) => VerifyEmailPage(email: state.extra as String?),
      ),
      GoRoute(
        path: AppRoute.accountCreated.path,
        name: AppRoute.accountCreated.name,
        builder: (_, _) => const AccountCreatedPage(),
      ),
      GoRoute(
        path: AppRoute.forgotPassword.path,
        name: AppRoute.forgotPassword.name,
        builder: (_, _) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoute.resetPassword.path,
        name: AppRoute.resetPassword.name,
        builder: (_, state) => ResetPasswordPage(email: state.extra as String?),
      ),
      GoRoute(
        path: AppRoute.changePassword.path,
        name: AppRoute.changePassword.name,
        builder: (_, _) => const ChangePasswordPage(),
      ),

      // Profile details
      GoRoute(
        path: AppRoute.editProfile.path,
        name: AppRoute.editProfile.name,
        builder: (_, _) => const EditProfilePage(),
      ),

      // Course details
      GoRoute(
        path: AppRoute.courseDetail.path,
        name: AppRoute.courseDetail.name,
        builder: (_, state) =>
            CourseDetailPage(courseId: state.pathParameters['id'] ?? 'EXE201'),
      ),
      GoRoute(
        path: AppRoute.lessonDetail.path,
        name: AppRoute.lessonDetail.name,
        builder: (_, state) =>
            LessonDetailPage(lessonId: state.pathParameters['id'] ?? '1'),
      ),

      // Study tools
      GoRoute(
        path: AppRoute.flashcards.path,
        name: AppRoute.flashcards.name,
        builder: (_, _) => const FlashcardsPage(),
      ),
      GoRoute(
        path: AppRoute.quiz.path,
        name: AppRoute.quiz.name,
        builder: (_, _) => const QuizPage(),
      ),
      GoRoute(
        path: AppRoute.mindmap.path,
        name: AppRoute.mindmap.name,
        builder: (_, _) => const MindmapPage(),
      ),
      GoRoute(
        path: AppRoute.slidePdfViewer.path,
        name: AppRoute.slidePdfViewer.name,
        builder: (_, _) => const PdfViewerPage(),
      ),

      // AI Study Set
      GoRoute(
        path: AppRoute.aiUpload.path,
        name: AppRoute.aiUpload.name,
        builder: (_, _) => const AiUploadPage(),
      ),
      GoRoute(
        path: AppRoute.aiResult.path,
        name: AppRoute.aiResult.name,
        builder: (_, state) =>
            AiResultPage(setId: state.pathParameters['id'] ?? '1'),
      ),

      // Community
      GoRoute(
        path: AppRoute.postDetail.path,
        name: AppRoute.postDetail.name,
        builder: (_, state) =>
            PostDetailPage(postId: state.pathParameters['id'] ?? '1'),
      ),
      GoRoute(
        path: AppRoute.createPost.path,
        name: AppRoute.createPost.name,
        builder: (_, _) => const CreatePostPage(),
      ),

      // Payment
      GoRoute(
        path: AppRoute.upgradePlus.path,
        name: AppRoute.upgradePlus.name,
        builder: (_, _) => const UpgradePlusPage(),
      ),
      GoRoute(
        path: AppRoute.payment.path,
        name: AppRoute.payment.name,
        builder: (_, state) {
          if (state.extra is PaymentResultEntity) {
            return PaymentPage(
              paymentResult: state.extra as PaymentResultEntity,
            );
          } else if (state.extra is Map<String, dynamic>) {
            final map = state.extra as Map<String, dynamic>;
            return PaymentPage(
              paymentResult: map['paymentResult'] as PaymentResultEntity?,
              planName: map['planName'] as String? ?? 'Gói NextUnity Plus',
            );
          }
          return const PaymentPage();
        },
      ),

      // The tabbed app shell (5 main branches)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          // Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                builder: (_, _) => const HomePage(),
              ),
            ],
          ),
          // Branch 1: Courses
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.courses.path,
                name: AppRoute.courses.name,
                builder: (_, _) => const CoursesPage(),
              ),
            ],
          ),
          // Branch 2: AI Study Set
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.aiStudySet.path,
                name: AppRoute.aiStudySet.name,
                builder: (_, _) => const AiStudySetPage(),
              ),
            ],
          ),
          // Branch 3: Community
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.community.path,
                name: AppRoute.community.name,
                builder: (_, _) => const CommunityPage(),
              ),
            ],
          ),
          // Branch 4: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                builder: (_, _) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(context.l10n.routeNotFound(state.uri.toString())),
      ),
    ),
  );
});

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    ref.listen(authControllerProvider, (_, _) => notifyListeners());
  }
}
