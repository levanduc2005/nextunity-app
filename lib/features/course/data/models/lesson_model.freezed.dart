// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LessonModel {

 String get id; String get title; String get moduleId; int get orderIndex; bool get isCompleted; String? get content; String get type; String? get typeName; String? get videoUrl; int get estimatedMinutes; String? get slideUrl; DateTime? get createdAt;
/// Create a copy of LessonModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonModelCopyWith<LessonModel> get copyWith => _$LessonModelCopyWithImpl<LessonModel>(this as LessonModel, _$identity);

  /// Serializes this LessonModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.slideUrl, slideUrl) || other.slideUrl == slideUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,moduleId,orderIndex,isCompleted,content,type,typeName,videoUrl,estimatedMinutes,slideUrl,createdAt);

@override
String toString() {
  return 'LessonModel(id: $id, title: $title, moduleId: $moduleId, orderIndex: $orderIndex, isCompleted: $isCompleted, content: $content, type: $type, typeName: $typeName, videoUrl: $videoUrl, estimatedMinutes: $estimatedMinutes, slideUrl: $slideUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LessonModelCopyWith<$Res>  {
  factory $LessonModelCopyWith(LessonModel value, $Res Function(LessonModel) _then) = _$LessonModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String moduleId, int orderIndex, bool isCompleted, String? content, String type, String? typeName, String? videoUrl, int estimatedMinutes, String? slideUrl, DateTime? createdAt
});




}
/// @nodoc
class _$LessonModelCopyWithImpl<$Res>
    implements $LessonModelCopyWith<$Res> {
  _$LessonModelCopyWithImpl(this._self, this._then);

  final LessonModel _self;
  final $Res Function(LessonModel) _then;

/// Create a copy of LessonModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? moduleId = null,Object? orderIndex = null,Object? isCompleted = null,Object? content = freezed,Object? type = null,Object? typeName = freezed,Object? videoUrl = freezed,Object? estimatedMinutes = null,Object? slideUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,typeName: freezed == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,slideUrl: freezed == slideUrl ? _self.slideUrl : slideUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonModel].
extension LessonModelPatterns on LessonModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonModel value)  $default,){
final _that = this;
switch (_that) {
case _LessonModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonModel value)?  $default,){
final _that = this;
switch (_that) {
case _LessonModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String moduleId,  int orderIndex,  bool isCompleted,  String? content,  String type,  String? typeName,  String? videoUrl,  int estimatedMinutes,  String? slideUrl,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonModel() when $default != null:
return $default(_that.id,_that.title,_that.moduleId,_that.orderIndex,_that.isCompleted,_that.content,_that.type,_that.typeName,_that.videoUrl,_that.estimatedMinutes,_that.slideUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String moduleId,  int orderIndex,  bool isCompleted,  String? content,  String type,  String? typeName,  String? videoUrl,  int estimatedMinutes,  String? slideUrl,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _LessonModel():
return $default(_that.id,_that.title,_that.moduleId,_that.orderIndex,_that.isCompleted,_that.content,_that.type,_that.typeName,_that.videoUrl,_that.estimatedMinutes,_that.slideUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String moduleId,  int orderIndex,  bool isCompleted,  String? content,  String type,  String? typeName,  String? videoUrl,  int estimatedMinutes,  String? slideUrl,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LessonModel() when $default != null:
return $default(_that.id,_that.title,_that.moduleId,_that.orderIndex,_that.isCompleted,_that.content,_that.type,_that.typeName,_that.videoUrl,_that.estimatedMinutes,_that.slideUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LessonModel extends LessonModel {
  const _LessonModel({required this.id, required this.title, this.moduleId = '', this.orderIndex = 1, this.isCompleted = false, this.content, this.type = 'TEXT', this.typeName, this.videoUrl, this.estimatedMinutes = 15, this.slideUrl, this.createdAt}): super._();
  factory _LessonModel.fromJson(Map<String, dynamic> json) => _$LessonModelFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  String moduleId;
@override@JsonKey() final  int orderIndex;
@override@JsonKey() final  bool isCompleted;
@override final  String? content;
@override@JsonKey() final  String type;
@override final  String? typeName;
@override final  String? videoUrl;
@override@JsonKey() final  int estimatedMinutes;
@override final  String? slideUrl;
@override final  DateTime? createdAt;

/// Create a copy of LessonModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonModelCopyWith<_LessonModel> get copyWith => __$LessonModelCopyWithImpl<_LessonModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.slideUrl, slideUrl) || other.slideUrl == slideUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,moduleId,orderIndex,isCompleted,content,type,typeName,videoUrl,estimatedMinutes,slideUrl,createdAt);

@override
String toString() {
  return 'LessonModel(id: $id, title: $title, moduleId: $moduleId, orderIndex: $orderIndex, isCompleted: $isCompleted, content: $content, type: $type, typeName: $typeName, videoUrl: $videoUrl, estimatedMinutes: $estimatedMinutes, slideUrl: $slideUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LessonModelCopyWith<$Res> implements $LessonModelCopyWith<$Res> {
  factory _$LessonModelCopyWith(_LessonModel value, $Res Function(_LessonModel) _then) = __$LessonModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String moduleId, int orderIndex, bool isCompleted, String? content, String type, String? typeName, String? videoUrl, int estimatedMinutes, String? slideUrl, DateTime? createdAt
});




}
/// @nodoc
class __$LessonModelCopyWithImpl<$Res>
    implements _$LessonModelCopyWith<$Res> {
  __$LessonModelCopyWithImpl(this._self, this._then);

  final _LessonModel _self;
  final $Res Function(_LessonModel) _then;

/// Create a copy of LessonModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? moduleId = null,Object? orderIndex = null,Object? isCompleted = null,Object? content = freezed,Object? type = null,Object? typeName = freezed,Object? videoUrl = freezed,Object? estimatedMinutes = null,Object? slideUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_LessonModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,typeName: freezed == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,slideUrl: freezed == slideUrl ? _self.slideUrl : slideUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
