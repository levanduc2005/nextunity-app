# NextUnity Mobile App

<p align="center">
  <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=1200&q=80" alt="NextUnity App Banner" width="100%" height="280" style="border-radius: 12px; object-fit: cover;" />
</p>

<p align="center">
  <b>Nền tảng Ứng dụng Di động Học tập Trực tuyến & Cộng đồng Học thuật Sinh viên FPT</b><br/>
  Xây dựng trên nền tảng <b>Flutter</b> với kiến trúc <b>Clean Architecture</b>, <b>Riverpod</b> và bộ giao diện hiện đại chuẩn Material 3.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.11+-02569B?logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.11+-0175C2?logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/State-Riverpod_3.3-blueviolet" alt="Riverpod" />
  <img src="https://img.shields.io/badge/Routing-go__router-informational" alt="GoRouter" />
  <img src="https://img.shields.io/badge/Architecture-Clean_Architecture-success" alt="Clean Architecture" />
  <img src="https://img.shields.io/badge/Tests-100%25_Passed-brightgreen" alt="Tests" />
</p>

---

## ✨ Điểm Nhấn Tính Năng (Key Features)

### 1. Trải Nghiệm Học Tập Chuyên Sâu (Course & Lesson Experience)
- **Course Detail Screen**: Thiết kế màn hình đơn liền mạch (Single-page Layout) với thanh cuộn Sliver Hero Header, Tab Header ghim mượt mà, phân tách rõ ràng khối **Giới thiệu môn học (About)** và **Đề cương bài giảng (Syllabus)**.
- **Cinema Video Player**: Trình phát video bài giảng YouTube nhúng tỉ lệ chuẩn điện ảnh 16:9, loại bỏ hoàn toàn các khung viền rườm rà.
- **Modern IDE Code Block (Mới)**:
  - Tích hợp khối hiển thị mã nguồn chuẩn giao diện macOS/VS Code.
  - Tự động tô màu cú pháp (Syntax Highlighting) cho C, Java, SQL, Python... với hiệu năng cao, zero-dependency.
  - Nút **"Sao chép" 1-chạm** tiện lợi kèm phản hồi thị giác ("Đã chép").
  - Thanh cuộn ngang (`SingleChildScrollView`) bảo toàn thụt lề chuẩn, không bị ngắt dòng vỡ mã trên màn hình điện thoại.
  - Cột đánh số dòng (Line Numbers) tách biệt, chống loang màu nền.
  - Inline Code dạng pill bo góc tinh tế nằm êm mắt trong dòng văn bản.
- **Lesson Mini TOC Bottom Sheet**: Cho phép xem nhanh toàn bộ cây mục lục các chương và nhảy bài học tức thì.
- **Floating Bottom Bar**: Thanh điều hướng nổi dạng capsule tinh gọn hỗ trợ chuyển bài trước/sau và đánh dấu hoàn thành bài học.

### 2. Trắc Nghiệm Ôn Luyện Kỳ Thi PE/FE (Quiz & Assessment Engine)
- Giao diện làm bài trắc nghiệm thông minh với thời gian đếm ngược.
- Chấm điểm tức thì kèm hộp thông báo kết quả (Passed/Failed) trực quan.
- Xem lại đáp án chi tiết và làm lại bài thi không giới hạn.

### 3. Diễn Đàn Thảo Luận FPTU (Community & Social Learning)
- Bảng tin (Feed) cập nhật các bài chia sẻ kinh nghiệm ôn thi PE điểm cao, đồ án SWP391 và phỏng vấn OJT.
- Bộ lọc Chip thông minh theo thẻ môn học: `PE`, `PRF192`, `PRO192`, `CSD201`, `DBI202`, `PRJ301`, `SWP391`, `OJT_INTERNSHIP`, `TAI_LIEU`.
- Thả cảm xúc phong phú (`LIKE`, `LOVE`, `WOW`, `HAHA`, `SAD`, `ANGRY`).
- Bình luận đa cấp (Nested Comments & Replies) trao đổi trực tiếp với Giảng viên và Mentor.
- Đăng bài viết nhanh kèm chọn tags trực quan.

### 4. Gói Nâng Cấp PLUS & Thanh Toán Tự Động (Subscription & VietQR)
- Giới thiệu quyền lợi hội viên NextUnity PLUS (mở khóa toàn bộ ngân hàng đề thi PE và bài giảng VIP).
- Tích hợp tạo mã QR thanh toán ngân hàng tự động **VietQR**, hỗ trợ quét mã chuyển khoản nhanh chóng và tự động kiểm tra trạng thái thanh toán.

### 5. Quản Lý Hồ Sơ & Chuỗi Học Tập (Profile & Streak)
- Thống kê chuỗi ngày học tập liên tục (Learning Streak) tạo động lực học tập mỗi ngày.
- Quản lý danh sách khóa học đã đăng ký và tiến độ hoàn thành.
- Đổi mật khẩu, cài đặt tài khoản an toàn với `flutter_secure_storage`.

---

## 🏛️ Kiến Trúc Ứng Dụng (Architecture)

Ứng dụng tuân thủ nghiêm ngặt **Clean Architecture** kết hợp phân rã theo tính năng (**Feature-First Structure**):

