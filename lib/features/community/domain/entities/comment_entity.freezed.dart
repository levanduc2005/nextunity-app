// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommentEntity {

 String get id; String get postId; String get authorName; String get content; String? get authorId; String? get authorAvatar; String? get authorBadge; String? get parentId; int get reactionCount; List<CommentEntity> get replies; DateTime? get createdAt; bool get isLiked;
/// Create a copy of CommentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentEntityCopyWith<CommentEntity> get copyWith => _$CommentEntityCopyWithImpl<CommentEntity>(this as CommentEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.authorBadge, authorBadge) || other.authorBadge == authorBadge)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.reactionCount, reactionCount) || other.reactionCount == reactionCount)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked));
}


@override
int get hashCode => Object.hash(runtimeType,id,postId,authorName,content,authorId,authorAvatar,authorBadge,parentId,reactionCount,const DeepCollectionEquality().hash(replies),createdAt,isLiked);

@override
String toString() {
  return 'CommentEntity(id: $id, postId: $postId, authorName: $authorName, content: $content, authorId: $authorId, authorAvatar: $authorAvatar, authorBadge: $authorBadge, parentId: $parentId, reactionCount: $reactionCount, replies: $replies, createdAt: $createdAt, isLiked: $isLiked)';
}


}

/// @nodoc
abstract mixin class $CommentEntityCopyWith<$Res>  {
  factory $CommentEntityCopyWith(CommentEntity value, $Res Function(CommentEntity) _then) = _$CommentEntityCopyWithImpl;
@useResult
$Res call({
 String id, String postId, String authorName, String content, String? authorId, String? authorAvatar, String? authorBadge, String? parentId, int reactionCount, List<CommentEntity> replies, DateTime? createdAt, bool isLiked
});




}
/// @nodoc
class _$CommentEntityCopyWithImpl<$Res>
    implements $CommentEntityCopyWith<$Res> {
  _$CommentEntityCopyWithImpl(this._self, this._then);

  final CommentEntity _self;
  final $Res Function(CommentEntity) _then;

/// Create a copy of CommentEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? postId = null,Object? authorName = null,Object? content = null,Object? authorId = freezed,Object? authorAvatar = freezed,Object? authorBadge = freezed,Object? parentId = freezed,Object? reactionCount = null,Object? replies = null,Object? createdAt = freezed,Object? isLiked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,authorBadge: freezed == authorBadge ? _self.authorBadge : authorBadge // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,reactionCount: null == reactionCount ? _self.reactionCount : reactionCount // ignore: cast_nullable_to_non_nullable
as int,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentEntity>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentEntity].
extension CommentEntityPatterns on CommentEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentEntity value)  $default,){
final _that = this;
switch (_that) {
case _CommentEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CommentEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String postId,  String authorName,  String content,  String? authorId,  String? authorAvatar,  String? authorBadge,  String? parentId,  int reactionCount,  List<CommentEntity> replies,  DateTime? createdAt,  bool isLiked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentEntity() when $default != null:
return $default(_that.id,_that.postId,_that.authorName,_that.content,_that.authorId,_that.authorAvatar,_that.authorBadge,_that.parentId,_that.reactionCount,_that.replies,_that.createdAt,_that.isLiked);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String postId,  String authorName,  String content,  String? authorId,  String? authorAvatar,  String? authorBadge,  String? parentId,  int reactionCount,  List<CommentEntity> replies,  DateTime? createdAt,  bool isLiked)  $default,) {final _that = this;
switch (_that) {
case _CommentEntity():
return $default(_that.id,_that.postId,_that.authorName,_that.content,_that.authorId,_that.authorAvatar,_that.authorBadge,_that.parentId,_that.reactionCount,_that.replies,_that.createdAt,_that.isLiked);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String postId,  String authorName,  String content,  String? authorId,  String? authorAvatar,  String? authorBadge,  String? parentId,  int reactionCount,  List<CommentEntity> replies,  DateTime? createdAt,  bool isLiked)?  $default,) {final _that = this;
switch (_that) {
case _CommentEntity() when $default != null:
return $default(_that.id,_that.postId,_that.authorName,_that.content,_that.authorId,_that.authorAvatar,_that.authorBadge,_that.parentId,_that.reactionCount,_that.replies,_that.createdAt,_that.isLiked);case _:
  return null;

}
}

}

/// @nodoc


class _CommentEntity extends CommentEntity {
  const _CommentEntity({required this.id, required this.postId, required this.authorName, required this.content, this.authorId, this.authorAvatar, this.authorBadge, this.parentId, this.reactionCount = 0, final  List<CommentEntity> replies = const [], this.createdAt, this.isLiked = false}): _replies = replies,super._();
  

@override final  String id;
@override final  String postId;
@override final  String authorName;
@override final  String content;
@override final  String? authorId;
@override final  String? authorAvatar;
@override final  String? authorBadge;
@override final  String? parentId;
@override@JsonKey() final  int reactionCount;
 final  List<CommentEntity> _replies;
@override@JsonKey() List<CommentEntity> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override final  DateTime? createdAt;
@override@JsonKey() final  bool isLiked;

/// Create a copy of CommentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentEntityCopyWith<_CommentEntity> get copyWith => __$CommentEntityCopyWithImpl<_CommentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.authorBadge, authorBadge) || other.authorBadge == authorBadge)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.reactionCount, reactionCount) || other.reactionCount == reactionCount)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked));
}


@override
int get hashCode => Object.hash(runtimeType,id,postId,authorName,content,authorId,authorAvatar,authorBadge,parentId,reactionCount,const DeepCollectionEquality().hash(_replies),createdAt,isLiked);

@override
String toString() {
  return 'CommentEntity(id: $id, postId: $postId, authorName: $authorName, content: $content, authorId: $authorId, authorAvatar: $authorAvatar, authorBadge: $authorBadge, parentId: $parentId, reactionCount: $reactionCount, replies: $replies, createdAt: $createdAt, isLiked: $isLiked)';
}


}

/// @nodoc
abstract mixin class _$CommentEntityCopyWith<$Res> implements $CommentEntityCopyWith<$Res> {
  factory _$CommentEntityCopyWith(_CommentEntity value, $Res Function(_CommentEntity) _then) = __$CommentEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String postId, String authorName, String content, String? authorId, String? authorAvatar, String? authorBadge, String? parentId, int reactionCount, List<CommentEntity> replies, DateTime? createdAt, bool isLiked
});




}
/// @nodoc
class __$CommentEntityCopyWithImpl<$Res>
    implements _$CommentEntityCopyWith<$Res> {
  __$CommentEntityCopyWithImpl(this._self, this._then);

  final _CommentEntity _self;
  final $Res Function(_CommentEntity) _then;

/// Create a copy of CommentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? postId = null,Object? authorName = null,Object? content = null,Object? authorId = freezed,Object? authorAvatar = freezed,Object? authorBadge = freezed,Object? parentId = freezed,Object? reactionCount = null,Object? replies = null,Object? createdAt = freezed,Object? isLiked = null,}) {
  return _then(_CommentEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,authorBadge: freezed == authorBadge ? _self.authorBadge : authorBadge // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,reactionCount: null == reactionCount ? _self.reactionCount : reactionCount // ignore: cast_nullable_to_non_nullable
as int,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentEntity>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
