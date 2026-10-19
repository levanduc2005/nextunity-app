// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enrollment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EnrollmentEntity {

 String get id; String get courseId; String get courseTitle; String? get courseDescription; String? get courseThumbnailUrl; String get courseDifficulty; String? get courseDifficultyName; int get totalLessons; int get progressPercent; String get status; DateTime? get createdAt; DateTime? get completedAt; String? get instructorName; String? get courseCode; String? get currentLessonTitle;
/// Create a copy of EnrollmentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnrollmentEntityCopyWith<EnrollmentEntity> get copyWith => _$EnrollmentEntityCopyWithImpl<EnrollmentEntity>(this as EnrollmentEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnrollmentEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.courseTitle, courseTitle) || other.courseTitle == courseTitle)&&(identical(other.courseDescription, courseDescription) || other.courseDescription == courseDescription)&&(identical(other.courseThumbnailUrl, courseThumbnailUrl) || other.courseThumbnailUrl == courseThumbnailUrl)&&(identical(other.courseDifficulty, courseDifficulty) || other.courseDifficulty == courseDifficulty)&&(identical(other.courseDifficultyName, courseDifficultyName) || other.courseDifficultyName == courseDifficultyName)&&(identical(other.totalLessons, totalLessons) || other.totalLessons == totalLessons)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.instructorName, instructorName) || other.instructorName == instructorName)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.currentLessonTitle, currentLessonTitle) || other.currentLessonTitle == currentLessonTitle));
}


@override
int get hashCode => Object.hash(runtimeType,id,courseId,courseTitle,courseDescription,courseThumbnailUrl,courseDifficulty,courseDifficultyName,totalLessons,progressPercent,status,createdAt,completedAt,instructorName,courseCode,currentLessonTitle);

@override
String toString() {
  return 'EnrollmentEntity(id: $id, courseId: $courseId, courseTitle: $courseTitle, courseDescription: $courseDescription, courseThumbnailUrl: $courseThumbnailUrl, courseDifficulty: $courseDifficulty, courseDifficultyName: $courseDifficultyName, totalLessons: $totalLessons, progressPercent: $progressPercent, status: $status, createdAt: $createdAt, completedAt: $completedAt, instructorName: $instructorName, courseCode: $courseCode, currentLessonTitle: $currentLessonTitle)';
}


}