```text
lib/
├── core/                              # Nền tảng dùng chung toàn app
│   ├── config/                        # Cấu hình môi trường (API base URL, timeout)
│   ├── network/                       # Dio client, Interceptors, Token Refresh
│   ├── storage/                       # SharedPreferences, FlutterSecureStorage
│   ├── theme/                         # AppColors, AppTheme, Typography Material 3
│   └── widgets/                       # Shared UI components (Buttons, Inputs, Cards)
│
├── features/                          # Các phân hệ tính năng độc lập
│   ├── auth/                          # Đăng nhập, Đăng ký, Quên mật khẩu, Google Sign-In
│   ├── home/                          # Dashboard trang chủ, Banner, Quick Stats
│   ├── course/                        # Khóa học, Chương mục, Bài học, Markdown Reader
│   ├── quiz/                          # Trắc nghiệm, Câu hỏi, Bảng điểm
│   ├── community/                     # Diễn đàn, Bài viết, Bình luận, Tương tác
│   ├── payment/                       # Nâng cấp gói PLUS, VietQR helper
│   ├── profile/                       # Thông tin cá nhân, Streak, Cài đặt
│   └── shell/                         # Khung Scaffold Bottom Navigation Bar
│
└── main.dart                          # Điểm khởi chạy ứng dụng (Bootstrap)
```

### Mỗi Feature được chia làm 3 lớp chuẩn:
1. **`data/`**: Models (Freezed/JSON), DataSources (Remote API), Repositories Implementation.
2. **`domain/`**: Entities độc lập, Repository Interfaces, UseCases nghiệp vụ.
3. **`presentation/`**: Controllers/StateNotifier (Riverpod), Pages, Widgets con.

---

## 🧱 Công Nghệ & Thư Viện Chính (Tech Stack)

| Hạng mục | Thư viện | Phiên bản | Mục đích |
| :--- | :--- | :--- | :--- |
| **Framework** | Flutter SDK | `^3.11.0` | Nền tảng phát triển ứng dụng di động đa nền tảng |
| **Quản lý State** | `flutter_riverpod` | `^3.3.2` | State Management bất biến, Dependency Injection an toàn |
| **Điều hướng** | `go_router` | `^17.3.0` | Định tuyến khai báo (Declarative Routing), bảo vệ Auth Guard |
| **Kết nối mạng** | `dio` | `^5.11.0` | HTTP Client, tự động gắn Bearer Token & bắt lỗi mạng |
| **Mã nguồn bất biến**| `freezed_annotation`, `json_annotation` | `^3.1.0` | Sinh code Entity/Model tự động, an toàn kiểu dữ liệu |
| **Trình phát Video** | `youtube_player_iframe`| `^6.0.2` | Phát video YouTube nhúng chuẩn không quảng cáo |
| **Đọc Markdown** | `flutter_markdown` | `^0.7.7` | Hiển thị bài giảng lý thuyết + Custom IDE Code Builder |
| **Lưu trữ an toàn**| `flutter_secure_storage` | `^10.3.1` | Lưu Access Token & Refresh Token được mã hóa |
| **Lưu trữ cục bộ** | `shared_preferences` | `^2.5.5` | Lưu Theme mode, trạng thái ghi nhớ đăng nhập |

---

## 🚀 Hướng Dẫn Cài Đặt & Chạy App (Getting Started)

### 1. Yêu Cầu Môi Trường (Prerequisites)
- **Flutter SDK**: Phiên bản `>= 3.11.0`
- **Dart SDK**: Phiên bản `>= 3.11.0`
- **Android Studio** hoặc **VS Code** có cài đặt Flutter Extension.
- Thiết bị thật hoặc máy ảo Android (API level 24 trở lên) / iOS Simulator.

### 2. Cài Đặt Dependencies
Mở terminal tại thư mục `NextUnity_App` và chạy:

```powershell
flutter pub get
```

### 3. Sinh Mã Nguồn Tự Động (Code Generation - Nếu cần)
Nếu có thay đổi về Model Freezed hoặc JSON Serializable:
```powershell
dart run build_runner build --delete-conflicting-outputs
```

### 4. Khởi Chạy Ứng Dụng (Run Debug Mode)
Đảm bảo Backend `NextUnity_BE` đang chạy tại `http://localhost:8000` (hoặc cấu hình địa chỉ IP máy của bạn trong `core/config`):

```powershell
flutter run
```

---

## 🧪 Kiểm Thử Tự Động (Automated Testing)

Dự án sở hữu bộ test toàn diện kiểm tra logic nghiệp vụ, giao diện và đảm bảo không xảy ra hiện tượng tràn viền (overflow) trên các kích thước màn hình hẹp (từ 320px đến 390px):

```powershell
# Chạy toàn bộ bộ test kiểm tra giao diện bài học và chống tràn viền
flutter test test/features/course/course_ui_test.dart test/features/course/lesson_markdown_reader_test.dart test/overflow_test.dart
```

*Kết quả:* **20 / 20 tests passed (100% Pass)**.

---

## 📦 Hướng Dẫn Đóng Gói Bản Phát Hành (Build Release for Google Play)

Ứng dụng đã được tích hợp sẵn Release Keystore trong [`android/key.properties`](file:///e:/Workspace/Mon_Hoc_FPT/EXE/NextUnity_App/android/key.properties).

Để build file **Android App Bundle (.aab)** tải lên Google Play Console (CH Play):

```powershell
# Dọn dẹp cache cũ
flutter clean
flutter pub get

# Build file AAB với Version Code tăng dần
flutter build appbundle --release --build-name=1.1.1 --build-number=4
```

File sau khi build xong sẽ nằm tại:
👉 `build/app/outputs/bundle/release/app-release.aab`

---

## 👥 Nhóm Phát Triển (Authors)
Dự án được xây dựng bởi nhóm sinh viên Kỹ thuật Phần mềm (Software Engineering) - Đại học FPT.
