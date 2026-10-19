// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  authorId: json['authorId'] as String?,
  authorName: json['authorName'] as String?,
  authorAvatar: json['authorAvatar'] as String?,
  authorUniversity: json['authorUniversity'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  reactionCount: (json['reactionCount'] as num?)?.toInt() ?? 0,
  reactionDetails: json['reactionDetails'] as Map<String, dynamic>?,
  currentUserReaction: json['currentUserReaction'] as String?,
  commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'authorUniversity': instance.authorUniversity,
      'tags': instance.tags,
      'reactionCount': instance.reactionCount,
      'reactionDetails': instance.reactionDetails,
      'currentUserReaction': instance.currentUserReaction,
      'commentCount': instance.commentCount,
      'createdAt': instance.createdAt,
    };
