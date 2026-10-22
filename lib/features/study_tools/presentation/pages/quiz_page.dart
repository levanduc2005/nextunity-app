import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {};
  bool _isSubmitted = false;

  final List<QuizQuestion> _questions = const [
    QuizQuestion(
      id: 'q1',
      question:
          'Trong Flutter, widget nào được sử dụng để xếp chồng các widget con lên nhau theo chiều sâu (Z-axis)?',
      options: ['Column', 'Row', 'Stack', 'Wrap'],
      correctIndex: 2,
      explanation:
          'Stack cho phép các widget con xếp chồng lên nhau tương tự như absolute positioning trong CSS.',
    ),
    QuizQuestion(
      id: 'q2',
      question:
          'Khái niệm "StatefulWidget" trong Flutter khác với "StatelessWidget" ở điểm nào?',
      options:
          [
            'Có thể tự động thay đổi giao diện theo thời gian hoặc tương tác',
            'Chỉ dùng để hiển thị text tĩnh không thay đổi',
            'Không cần hàm build để vẽ giao diện',
            'Bắt buộc phải kết hợp với cơ sở dữ liệu SQLite',
          ],
      correctIndex: 0,
      explanation:
          'StatefulWidget có thể quản lý trạng thái động và gọi setState() để kích hoạt rebuild giao diện.',
    ),
    QuizQuestion(
      id: 'q3',
      question:
          'Trong Clean Architecture của Flutter, tầng Domain KHÔNG ĐƯỢC phép phụ thuộc vào tầng nào?',
      options: [
        'Cả Data layer và Presentation layer',
        'Chỉ Presentation layer',
        'Chỉ Data layer',
        'Core layer',
      ],
      correctIndex: 0,
      explanation:
          'Tầng Domain là trái tim của ứng dụng, chỉ chứa business logic độc lập, không phụ thuộc vào Data, Presentation hay Flutter framework.',
    ),
    QuizQuestion(
      id: 'q4',
      question:
          'Phương thức nào được gọi đúng một lần khi một State object được chèn vào cây widget?',
      options: [
        'build()',
        'initState()',
        'didUpdateWidget()',
        'dispose()',
      ],
      correctIndex: 1,
      explanation:
          'initState() được Flutter framework gọi duy nhất một lần khi đối tượng State được tạo.',
    ),
    QuizQuestion(
      id: 'q5',
      question:
          'Để quản lý state toàn cục hiệu quả, an toàn kiểu và không cần BuildContext trong controller, package nào thường được tin dùng?',
      options: ['Riverpod', 'SetState', 'SharedPreferences', 'Dio'],
      correctIndex: 0,
      explanation:
          'Riverpod cung cấp compile-time safety, linh hoạt và không phụ thuộc vào BuildContext của widget tree.',
    ),
  ];

  void _selectOption(int optionIndex) {
    if (_isSubmitted) return;
    setState(() {
      _selectedAnswers[_currentIndex] = optionIndex;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _submitQuiz();
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _submitQuiz() {
    setState(() {
      _isSubmitted = true;
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _selectedAnswers.clear();
      _isSubmitted = false;
    });
  }

  int get _correctCount {
    var count = 0;
    for (var i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i].correctIndex) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          _isSubmitted ? 'Kết quả ôn tập' : 'Luyện tập Trắc nghiệm',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        centerTitle: true,
        actions: [
          if (!_isSubmitted)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '15:00',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF166534),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: _isSubmitted ? _buildResultView() : _buildQuizView(),
    );
  }

  Widget _buildQuizView() {
    final question = _questions[_currentIndex];
    final selectedOption = _selectedAnswers[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Column(
      children: [
        // 1. Thanh tiến trình phía trên chuẩn ApSkil
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Câu ${_currentIndex + 1}/${_questions.length}',
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
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ],
          ),
        ),

        // 2. Nội dung câu hỏi và các lựa chọn đáp án
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Thẻ câu hỏi
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color(0xFF0F172A).withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3.5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'CÂU HỎI TRẮC NGHIỆM',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF166534),
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Danh sách các lựa chọn đáp án A, B, C, D
                ...List.generate(question.options.length, (idx) {
                  final isSelected = selectedOption == idx;
                  final optionLabels = ['A', 'B', 'C', 'D'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => _selectOption(idx),
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFF0FDF4)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : const Color(0xFFE2E8F0),
                            width: isSelected ? 1.8 : 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.08)
                                  : const Color(0xFF0F172A).withValues(
                                      alpha: 0.03,
                                    ),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Huy hiệu chữ cái A, B, C, D
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? AppColors.primary
                                    : const Color(0xFFF1F5F9),
                              ),
                              child: Center(
                                child: Text(
                                  optionLabels[idx],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            // Nội dung đáp án
                            Expanded(
                              child: Text(
                                question.options[idx],
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xFF166534)
                                      : const Color(0xFF1E293B),
                                  height: 1.35,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        // 3. Thanh điều hướng câu hỏi dưới đáy màn hình
        SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(
                top: BorderSide(color: Color(0xFFE2E8F0)),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.05),
                  blurRadius: 14,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Nút quay lại câu trước
                if (_currentIndex > 0)
                  InkWell(
                    onTap: _previousQuestion,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 13,
                              color: Color(0xFF475569),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Câu trước',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (_currentIndex > 0) const SizedBox(width: 10),

                // Nút câu tiếp theo / nộp bài
                Expanded(
                  child: InkWell(
                    onTap: selectedOption != null ? _nextQuestion : null,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: selectedOption != null
                            ? AppColors.primary
                            : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: selectedOption != null
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentIndex < _questions.length - 1
                                  ? 'Câu tiếp theo'
                                  : 'Nộp bài & Xem kết quả',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: selectedOption != null
                                    ? Colors.white
                                    : const Color(0xFF94A3B8),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              _currentIndex < _questions.length - 1
                                  ? Icons.arrow_forward_rounded
                                  : Icons.check_circle_outline_rounded,
                              size: 16,
                              color: selectedOption != null
                                  ? Colors.white
                                  : const Color(0xFF94A3B8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Màn hình tổng kết điểm với vòng tròn phần trăm chuẩn ApSkil
  Widget _buildResultView() {
    final score = (_correctCount / _questions.length * 100).round();
    final isPassed = score >= 80;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Thẻ điểm số chính với vòng tròn Circular Indicator
          Container(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                // Vòng tròn điểm số phần trăm lớn màu xanh lá ApSkil
                SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: CircularProgressIndicator(
                          value: score / 100,
                          strokeWidth: 12,
                          backgroundColor: const Color(0xFFDCFCE7),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$score%',
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                              letterSpacing: -1,
                            ),
                          ),
                          Text(
                            isPassed ? 'ĐẠT ĐIỂM CAO' : 'CẦN ÔN TẬP',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              color: isPassed
                                  ? const Color(0xFF166534)
                                  : const Color(0xFFD97706),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  isPassed
                      ? 'Xuất sắc! Bạn đã nắm vững bài học'
                      : 'Bạn đã làm tốt, hãy ôn tập thêm nhé!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Bạn đã trả lời đúng $_correctCount trên tổng số ${_questions.length} câu hỏi.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Thống kê chi tiết
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF166534),
                        size: 24,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$_correctCount câu đúng',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const Text(
                        'Chính xác',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.cancel_rounded,
                        color: Color(0xFFDC2626),
                        size: 24,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${_questions.length - _correctCount} câu sai',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const Text(
                        'Cần xem lại',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Nút hành động
          InkWell(
            onTap: _restartQuiz,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.replay_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Làm lại bài kiểm tra',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => context.pop(),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text(
              'Quay lại khóa học',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
