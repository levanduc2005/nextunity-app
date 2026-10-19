// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'module_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ModuleEntity {

 String get id; String get courseId; String get title; String? get description; int get orderIndex; List<LessonEntity> get lessons;
/// Create a copy of ModuleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleEntityCopyWith<ModuleEntity> get copyWith => _$ModuleEntityCopyWithImpl<ModuleEntity>(this as ModuleEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&const DeepCollectionEquality().equals(other.lessons, lessons));
}


@override
int get hashCode => Object.hash(runtimeType,id,courseId,title,description,orderIndex,const DeepCollectionEquality().hash(lessons));

@override
String toString() {
  return 'ModuleEntity(id: $id, courseId: $courseId, title: $title, description: $description, orderIndex: $orderIndex, lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class $ModuleEntityCopyWith<$Res>  {
  factory $ModuleEntityCopyWith(ModuleEntity value, $Res Function(ModuleEntity) _then) = _$ModuleEntityCopyWithImpl;
@useResult
$Res call({
 String id, String courseId, String title, String? description, int orderIndex, List<LessonEntity> lessons
});




}
/// @nodoc
class _$ModuleEntityCopyWithImpl<$Res>
    implements $ModuleEntityCopyWith<$Res> {
  _$ModuleEntityCopyWithImpl(this._self, this._then);

  final ModuleEntity _self;
  final $Res Function(ModuleEntity) _then;

/// Create a copy of ModuleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? courseId = null,Object? title = null,Object? description = freezed,Object? orderIndex = null,Object? lessons = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,lessons: null == lessons ? _self.lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [ModuleEntity].
extension ModuleEntityPatterns on ModuleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleEntity value)  $default,){
final _that = this;
switch (_that) {
case _ModuleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String courseId,  String title,  String? description,  int orderIndex,  List<LessonEntity> lessons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleEntity() when $default != null:
return $default(_that.id,_that.courseId,_that.title,_that.description,_that.orderIndex,_that.lessons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String courseId,  String title,  String? description,  int orderIndex,  List<LessonEntity> lessons)  $default,) {final _that = this;
switch (_that) {
case _ModuleEntity():
return $default(_that.id,_that.courseId,_that.title,_that.description,_that.orderIndex,_that.lessons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String courseId,  String title,  String? description,  int orderIndex,  List<LessonEntity> lessons)?  $default,) {final _that = this;
switch (_that) {
case _ModuleEntity() when $default != null:
return $default(_that.id,_that.courseId,_that.title,_that.description,_that.orderIndex,_that.lessons);case _:
  return null;

}
}

}

/// @nodoc


class _ModuleEntity extends ModuleEntity {
  const _ModuleEntity({required this.id, required this.courseId, required this.title, this.description, this.orderIndex = 1, final  List<LessonEntity> lessons = const []}): _lessons = lessons,super._();
  

@override final  String id;
@override final  String courseId;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  int orderIndex;
 final  List<LessonEntity> _lessons;
@override@JsonKey() List<LessonEntity> get lessons {
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessons);
}


/// Create a copy of ModuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleEntityCopyWith<_ModuleEntity> get copyWith => __$ModuleEntityCopyWithImpl<_ModuleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&const DeepCollectionEquality().equals(other._lessons, _lessons));
}


@override
int get hashCode => Object.hash(runtimeType,id,courseId,title,description,orderIndex,const DeepCollectionEquality().hash(_lessons));

@override
String toString() {
  return 'ModuleEntity(id: $id, courseId: $courseId, title: $title, description: $description, orderIndex: $orderIndex, lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class _$ModuleEntityCopyWith<$Res> implements $ModuleEntityCopyWith<$Res> {
  factory _$ModuleEntityCopyWith(_ModuleEntity value, $Res Function(_ModuleEntity) _then) = __$ModuleEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String courseId, String title, String? description, int orderIndex, List<LessonEntity> lessons
});




}
/// @nodoc
class __$ModuleEntityCopyWithImpl<$Res>
    implements _$ModuleEntityCopyWith<$Res> {
  __$ModuleEntityCopyWithImpl(this._self, this._then);

  final _ModuleEntity _self;
  final $Res Function(_ModuleEntity) _then;

/// Create a copy of ModuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? courseId = null,Object? title = null,Object? description = freezed,Object? orderIndex = null,Object? lessons = null,}) {
  return _then(_ModuleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,lessons: null == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonEntity>,
  ));
}


}

// dart format on
