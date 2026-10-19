import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';

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
    @Default(0) int commentCount,
    String? createdAt,
  }) = _PostModel;

  const PostModel._();

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  PostEntity toEntity() => PostEntity(
    id: id,
    title: title,
    content: content,
    authorId: authorId,
    authorName: authorName,
    authorAvatar: authorAvatar,
    authorUniversity: authorUniversity,
    tags: tags,
    reactionCount: reactionCount,
    commentCount: commentCount,
    createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
  );
}
