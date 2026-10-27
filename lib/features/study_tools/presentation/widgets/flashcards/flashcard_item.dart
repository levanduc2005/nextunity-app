/// Đối tượng dữ liệu một thẻ ghi nhớ Flashcard
class FlashcardItem {
  const FlashcardItem({
    required this.id,
    required this.topic,
    required this.frontTerm,
    required this.backDefinition,
    required this.example,
  });

  final String id;
  final String topic;
  final String frontTerm;
  final String backDefinition;
  final String example;
}

/// Dữ liệu mẫu flashcards lập trình Flutter & Clean Architecture
const List<FlashcardItem> kDefaultFlashcards = [
  FlashcardItem(
    id: 'fc1',
    topic: 'FLUTTER ARCHITECTURE',
    frontTerm: 'Dependency Inversion Principle (DIP)',
    backDefinition:
        'Nguyên lý đảo ngược phụ thuộc: Các module cấp cao không nên phụ thuộc trực tiếp vào module cấp thấp. Cả hai nên phụ thuộc vào abstractions (Interface).',
    example: 'Domain Repository Interface ← Data Repository Implementation',
  ),
  FlashcardItem(
    id: 'fc2',
    topic: 'STATE MANAGEMENT',
    frontTerm: 'AsyncNotifierProvider',
    backDefinition:
        'Provider trong Riverpod được tối ưu cho việc quản lý trạng thái bất đồng bộ (Loading, Data, Error) với cơ chế tự hủy và bảo đảm an toàn luồng.',
    example:
        'Dùng cho: Tải danh sách khóa học, nộp bài quiz, cập nhật tiến độ học tập.',
  ),
  FlashcardItem(
    id: 'fc3',
    topic: 'DART & FLUTTER CORE',
    frontTerm: 'Immutability (@freezed)',
    backDefinition:
        'Bất biến: Một object khi đã khởi tạo thì không thể thay đổi giá trị thuộc tính. Giúp code không bị side-effect, dễ debug và so sánh giá trị.',
    example: 'final updated = user.copyWith(isPlus: true);',
  ),
  FlashcardItem(
    id: 'fc4',
    topic: 'FLUTTER PERFORMANCE',
    frontTerm: 'const Constructor',
    backDefinition:
        'Khai báo widget là const giúp Flutter tái sử dụng instance trong bộ nhớ và bỏ qua việc rebuild subtree không đổi khi cha rebuild.',
    example: 'const SizedBox(height: 16);',
  ),
  FlashcardItem(
    id: 'fc5',
    topic: 'CLEAN ARCHITECTURE',
    frontTerm: 'Domain Layer Isolation',
    backDefinition:
        'Tầng Domain tuyệt đối không chứa import của Flutter, Dio hay SQLite. Chỉ gồm Entities, UseCases và Repository Interfaces thuần Dart.',
    example: 'Cho phép kiểm thử unit test thuần túy không cần mock platform.',
  ),
];
