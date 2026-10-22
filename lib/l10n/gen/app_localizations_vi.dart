// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'NextUnity';

  @override
  String get homeTitle => 'Trang chủ';

  @override
  String get homeWelcome => 'Chào mừng bạn quay lại! Hôm nay bạn muốn học gì?';

  @override
  String get homeSubtitle =>
      'Học tập thông minh với AI Study Set, Flashcard & Khóa học.';

  @override
  String routeNotFound(String location) {
    return 'Không tìm thấy trang: $location';
  }

  @override
  String get retry => 'Thử lại';

  @override
  String get cancel => 'Hủy';

  @override
  String get comingSoon => 'Sắp ra mắt.';

  @override
  String get tabHome => 'Trang chủ';

  @override
  String get tabCourses => 'Khóa học';

  @override
  String get tabAiStudy => 'AI Study';

  @override
  String get tabCommunity => 'Cộng đồng';

  @override
  String get tabProfile => 'Cá nhân';

  @override
  String get loginTitle => 'Chào mừng đến với NextUnity';

  @override
  String get loginSubtitle =>
      'Đăng nhập để nâng tầm hành trình học tập của bạn.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailInvalid => 'Vui lòng nhập email hợp lệ.';

  @override
  String get passwordLabel => 'Mật khẩu';

  @override
  String get passwordTooShort => 'Mật khẩu quá ngắn.';

  @override
  String get loginButton => 'Đăng nhập';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get logoutConfirmTitle => 'Đăng xuất?';

  @override
  String get logoutConfirmMessage => 'Bạn sẽ cần đăng nhập lại lần sau.';

  @override
  String get guestName => 'Học viên NextUnity';

  @override
  String get guestEmail => 'student@nextunity.edu.vn';

  @override
  String get profileAccountSection => 'Tài khoản';

  @override
  String get profileNotifications => 'Thông báo';

  @override
  String get profileAbout => 'Về ứng dụng NextUnity';

  @override
  String get errorNetwork => 'Không có kết nối mạng. Vui lòng thử lại.';

  @override
  String get errorServer => 'Lỗi máy chủ. Vui lòng thử lại sau.';

  @override
  String get errorData => 'Dữ liệu không hợp lệ.';

  @override
  String get errorCache => 'Không thể đọc dữ liệu cục bộ.';

  @override
  String get errorUnknown => 'Đã xảy ra lỗi không xác định.';

  @override
  String get loginTopBarTitle => 'Đăng nhập';

  @override
  String get loginEmailTitle => 'Nhập email để tiếp tục';

  @override
  String get loginEmailSubtitle =>
      'Đăng nhập để lưu tiến độ học tập và trải nghiệm đầy đủ tính năng.';

  @override
  String get emailRequired => 'Vui lòng nhập địa chỉ email.';

  @override
  String get continueButton => 'Tiếp tục';

  @override
  String get orDivider => 'hoặc';

  @override
  String get continueWithGoogle => 'Tiếp tục với Google';

  @override
  String get otpVerificationTitle => 'Xác nhận mã OTP';

  @override
  String otpSentToMessage(String email) {
    return 'Nhập mã OTP được gửi tới $email';
  }

  @override
  String get changeEmail => 'Đổi email';

  @override
  String resendOtpIn(int seconds) {
    return 'Gửi lại mã OTP (${seconds}s)';
  }

  @override
  String get resendOtpNow => 'Gửi lại mã OTP';

  @override
  String get otpInvalidLength => 'Vui lòng nhập đủ 6 chữ số mã OTP.';

  @override
  String get profileTitle => 'Hồ sơ cá nhân';

  @override
  String get editProfileTitle => 'Chỉnh sửa thông tin';

  @override
  String get saveChanges => 'Lưu thay đổi';

  @override
  String get upgradePlus => 'Nâng cấp gói Plus';

  @override
  String get dailyStreak => 'Chuỗi ngày học';

  @override
  String get rewardPoints => 'Điểm thưởng';
}
