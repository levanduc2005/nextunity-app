import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
abstract class PostModel with _$PostModel {
  const factory PostModel({
    required String id,
    required String title,
    required String content,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    String? authorUniversity,
    @Default([]) List<String> tags,
    @Default(0) int reactionCount,
    Map<String, dynamic>? reactionDetails,
    String? currentUserReaction,
    @Default(0) int commentCount,
    String? createdAt,
  }) = _PostModel;

  const PostModel._();

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  PostEntity toEntity() {
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

    return PostEntity(
      id: id,
      title: title,
      content: content,
      authorId: authorId,
      authorName: authorName,
      authorAvatar: authorAvatar,
      authorUniversity: authorUniversity,
      tags: tags,
      reactionCount: reactionCount,
      reactionDetails: details,
      currentUserReaction: userReaction,
      commentCount: commentCount,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    );
  }
}
