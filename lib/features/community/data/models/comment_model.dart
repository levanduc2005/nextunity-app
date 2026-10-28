import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
abstract class CommentModel with _$CommentModel {
  const factory CommentModel({
    required String id,
    required String postId,
    String? authorId,
    required String authorName,
    String? authorAvatar,
    required String content,
    String? parentId,
    @Default(0) int reactionCount,
    Map<String, dynamic>? reactionDetails,
    String? currentUserReaction,
    @Default([]) List<CommentModel> replies,
    String? createdAt,
  }) = _CommentModel;

  const CommentModel._();

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  CommentEntity toEntity() {
    final details = <ReactionType, int>{};
    if (reactionDetails != null) {
      reactionDetails!.forEach((key, val) {
        final type = ReactionType.fromString(key);
        if (type != null && val is num) {
          details[type] = val.toInt();
        }
      });
    }

    final userReaction = ReactionType.fromString(currentUserReaction);

    return CommentEntity(
      id: id,
      postId: postId,
      authorId: authorId,
      authorName: authorName,
      authorAvatar: authorAvatar,
      content: content,
      parentId: parentId,
      reactionCount: reactionCount,
      reactionDetails: details,
      currentUserReaction: userReaction,
      isLiked: userReaction != null,
      replies: replies.map((r) => r.toEntity()).toList(),
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    );
  }
}
