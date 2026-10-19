import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

class PostReactionResult {
  const PostReactionResult({
    required this.postId,
    this.currentUserReaction,
    required this.totalReactions,
    required this.reactionDetails,
  });

  final String postId;
  final ReactionType? currentUserReaction;
  final int totalReactions;
  final Map<ReactionType, int> reactionDetails;
}