/// @nodoc
abstract mixin class $EnrollmentEntityCopyWith<$Res>  {
  factory $EnrollmentEntityCopyWith(EnrollmentEntity value, $Res Function(EnrollmentEntity) _then) = _$EnrollmentEntityCopyWithImpl;
@useResult
$Res call({
 String id, String courseId, String courseTitle, String? courseDescription, String? courseThumbnailUrl, String courseDifficulty, String? courseDifficultyName, int totalLessons, int progressPercent, String status, DateTime? createdAt, DateTime? completedAt, String? instructorName, String? courseCode, String? currentLessonTitle
});




}
/// @nodoc
class _$EnrollmentEntityCopyWithImpl<$Res>
    implements $EnrollmentEntityCopyWith<$Res> {
  _$EnrollmentEntityCopyWithImpl(this._self, this._then);

  final EnrollmentEntity _self;
  final $Res Function(EnrollmentEntity) _then;

/// Create a copy of EnrollmentEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? courseId = null,Object? courseTitle = null,Object? courseDescription = freezed,Object? courseThumbnailUrl = freezed,Object? courseDifficulty = null,Object? courseDifficultyName = freezed,Object? totalLessons = null,Object? progressPercent = null,Object? status = null,Object? createdAt = freezed,Object? completedAt = freezed,Object? instructorName = freezed,Object? courseCode = freezed,Object? currentLessonTitle = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,courseTitle: null == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as String,courseDescription: freezed == courseDescription ? _self.courseDescription : courseDescription // ignore: cast_nullable_to_non_nullable
as String?,courseThumbnailUrl: freezed == courseThumbnailUrl ? _self.courseThumbnailUrl : courseThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,courseDifficulty: null == courseDifficulty ? _self.courseDifficulty : courseDifficulty // ignore: cast_nullable_to_non_nullable
as String,courseDifficultyName: freezed == courseDifficultyName ? _self.courseDifficultyName : courseDifficultyName // ignore: cast_nullable_to_non_nullable
as String?,totalLessons: null == totalLessons ? _self.totalLessons : totalLessons // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,instructorName: freezed == instructorName ? _self.instructorName : instructorName // ignore: cast_nullable_to_non_nullable
as String?,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,currentLessonTitle: freezed == currentLessonTitle ? _self.currentLessonTitle : currentLessonTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EnrollmentEntity].
extension EnrollmentEntityPatterns on EnrollmentEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnrollmentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnrollmentEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnrollmentEntity value)  $default,){
final _that = this;
switch (_that) {
case _EnrollmentEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnrollmentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _EnrollmentEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String courseId,  String courseTitle,  String? courseDescription,  String? courseThumbnailUrl,  String courseDifficulty,  String? courseDifficultyName,  int totalLessons,  int progressPercent,  String status,  DateTime? createdAt,  DateTime? completedAt,  String? instructorName,  String? courseCode,  String? currentLessonTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnrollmentEntity() when $default != null:
return $default(_that.id,_that.courseId,_that.courseTitle,_that.courseDescription,_that.courseThumbnailUrl,_that.courseDifficulty,_that.courseDifficultyName,_that.totalLessons,_that.progressPercent,_that.status,_that.createdAt,_that.completedAt,_that.instructorName,_that.courseCode,_that.currentLessonTitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String courseId,  String courseTitle,  String? courseDescription,  String? courseThumbnailUrl,  String courseDifficulty,  String? courseDifficultyName,  int totalLessons,  int progressPercent,  String status,  DateTime? createdAt,  DateTime? completedAt,  String? instructorName,  String? courseCode,  String? currentLessonTitle)  $default,) {final _that = this;
switch (_that) {
case _EnrollmentEntity():
return $default(_that.id,_that.courseId,_that.courseTitle,_that.courseDescription,_that.courseThumbnailUrl,_that.courseDifficulty,_that.courseDifficultyName,_that.totalLessons,_that.progressPercent,_that.status,_that.createdAt,_that.completedAt,_that.instructorName,_that.courseCode,_that.currentLessonTitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String courseId,  String courseTitle,  String? courseDescription,  String? courseThumbnailUrl,  String courseDifficulty,  String? courseDifficultyName,  int totalLessons,  int progressPercent,  String status,  DateTime? createdAt,  DateTime? completedAt,  String? instructorName,  String? courseCode,  String? currentLessonTitle)?  $default,) {final _that = this;
switch (_that) {
case _EnrollmentEntity() when $default != null:
return $default(_that.id,_that.courseId,_that.courseTitle,_that.courseDescription,_that.courseThumbnailUrl,_that.courseDifficulty,_that.courseDifficultyName,_that.totalLessons,_that.progressPercent,_that.status,_that.createdAt,_that.completedAt,_that.instructorName,_that.courseCode,_that.currentLessonTitle);case _:
  return null;

}
}

}

/// @nodoc


class _EnrollmentEntity extends EnrollmentEntity {
  const _EnrollmentEntity({required this.id, required this.courseId, required this.courseTitle, this.courseDescription, this.courseThumbnailUrl, this.courseDifficulty = 'BEGINNER', this.courseDifficultyName, this.totalLessons = 0, this.progressPercent = 0, this.status = 'ACTIVE', this.createdAt, this.completedAt, this.instructorName, this.courseCode, this.currentLessonTitle}): super._();
  

@override final  String id;
@override final  String courseId;
@override final  String courseTitle;
@override final  String? courseDescription;
@override final  String? courseThumbnailUrl;
@override@JsonKey() final  String courseDifficulty;
@override final  String? courseDifficultyName;
@override@JsonKey() final  int totalLessons;
@override@JsonKey() final  int progressPercent;
@override@JsonKey() final  String status;
@override final  DateTime? createdAt;
@override final  DateTime? completedAt;
@override final  String? instructorName;
@override final  String? courseCode;
@override final  String? currentLessonTitle;

/// Create a copy of EnrollmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnrollmentEntityCopyWith<_EnrollmentEntity> get copyWith => __$EnrollmentEntityCopyWithImpl<_EnrollmentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnrollmentEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.courseTitle, courseTitle) || other.courseTitle == courseTitle)&&(identical(other.courseDescription, courseDescription) || other.courseDescription == courseDescription)&&(identical(other.courseThumbnailUrl, courseThumbnailUrl) || other.courseThumbnailUrl == courseThumbnailUrl)&&(identical(other.courseDifficulty, courseDifficulty) || other.courseDifficulty == courseDifficulty)&&(identical(other.courseDifficultyName, courseDifficultyName) || other.courseDifficultyName == courseDifficultyName)&&(identical(other.totalLessons, totalLessons) || other.totalLessons == totalLessons)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.instructorName, instructorName) || other.instructorName == instructorName)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.currentLessonTitle, currentLessonTitle) || other.currentLessonTitle == currentLessonTitle));
}


@override
int get hashCode => Object.hash(runtimeType,id,courseId,courseTitle,courseDescription,courseThumbnailUrl,courseDifficulty,courseDifficultyName,totalLessons,progressPercent,status,createdAt,completedAt,instructorName,courseCode,currentLessonTitle);

@override
String toString() {
  return 'EnrollmentEntity(id: $id, courseId: $courseId, courseTitle: $courseTitle, courseDescription: $courseDescription, courseThumbnailUrl: $courseThumbnailUrl, courseDifficulty: $courseDifficulty, courseDifficultyName: $courseDifficultyName, totalLessons: $totalLessons, progressPercent: $progressPercent, status: $status, createdAt: $createdAt, completedAt: $completedAt, instructorName: $instructorName, courseCode: $courseCode, currentLessonTitle: $currentLessonTitle)';
}


}

