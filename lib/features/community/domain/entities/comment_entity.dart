import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/core/utils/date_time_formatter.dart';
import 'package:rental_car/core/utils/string_utils.dart';

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
    @Default([]) List<CommentEntity> replies,
    DateTime? createdAt,
    @Default(false) bool isLiked,
  }) = _CommentEntity;

  const CommentEntity._();

  String get initials => StringUtils.getInitials(authorName, fallback: 'U');

  String get formattedTime =>
      createdAt.toRelativeTime(includeSuffix: false, includeYear: false);
}
