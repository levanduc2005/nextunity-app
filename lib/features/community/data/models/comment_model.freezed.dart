// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentModel {

 String get id; String get postId; String? get authorId; String get authorName; String? get authorAvatar; String? get authorBadge; String get content; String? get parentId; int get reactionCount; Map<String, dynamic>? get reactionDetails; String? get currentUserReaction; List<CommentModel> get replies; String? get createdAt;
/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentModelCopyWith<CommentModel> get copyWith => _$CommentModelCopyWithImpl<CommentModel>(this as CommentModel, _$identity);

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.authorBadge, authorBadge) || other.authorBadge == authorBadge)&&(identical(other.content, content) || other.content == content)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.reactionCount, reactionCount) || other.reactionCount == reactionCount)&&const DeepCollectionEquality().equals(other.reactionDetails, reactionDetails)&&(identical(other.currentUserReaction, currentUserReaction) || other.currentUserReaction == currentUserReaction)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,authorId,authorName,authorAvatar,authorBadge,content,parentId,reactionCount,const DeepCollectionEquality().hash(reactionDetails),currentUserReaction,const DeepCollectionEquality().hash(replies),createdAt);

@override
String toString() {
  return 'CommentModel(id: $id, postId: $postId, authorId: $authorId, authorName: $authorName, authorAvatar: $authorAvatar, authorBadge: $authorBadge, content: $content, parentId: $parentId, reactionCount: $reactionCount, reactionDetails: $reactionDetails, currentUserReaction: $currentUserReaction, replies: $replies, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CommentModelCopyWith<$Res>  {
  factory $CommentModelCopyWith(CommentModel value, $Res Function(CommentModel) _then) = _$CommentModelCopyWithImpl;
@useResult
$Res call({
 String id, String postId, String? authorId, String authorName, String? authorAvatar, String? authorBadge, String content, String? parentId, int reactionCount, Map<String, dynamic>? reactionDetails, String? currentUserReaction, List<CommentModel> replies, String? createdAt
});




}
/// @nodoc
class _$CommentModelCopyWithImpl<$Res>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._self, this._then);

  final CommentModel _self;
  final $Res Function(CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? postId = null,Object? authorId = freezed,Object? authorName = null,Object? authorAvatar = freezed,Object? authorBadge = freezed,Object? content = null,Object? parentId = freezed,Object? reactionCount = null,Object? reactionDetails = freezed,Object? currentUserReaction = freezed,Object? replies = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,authorBadge: freezed == authorBadge ? _self.authorBadge : authorBadge // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,reactionCount: null == reactionCount ? _self.reactionCount : reactionCount // ignore: cast_nullable_to_non_nullable
as int,reactionDetails: freezed == reactionDetails ? _self.reactionDetails : reactionDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,currentUserReaction: freezed == currentUserReaction ? _self.currentUserReaction : currentUserReaction // ignore: cast_nullable_to_non_nullable
as String?,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentModel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentModel].
extension CommentModelPatterns on CommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentModel value)  $default,){
final _that = this;
switch (_that) {
case _CommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String postId,  String? authorId,  String authorName,  String? authorAvatar,  String? authorBadge,  String content,  String? parentId,  int reactionCount,  Map<String, dynamic>? reactionDetails,  String? currentUserReaction,  List<CommentModel> replies,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.postId,_that.authorId,_that.authorName,_that.authorAvatar,_that.authorBadge,_that.content,_that.parentId,_that.reactionCount,_that.reactionDetails,_that.currentUserReaction,_that.replies,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String postId,  String? authorId,  String authorName,  String? authorAvatar,  String? authorBadge,  String content,  String? parentId,  int reactionCount,  Map<String, dynamic>? reactionDetails,  String? currentUserReaction,  List<CommentModel> replies,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CommentModel():
return $default(_that.id,_that.postId,_that.authorId,_that.authorName,_that.authorAvatar,_that.authorBadge,_that.content,_that.parentId,_that.reactionCount,_that.reactionDetails,_that.currentUserReaction,_that.replies,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String postId,  String? authorId,  String authorName,  String? authorAvatar,  String? authorBadge,  String content,  String? parentId,  int reactionCount,  Map<String, dynamic>? reactionDetails,  String? currentUserReaction,  List<CommentModel> replies,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.postId,_that.authorId,_that.authorName,_that.authorAvatar,_that.authorBadge,_that.content,_that.parentId,_that.reactionCount,_that.reactionDetails,_that.currentUserReaction,_that.replies,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentModel extends CommentModel {
  const _CommentModel({required this.id, required this.postId, this.authorId, required this.authorName, this.authorAvatar, this.authorBadge, required this.content, this.parentId, this.reactionCount = 0, final  Map<String, dynamic>? reactionDetails, this.currentUserReaction, final  List<CommentModel> replies = const [], this.createdAt}): _reactionDetails = reactionDetails,_replies = replies,super._();
  factory _CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

@override final  String id;
@override final  String postId;
@override final  String? authorId;
@override final  String authorName;
@override final  String? authorAvatar;
@override final  String? authorBadge;
@override final  String content;
@override final  String? parentId;
@override@JsonKey() final  int reactionCount;
 final  Map<String, dynamic>? _reactionDetails;
@override Map<String, dynamic>? get reactionDetails {
  final value = _reactionDetails;
  if (value == null) return null;
  if (_reactionDetails is EqualUnmodifiableMapView) return _reactionDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? currentUserReaction;
 final  List<CommentModel> _replies;
@override@JsonKey() List<CommentModel> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override final  String? createdAt;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentModelCopyWith<_CommentModel> get copyWith => __$CommentModelCopyWithImpl<_CommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.authorBadge, authorBadge) || other.authorBadge == authorBadge)&&(identical(other.content, content) || other.content == content)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.reactionCount, reactionCount) || other.reactionCount == reactionCount)&&const DeepCollectionEquality().equals(other._reactionDetails, _reactionDetails)&&(identical(other.currentUserReaction, currentUserReaction) || other.currentUserReaction == currentUserReaction)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,authorId,authorName,authorAvatar,authorBadge,content,parentId,reactionCount,const DeepCollectionEquality().hash(_reactionDetails),currentUserReaction,const DeepCollectionEquality().hash(_replies),createdAt);

