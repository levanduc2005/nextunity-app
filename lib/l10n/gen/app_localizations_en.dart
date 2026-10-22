// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NextUnity';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeWelcome => 'Welcome back! Ready to learn today?';

  @override
  String get homeSubtitle =>
      'Master your subjects with AI-powered study sets & courses.';

  @override
  String routeNotFound(String location) {
    return 'Page not found: $location';
  }

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get comingSoon => 'Coming soon.';

  @override
  String get tabHome => 'Home';

  @override
  String get tabCourses => 'Courses';

  @override
  String get tabAiStudy => 'AI Study';

  @override
  String get tabCommunity => 'Community';

  @override
  String get tabProfile => 'Profile';

  @override
  String get loginTitle => 'Welcome to NextUnity';

  @override
  String get loginSubtitle => 'Sign in to elevate your learning journey.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailInvalid => 'Enter a valid email address.';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordTooShort => 'Password is too short.';

  @override
  String get loginButton => 'Sign in';

  @override
  String get logout => 'Log Out';

  @override
  String get logoutConfirmTitle => 'Log Out?';

  @override
  String get logoutConfirmMessage =>
      'You will need to sign in again next time.';

  @override
  String get guestName => 'NextUnity Learner';

  @override
  String get guestEmail => 'student@nextunity.edu.vn';

  @override
  String get profileAccountSection => 'Account';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileAbout => 'About NextUnity';

  @override
  String get errorNetwork => 'No internet connection. Please try again.';

  @override
  String get errorServer =>
      'Something went wrong on our end. Please try again later.';

  @override
  String get errorData => 'We received unexpected data. Please try again.';

  @override
  String get errorCache => 'Could not read local data.';

  @override
  String get errorUnknown => 'An unexpected error occurred.';

  @override
  String get loginTopBarTitle => 'Sign in';

  @override
  String get loginEmailTitle => 'Enter your email to continue';

  @override
  String get loginEmailSubtitle =>
      'Sign in to access your AI study sets and personalized courses.';

  @override
  String get emailRequired => 'Please enter your email address.';

  @override
  String get continueButton => 'Continue';

  @override
  String get orDivider => 'or';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get otpVerificationTitle => 'OTP Verification';

  @override
  String otpSentToMessage(String email) {
    return 'Enter the OTP code sent to $email';
  }

  @override
  String get changeEmail => 'Change email';

  @override
  String resendOtpIn(int seconds) {
    return 'Resend OTP (${seconds}s)';
  }

  @override
  String get resendOtpNow => 'Resend OTP';

  @override
  String get otpInvalidLength => 'Please enter a 6-digit OTP code.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get upgradePlus => 'Upgrade to Plus';

  @override
  String get dailyStreak => 'Day Streak';

  @override
  String get rewardPoints => 'Points';
}
