// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostEntity {

 String get id; String get title; String get content; String? get authorId; String? get authorName; String? get authorAvatar; String? get authorUniversity; List<String> get tags; int get reactionCount; Map<ReactionType, int> get reactionDetails; ReactionType? get currentUserReaction; int get commentCount; DateTime? get createdAt;
/// Create a copy of PostEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostEntityCopyWith<PostEntity> get copyWith => _$PostEntityCopyWithImpl<PostEntity>(this as PostEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.authorUniversity, authorUniversity) || other.authorUniversity == authorUniversity)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.reactionCount, reactionCount) || other.reactionCount == reactionCount)&&const DeepCollectionEquality().equals(other.reactionDetails, reactionDetails)&&(identical(other.currentUserReaction, currentUserReaction) || other.currentUserReaction == currentUserReaction)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,content,authorId,authorName,authorAvatar,authorUniversity,const DeepCollectionEquality().hash(tags),reactionCount,const DeepCollectionEquality().hash(reactionDetails),currentUserReaction,commentCount,createdAt);

@override
String toString() {
  return 'PostEntity(id: $id, title: $title, content: $content, authorId: $authorId, authorName: $authorName, authorAvatar: $authorAvatar, authorUniversity: $authorUniversity, tags: $tags, reactionCount: $reactionCount, reactionDetails: $reactionDetails, currentUserReaction: $currentUserReaction, commentCount: $commentCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PostEntityCopyWith<$Res>  {
  factory $PostEntityCopyWith(PostEntity value, $Res Function(PostEntity) _then) = _$PostEntityCopyWithImpl;
@useResult
$Res call({
 String id, String title, String content, String? authorId, String? authorName, String? authorAvatar, String? authorUniversity, List<String> tags, int reactionCount, Map<ReactionType, int> reactionDetails, ReactionType? currentUserReaction, int commentCount, DateTime? createdAt
});




}
/// @nodoc
class _$PostEntityCopyWithImpl<$Res>
    implements $PostEntityCopyWith<$Res> {
  _$PostEntityCopyWithImpl(this._self, this._then);

  final PostEntity _self;
  final $Res Function(PostEntity) _then;

/// Create a copy of PostEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? content = null,Object? authorId = freezed,Object? authorName = freezed,Object? authorAvatar = freezed,Object? authorUniversity = freezed,Object? tags = null,Object? reactionCount = null,Object? reactionDetails = null,Object? currentUserReaction = freezed,Object? commentCount = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,authorUniversity: freezed == authorUniversity ? _self.authorUniversity : authorUniversity // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,reactionCount: null == reactionCount ? _self.reactionCount : reactionCount // ignore: cast_nullable_to_non_nullable
as int,reactionDetails: null == reactionDetails ? _self.reactionDetails : reactionDetails // ignore: cast_nullable_to_non_nullable
as Map<ReactionType, int>,currentUserReaction: freezed == currentUserReaction ? _self.currentUserReaction : currentUserReaction // ignore: cast_nullable_to_non_nullable
as ReactionType?,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostEntity].
extension PostEntityPatterns on PostEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostEntity value)  $default,){
final _that = this;
switch (_that) {
case _PostEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PostEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String content,  String? authorId,  String? authorName,  String? authorAvatar,  String? authorUniversity,  List<String> tags,  int reactionCount,  Map<ReactionType, int> reactionDetails,  ReactionType? currentUserReaction,  int commentCount,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostEntity() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.authorId,_that.authorName,_that.authorAvatar,_that.authorUniversity,_that.tags,_that.reactionCount,_that.reactionDetails,_that.currentUserReaction,_that.commentCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String content,  String? authorId,  String? authorName,  String? authorAvatar,  String? authorUniversity,  List<String> tags,  int reactionCount,  Map<ReactionType, int> reactionDetails,  ReactionType? currentUserReaction,  int commentCount,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _PostEntity():
return $default(_that.id,_that.title,_that.content,_that.authorId,_that.authorName,_that.authorAvatar,_that.authorUniversity,_that.tags,_that.reactionCount,_that.reactionDetails,_that.currentUserReaction,_that.commentCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String content,  String? authorId,  String? authorName,  String? authorAvatar,  String? authorUniversity,  List<String> tags,  int reactionCount,  Map<ReactionType, int> reactionDetails,  ReactionType? currentUserReaction,  int commentCount,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PostEntity() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.authorId,_that.authorName,_that.authorAvatar,_that.authorUniversity,_that.tags,_that.reactionCount,_that.reactionDetails,_that.currentUserReaction,_that.commentCount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _PostEntity extends PostEntity {
  const _PostEntity({required this.id, required this.title, required this.content, this.authorId, this.authorName, this.authorAvatar, this.authorUniversity, final  List<String> tags = const [], this.reactionCount = 0, final  Map<ReactionType, int> reactionDetails = const {}, this.currentUserReaction, this.commentCount = 0, this.createdAt}): _tags = tags,_reactionDetails = reactionDetails,super._();
  

@override final  String id;
@override final  String title;
@override final  String content;
@override final  String? authorId;
@override final  String? authorName;
@override final  String? authorAvatar;
@override final  String? authorUniversity;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  int reactionCount;
 final  Map<ReactionType, int> _reactionDetails;
@override@JsonKey() Map<ReactionType, int> get reactionDetails {
  if (_reactionDetails is EqualUnmodifiableMapView) return _reactionDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reactionDetails);
}

@override final  ReactionType? currentUserReaction;
@override@JsonKey() final  int commentCount;
@override final  DateTime? createdAt;

/// Create a copy of PostEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostEntityCopyWith<_PostEntity> get copyWith => __$PostEntityCopyWithImpl<_PostEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.authorUniversity, authorUniversity) || other.authorUniversity == authorUniversity)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.reactionCount, reactionCount) || other.reactionCount == reactionCount)&&const DeepCollectionEquality().equals(other._reactionDetails, _reactionDetails)&&(identical(other.currentUserReaction, currentUserReaction) || other.currentUserReaction == currentUserReaction)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,content,authorId,authorName,authorAvatar,authorUniversity,const DeepCollectionEquality().hash(_tags),reactionCount,const DeepCollectionEquality().hash(_reactionDetails),currentUserReaction,commentCount,createdAt);

@override
String toString() {
  return 'PostEntity(id: $id, title: $title, content: $content, authorId: $authorId, authorName: $authorName, authorAvatar: $authorAvatar, authorUniversity: $authorUniversity, tags: $tags, reactionCount: $reactionCount, reactionDetails: $reactionDetails, currentUserReaction: $currentUserReaction, commentCount: $commentCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PostEntityCopyWith<$Res> implements $PostEntityCopyWith<$Res> {
  factory _$PostEntityCopyWith(_PostEntity value, $Res Function(_PostEntity) _then) = __$PostEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String content, String? authorId, String? authorName, String? authorAvatar, String? authorUniversity, List<String> tags, int reactionCount, Map<ReactionType, int> reactionDetails, ReactionType? currentUserReaction, int commentCount, DateTime? createdAt
});




}
/// @nodoc
class __$PostEntityCopyWithImpl<$Res>
    implements _$PostEntityCopyWith<$Res> {
  __$PostEntityCopyWithImpl(this._self, this._then);

  final _PostEntity _self;
  final $Res Function(_PostEntity) _then;

/// Create a copy of PostEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? content = null,Object? authorId = freezed,Object? authorName = freezed,Object? authorAvatar = freezed,Object? authorUniversity = freezed,Object? tags = null,Object? reactionCount = null,Object? reactionDetails = null,Object? currentUserReaction = freezed,Object? commentCount = null,Object? createdAt = freezed,}) {
  return _then(_PostEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,authorUniversity: freezed == authorUniversity ? _self.authorUniversity : authorUniversity // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,reactionCount: null == reactionCount ? _self.reactionCount : reactionCount // ignore: cast_nullable_to_non_nullable
as int,reactionDetails: null == reactionDetails ? _self._reactionDetails : reactionDetails // ignore: cast_nullable_to_non_nullable
as Map<ReactionType, int>,currentUserReaction: freezed == currentUserReaction ? _self.currentUserReaction : currentUserReaction // ignore: cast_nullable_to_non_nullable
as ReactionType?,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
