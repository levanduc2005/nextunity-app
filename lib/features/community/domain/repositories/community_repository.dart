import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/comment_reaction_result.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/post_reaction_result.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

abstract interface class CommunityRepository {
  Future<Result<List<PostEntity>>> getAllPosts();

  Future<Result<PostEntity>> getPostById(String id);

  Future<Result<PostEntity>> createPost({
    required String title,
    required String content,
    List<String>? tags,
  });

  Future<Result<List<CommentEntity>>> getCommentsByPostId(String postId);

  Future<Result<CommentEntity>> createComment({
    required String postId,
    required String content,
    String? parentId,
  });

  Future<Result<PostReactionResult>> togglePostReaction(
    String postId, {
    ReactionType reactionType = ReactionType.like,
  });

  Future<Result<CommentReactionResult>> toggleCommentReaction(
    String commentId, {
    ReactionType reactionType = ReactionType.like,
  });

  Future<Result<List<String>>> getTags();

  Future<Result<void>> deletePost(String id);

  Future<Result<void>> deleteComment(String id);
}
