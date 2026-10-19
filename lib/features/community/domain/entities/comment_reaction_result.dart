import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

/// Kết quả phản hồi sau khi tương tác cảm xúc bình luận từ Backend API
class CommentReactionResult {
  const CommentReactionResult({
    required this.commentId,
    this.currentUserReaction,
    required this.totalReactions,
    this.reactionDetails = const {},
  });

  final String commentId;
  final ReactionType? currentUserReaction;
  final int totalReactions;
  final Map<ReactionType, int> reactionDetails;
}
