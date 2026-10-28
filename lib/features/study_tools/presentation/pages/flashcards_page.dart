import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/study_tools/presentation/widgets/flashcards/flashcard_flip_view.dart';
import 'package:rental_car/features/study_tools/presentation/widgets/flashcards/flashcard_item.dart';
import 'package:rental_car/features/study_tools/presentation/widgets/flashcards/flashcard_memory_feedback_bar.dart';
import 'package:rental_car/features/study_tools/presentation/widgets/flashcards/flashcard_navigation_bar.dart';
import 'package:rental_car/features/study_tools/presentation/widgets/flashcards/flashcard_progress_header.dart';

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

  final List<FlashcardItem> _cards = kDefaultFlashcards;

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
    final card = _cards[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          color: AppColors.textPrimary,
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Thẻ ghi nhớ Flashcards',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Tiến trình lướt thẻ
          FlashcardProgressHeader(
            currentIndex: _currentIndex,
            totalCards: _cards.length,
          ),

          // 2. Thẻ lật 3D phong cách ApSkil
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: FlashcardFlipView(
                card: card,
                flipAnimation: _flipAnimation,
                onFlip: _flipCard,
              ),
            ),
          ),

          // 3. Đánh giá mức độ ghi nhớ (ApSkil Pill Buttons)
          FlashcardMemoryFeedbackBar(onFeedback: _nextCard),

          // 4. Thanh điều hướng trước/sau
          FlashcardNavigationBar(
            hasPrevious: _currentIndex > 0,
            hasNext: _currentIndex < _cards.length - 1,
            onPrevious: _prevCard,
            onNext: _nextCard,
            onFlip: _flipCard,
          ),
        ],
      ),
    );
  }
}
