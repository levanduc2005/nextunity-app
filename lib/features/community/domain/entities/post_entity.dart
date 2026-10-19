import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/core/utils/date_time_formatter.dart';
import 'package:rental_car/core/utils/string_utils.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

part 'post_entity.freezed.dart';

@freezed
abstract class PostEntity with _$PostEntity {
  const factory PostEntity({
    required String id,
    required String title,
    required String content,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    String? authorUniversity,
    @Default([]) List<String> tags,
    @Default(0) int reactionCount,
    @Default({}) Map<ReactionType, int> reactionDetails,
    ReactionType? currentUserReaction,
    @Default(0) int commentCount,
    DateTime? createdAt,
  }) = _PostEntity;

  const PostEntity._();

  String get displayAuthor => authorName?.trim().isNotEmpty == true
      ? authorName!
      : 'Thành viên ẩn danh';

  String get initials => StringUtils.getInitials(displayAuthor);

  String get primaryTag =>
      StringUtils.formatHashtag(tags.isNotEmpty ? tags.first : null);

  String get formattedTime => createdAt.toRelativeTime();

  List<ReactionType> get topReactions {
    if (reactionDetails.isEmpty) return const [];
    final sorted = reactionDetails.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(2).map((e) => e.key).toList();
  }
}
