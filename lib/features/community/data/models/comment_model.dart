import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';

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
    String? authorBadge,
    required String content,
    String? parentId,
    @Default(0) int reactionCount,
    @Default([]) List<CommentModel> replies,
    String? createdAt,
  }) = _CommentModel;

  const CommentModel._();

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  CommentEntity toEntity() => CommentEntity(
    id: id,
    postId: postId,
    authorId: authorId,
    authorName: authorName,
    authorAvatar: authorAvatar,
    authorBadge: authorBadge,
    content: content,
    parentId: parentId,
    reactionCount: reactionCount,
    replies: replies.map((r) => r.toEntity()).toList(),
    createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
  );
}
