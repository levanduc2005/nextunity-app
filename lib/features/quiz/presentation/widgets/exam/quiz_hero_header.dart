import 'package:flutter/material.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_progress_bar.dart';

/// Phần Header Hero trên nền gradient xanh của màn hình làm bài kiểm tra
class QuizHeroHeader extends StatelessWidget {
  const QuizHeroHeader({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.totalQuestions,
    required this.answeredCount,
    required this.onExit,
  });

  final String title;
  final int currentIndex;
  final int totalQuestions;
  final int answeredCount;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              InkWell(
                onTap: onExit,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          QuizProgressBar(
            currentIndex: currentIndex,
            totalQuestions: totalQuestions,
            answeredCount: answeredCount,
          ),
        ],
      ),
    );
  }
}
