import 'package:flutter/material.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_option_tile.dart';
import 'package:rental_car/features/quiz/presentation/widgets/exam/quiz_question_card.dart';

/// Khung hiển thị câu hỏi và các lựa chọn đáp án trắc nghiệm
class QuizQuestionView extends StatelessWidget {
  const QuizQuestionView({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.selectedOptionIds,
    required this.onSelectOption,
  });

  final int questionNumber;
  final QuizQuestionEntity question;
  final List<String> selectedOptionIds;
  final void Function(String optionId, bool isMultiChoice) onSelectOption;

  @override
  Widget build(BuildContext context) {
    final isMultiChoice = question.type == 'MULTIPLE_CHOICE';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          QuizQuestionCard(
            questionNumber: questionNumber,
            content: question.content,
            isMultiChoice: isMultiChoice,
          ),
          const SizedBox(height: 22),
          ...question.options.map((option) {
            return QuizOptionTile(
              content: option.content,
              isSelected: selectedOptionIds.contains(option.id),
              isMultiChoice: isMultiChoice,
              onTap: () => onSelectOption(option.id, isMultiChoice),
            );
          }),
        ],
      ),
    );
  }
}
