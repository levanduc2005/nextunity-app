import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';

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

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showBack = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  final List<FlashcardItem> _cards = const [
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

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_showBack) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() {
      _showBack = !_showBack;
    });
  }

  void _nextCard() {
    if (_currentIndex < _cards.length - 1) {
      if (_showBack) {
        _flipController.reverse();
        _showBack = false;
      }
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _prevCard() {
    if (_currentIndex > 0) {
      if (_showBack) {
        _flipController.reverse();
        _showBack = false;
      }
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentIndex + 1) / _cards.length;
    final card = _cards[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          color: const Color(0xFF0F172A),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Thẻ ghi nhớ Flashcards',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Tiến trình lướt thẻ
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 6, 24, 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thẻ ${_currentIndex + 1}/${_cards.length}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}% hoàn thành',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Thẻ lật 3D phong cách ApSkil
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: GestureDetector(
                onTap: _flipCard,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    final angle = _flipAnimation.value * math.pi;
                    final isUnder = angle > (math.pi / 2);

                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(angle),
                      alignment: Alignment.center,
                      child: isUnder
                          ? Transform(
                              transform: Matrix4.identity()..rotateY(math.pi),
                              alignment: Alignment.center,
                              child: _buildBackCard(card),
                            )
                          : _buildFrontCard(card),
                    );
                  },
                ),
              ),
            ),
          ),

          // 3. Đánh giá mức độ ghi nhớ (ApSkil Pill Buttons)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildMemoryFeedbackButton(
                    label: 'Cần ôn lại',
                    color: const Color(0xFFEA580C),
                    bgColor: const Color(0xFFFFF7ED),
                    onTap: _nextCard,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMemoryFeedbackButton(
                    label: 'Tương đối nhớ',
                    color: const Color(0xFF2563EB),
                    bgColor: const Color(0xFFEFF6FF),
                    onTap: _nextCard,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMemoryFeedbackButton(
                    label: 'Đã thuộc',
                    color: const Color(0xFF166534),
                    bgColor: const Color(0xFFDCFCE7),
                    onTap: _nextCard,
                  ),
                ),
              ],
            ),
          ),

          // 4. Thanh điều hướng trước/sau
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _currentIndex > 0 ? _prevCard : null,
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: const Color(0xFF475569),
                    tooltip: 'Thẻ trước',
                  ),
                  TextButton.icon(
                    onPressed: _flipCard,
                    icon: const Icon(
                      Icons.flip_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    label: const Text(
                      'Lật thẻ để xem giải thích',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _currentIndex < _cards.length - 1
                        ? _nextCard
                        : null,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    color: const Color(0xFF475569),
                    tooltip: 'Thẻ sau',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontCard(FlashcardItem card) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              card.topic,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF166534),
                letterSpacing: 0.5,
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.help_outline_rounded,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  card.frontTerm,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.touch_app_outlined,
                  size: 14,
                  color: Color(0xFF94A3B8),
                ),
                SizedBox(width: 4),
                Text(
                  'Chạm vào thẻ để lật xem lời giải',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(FlashcardItem card) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFBBF7D0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'ĐÁP ÁN & ĐỊNH NGHĨA',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            card.backDefinition,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Color(0xFFD97706),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    card.example,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF475569),
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Center(
            child: Text(
              'Chạm để quay lại thuật ngữ',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF166534),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryFeedbackButton({
    required String label,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
