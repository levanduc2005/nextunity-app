/// Type-safe route definitions for NextUnity App.
enum AppRoute {
  // Splash & Initialization
  splash('/'),

  // Auth
  login('/login'),
  signUp('/signup'),
  otp('/login/otp'),
  verifyEmail('/auth/verify-email'),
  accountCreated('/auth/account-created'),
  forgotPassword('/auth/forgot-password'),
  resetPassword('/auth/reset-password'),

  // Main Tabs (StatefulShellRoute)
  home('/home'),
  courses('/courses'),
  aiStudySet('/ai-study-set'),
  community('/community'),
  profile('/profile'),

  // Course & Lessons
  courseDetail('/courses/:id'),
  lessonDetail('/lessons/:id'),

  // Study Tools
  flashcards('/study/flashcards'),
  quiz('/study/quiz'),
  quizSubmissionDetail('/study/quiz/submissions/:id'),
  mindmap('/study/mindmap'),
  slidePdfViewer('/study/pdf-viewer'),

  // AI Study Set
  aiUpload('/ai/upload'),
  aiResult('/ai/result/:id'),

  // Community
  postDetail('/community/posts/:id'),
  createPost('/community/create-post'),

  // Profile & Payment
  editProfile('/profile/edit'),
  changePassword('/profile/change-password'),
  upgradePlus('/payment/upgrade-plus'),
  payment('/payment');

  const AppRoute(this.path);

  final String path;
}
