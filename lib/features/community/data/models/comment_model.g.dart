// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      id: json['id'] as String,
      postId: json['postId'] as String,
      authorId: json['authorId'] as String?,
      authorName: json['authorName'] as String,
      authorAvatar: json['authorAvatar'] as String?,
      content: json['content'] as String,
      parentId: json['parentId'] as String?,
      reactionCount: (json['reactionCount'] as num?)?.toInt() ?? 0,
      reactionDetails: json['reactionDetails'] as Map<String, dynamic>?,
      currentUserReaction: json['currentUserReaction'] as String?,
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$CommentModelToJson(_CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'content': instance.content,
      'parentId': instance.parentId,
      'reactionCount': instance.reactionCount,
      'reactionDetails': instance.reactionDetails,
      'currentUserReaction': instance.currentUserReaction,
      'replies': instance.replies,
      'createdAt': instance.createdAt,
    };
