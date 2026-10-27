// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonEntity {

 String get id; String get moduleId; String get title; int get orderIndex; bool get isCompleted; String? get content; String get type; String? get typeName; String? get videoUrl; int get estimatedMinutes; String? get slideUrl; String? get quizId; DateTime? get createdAt;
/// Create a copy of LessonEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonEntityCopyWith<LessonEntity> get copyWith => _$LessonEntityCopyWithImpl<LessonEntity>(this as LessonEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.slideUrl, slideUrl) || other.slideUrl == slideUrl)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,moduleId,title,orderIndex,isCompleted,content,type,typeName,videoUrl,estimatedMinutes,slideUrl,quizId,createdAt);

@override
String toString() {
  return 'LessonEntity(id: $id, moduleId: $moduleId, title: $title, orderIndex: $orderIndex, isCompleted: $isCompleted, content: $content, type: $type, typeName: $typeName, videoUrl: $videoUrl, estimatedMinutes: $estimatedMinutes, slideUrl: $slideUrl, quizId: $quizId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LessonEntityCopyWith<$Res>  {
  factory $LessonEntityCopyWith(LessonEntity value, $Res Function(LessonEntity) _then) = _$LessonEntityCopyWithImpl;
@useResult
$Res call({
 String id, String moduleId, String title, int orderIndex, bool isCompleted, String? content, String type, String? typeName, String? videoUrl, int estimatedMinutes, String? slideUrl, String? quizId, DateTime? createdAt
});




}
/// @nodoc
class _$LessonEntityCopyWithImpl<$Res>
    implements $LessonEntityCopyWith<$Res> {
  _$LessonEntityCopyWithImpl(this._self, this._then);

  final LessonEntity _self;
  final $Res Function(LessonEntity) _then;

/// Create a copy of LessonEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? moduleId = null,Object? title = null,Object? orderIndex = null,Object? isCompleted = null,Object? content = freezed,Object? type = null,Object? typeName = freezed,Object? videoUrl = freezed,Object? estimatedMinutes = null,Object? slideUrl = freezed,Object? quizId = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,typeName: freezed == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,slideUrl: freezed == slideUrl ? _self.slideUrl : slideUrl // ignore: cast_nullable_to_non_nullable
as String?,quizId: freezed == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonEntity].
extension LessonEntityPatterns on LessonEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonEntity value)  $default,){
final _that = this;
switch (_that) {
case _LessonEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LessonEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String moduleId,  String title,  int orderIndex,  bool isCompleted,  String? content,  String type,  String? typeName,  String? videoUrl,  int estimatedMinutes,  String? slideUrl,  String? quizId,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonEntity() when $default != null:
return $default(_that.id,_that.moduleId,_that.title,_that.orderIndex,_that.isCompleted,_that.content,_that.type,_that.typeName,_that.videoUrl,_that.estimatedMinutes,_that.slideUrl,_that.quizId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String moduleId,  String title,  int orderIndex,  bool isCompleted,  String? content,  String type,  String? typeName,  String? videoUrl,  int estimatedMinutes,  String? slideUrl,  String? quizId,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _LessonEntity():
return $default(_that.id,_that.moduleId,_that.title,_that.orderIndex,_that.isCompleted,_that.content,_that.type,_that.typeName,_that.videoUrl,_that.estimatedMinutes,_that.slideUrl,_that.quizId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String moduleId,  String title,  int orderIndex,  bool isCompleted,  String? content,  String type,  String? typeName,  String? videoUrl,  int estimatedMinutes,  String? slideUrl,  String? quizId,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LessonEntity() when $default != null:
return $default(_that.id,_that.moduleId,_that.title,_that.orderIndex,_that.isCompleted,_that.content,_that.type,_that.typeName,_that.videoUrl,_that.estimatedMinutes,_that.slideUrl,_that.quizId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _LessonEntity extends LessonEntity {
  const _LessonEntity({required this.id, required this.moduleId, required this.title, this.orderIndex = 1, this.isCompleted = false, this.content, this.type = 'TEXT', this.typeName, this.videoUrl, this.estimatedMinutes = 15, this.slideUrl, this.quizId, this.createdAt}): super._();
  

@override final  String id;
@override final  String moduleId;
@override final  String title;
@override@JsonKey() final  int orderIndex;
@override@JsonKey() final  bool isCompleted;
@override final  String? content;
@override@JsonKey() final  String type;
@override final  String? typeName;
@override final  String? videoUrl;
@override@JsonKey() final  int estimatedMinutes;
@override final  String? slideUrl;
@override final  String? quizId;
@override final  DateTime? createdAt;

/// Create a copy of LessonEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonEntityCopyWith<_LessonEntity> get copyWith => __$LessonEntityCopyWithImpl<_LessonEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.slideUrl, slideUrl) || other.slideUrl == slideUrl)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,moduleId,title,orderIndex,isCompleted,content,type,typeName,videoUrl,estimatedMinutes,slideUrl,quizId,createdAt);

@override
String toString() {
  return 'LessonEntity(id: $id, moduleId: $moduleId, title: $title, orderIndex: $orderIndex, isCompleted: $isCompleted, content: $content, type: $type, typeName: $typeName, videoUrl: $videoUrl, estimatedMinutes: $estimatedMinutes, slideUrl: $slideUrl, quizId: $quizId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LessonEntityCopyWith<$Res> implements $LessonEntityCopyWith<$Res> {
  factory _$LessonEntityCopyWith(_LessonEntity value, $Res Function(_LessonEntity) _then) = __$LessonEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String moduleId, String title, int orderIndex, bool isCompleted, String? content, String type, String? typeName, String? videoUrl, int estimatedMinutes, String? slideUrl, String? quizId, DateTime? createdAt
});




}
/// @nodoc
class __$LessonEntityCopyWithImpl<$Res>
    implements _$LessonEntityCopyWith<$Res> {
  __$LessonEntityCopyWithImpl(this._self, this._then);

  final _LessonEntity _self;
  final $Res Function(_LessonEntity) _then;

/// Create a copy of LessonEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? moduleId = null,Object? title = null,Object? orderIndex = null,Object? isCompleted = null,Object? content = freezed,Object? type = null,Object? typeName = freezed,Object? videoUrl = freezed,Object? estimatedMinutes = null,Object? slideUrl = freezed,Object? quizId = freezed,Object? createdAt = freezed,}) {
  return _then(_LessonEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,typeName: freezed == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,slideUrl: freezed == slideUrl ? _self.slideUrl : slideUrl // ignore: cast_nullable_to_non_nullable
as String?,quizId: freezed == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
