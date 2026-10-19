import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/core/utils/date_time_formatter.dart';
import 'package:rental_car/core/utils/string_utils.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

part 'comment_entity.freezed.dart';

/// Entity biểu diễn bình luận trong bài viết cộng đồng (Freezed immutable model)
@freezed
abstract class CommentEntity with _$CommentEntity {
  const factory CommentEntity({
    required String id,
    required String postId,
    required String authorName,
    required String content,
    String? authorId,
    String? authorAvatar,
    String? authorBadge,
    String? parentId,
    @Default(0) int reactionCount,
    @Default({}) Map<ReactionType, int> reactionDetails,
    ReactionType? currentUserReaction,
    @Default([]) List<CommentEntity> replies,
    DateTime? createdAt,
    @Default(false) bool isLiked,
  }) = _CommentEntity;

  const CommentEntity._();

  String get initials => StringUtils.getInitials(authorName, fallback: 'U');

  String get formattedTime =>
      createdAt.toRelativeTime(includeSuffix: false, includeYear: false);

  /// Trả về tối đa 2 loại cảm xúc có số lượng cao nhất (chuẩn Facebook)
  List<ReactionType> get topReactions {
    if (reactionDetails.isEmpty) {
      if (currentUserReaction != null && reactionCount > 0) {
        return [currentUserReaction!];
      }
      return reactionCount > 0 ? [ReactionType.like] : [];
    }
    final entries = reactionDetails.entries.where((e) => e.value > 0).toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    if (entries.isEmpty) {
      if (currentUserReaction != null && reactionCount > 0) {
        return [currentUserReaction!];
      }
      return reactionCount > 0 ? [ReactionType.like] : [];
    }
    return entries.take(2).map((e) => e.key).toList();
  }
}