@override
String toString() {
  return 'CommentModel(id: $id, postId: $postId, authorId: $authorId, authorName: $authorName, authorAvatar: $authorAvatar, authorBadge: $authorBadge, content: $content, parentId: $parentId, reactionCount: $reactionCount, reactionDetails: $reactionDetails, currentUserReaction: $currentUserReaction, replies: $replies, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CommentModelCopyWith<$Res> implements $CommentModelCopyWith<$Res> {
  factory _$CommentModelCopyWith(_CommentModel value, $Res Function(_CommentModel) _then) = __$CommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String postId, String? authorId, String authorName, String? authorAvatar, String? authorBadge, String content, String? parentId, int reactionCount, Map<String, dynamic>? reactionDetails, String? currentUserReaction, List<CommentModel> replies, String? createdAt
});




}
/// @nodoc
class __$CommentModelCopyWithImpl<$Res>
    implements _$CommentModelCopyWith<$Res> {
  __$CommentModelCopyWithImpl(this._self, this._then);

  final _CommentModel _self;
  final $Res Function(_CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? postId = null,Object? authorId = freezed,Object? authorName = null,Object? authorAvatar = freezed,Object? authorBadge = freezed,Object? content = null,Object? parentId = freezed,Object? reactionCount = null,Object? reactionDetails = freezed,Object? currentUserReaction = freezed,Object? replies = null,Object? createdAt = freezed,}) {
  return _then(_CommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,authorBadge: freezed == authorBadge ? _self.authorBadge : authorBadge // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,reactionCount: null == reactionCount ? _self.reactionCount : reactionCount // ignore: cast_nullable_to_non_nullable
as int,reactionDetails: freezed == reactionDetails ? _self._reactionDetails : reactionDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,currentUserReaction: freezed == currentUserReaction ? _self.currentUserReaction : currentUserReaction // ignore: cast_nullable_to_non_nullable
as String?,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentModel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