/// @nodoc
abstract mixin class _$EnrollmentEntityCopyWith<$Res> implements $EnrollmentEntityCopyWith<$Res> {
  factory _$EnrollmentEntityCopyWith(_EnrollmentEntity value, $Res Function(_EnrollmentEntity) _then) = __$EnrollmentEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String courseId, String courseTitle, String? courseDescription, String? courseThumbnailUrl, String courseDifficulty, String? courseDifficultyName, int totalLessons, int progressPercent, String status, DateTime? createdAt, DateTime? completedAt, String? instructorName, String? courseCode, String? currentLessonTitle
});




}
/// @nodoc
class __$EnrollmentEntityCopyWithImpl<$Res>
    implements _$EnrollmentEntityCopyWith<$Res> {
  __$EnrollmentEntityCopyWithImpl(this._self, this._then);

  final _EnrollmentEntity _self;
  final $Res Function(_EnrollmentEntity) _then;

/// Create a copy of EnrollmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? courseId = null,Object? courseTitle = null,Object? courseDescription = freezed,Object? courseThumbnailUrl = freezed,Object? courseDifficulty = null,Object? courseDifficultyName = freezed,Object? totalLessons = null,Object? progressPercent = null,Object? status = null,Object? createdAt = freezed,Object? completedAt = freezed,Object? instructorName = freezed,Object? courseCode = freezed,Object? currentLessonTitle = freezed,}) {
  return _then(_EnrollmentEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,courseTitle: null == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as String,courseDescription: freezed == courseDescription ? _self.courseDescription : courseDescription // ignore: cast_nullable_to_non_nullable
as String?,courseThumbnailUrl: freezed == courseThumbnailUrl ? _self.courseThumbnailUrl : courseThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,courseDifficulty: null == courseDifficulty ? _self.courseDifficulty : courseDifficulty // ignore: cast_nullable_to_non_nullable
as String,courseDifficultyName: freezed == courseDifficultyName ? _self.courseDifficultyName : courseDifficultyName // ignore: cast_nullable_to_non_nullable
as String?,totalLessons: null == totalLessons ? _self.totalLessons : totalLessons // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,instructorName: freezed == instructorName ? _self.instructorName : instructorName // ignore: cast_nullable_to_non_nullable
as String?,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,currentLessonTitle: freezed == currentLessonTitle ? _self.currentLessonTitle : currentLessonTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
