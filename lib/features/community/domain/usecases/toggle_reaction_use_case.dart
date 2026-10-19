import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class TogglePostReactionUseCase {
  const TogglePostReactionUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<void>> call(
    String postId, {
    ReactionType reactionType = ReactionType.like,
  }) => _repository.togglePostReaction(postId, reactionType: reactionType);
}

class ToggleCommentReactionUseCase {
  const ToggleCommentReactionUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<void>> call(
    String commentId, {
    ReactionType reactionType = ReactionType.like,
  }) => _repository.toggleCommentReaction(commentId, reactionType: reactionType);
}
