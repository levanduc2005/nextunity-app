// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_submission_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizSubmissionSummaryModel {

 String get id; String get quizId; String? get userId; String? get userName; double get score; double get totalPoints; double get percentage; bool get isPassed; int get timeSpentSeconds; DateTime? get createdAt;
/// Create a copy of QuizSubmissionSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizSubmissionSummaryModelCopyWith<QuizSubmissionSummaryModel> get copyWith => _$QuizSubmissionSummaryModelCopyWithImpl<QuizSubmissionSummaryModel>(this as QuizSubmissionSummaryModel, _$identity);

  /// Serializes this QuizSubmissionSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizSubmissionSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.score, score) || other.score == score)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed)&&(identical(other.timeSpentSeconds, timeSpentSeconds) || other.timeSpentSeconds == timeSpentSeconds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quizId,userId,userName,score,totalPoints,percentage,isPassed,timeSpentSeconds,createdAt);

@override
String toString() {
  return 'QuizSubmissionSummaryModel(id: $id, quizId: $quizId, userId: $userId, userName: $userName, score: $score, totalPoints: $totalPoints, percentage: $percentage, isPassed: $isPassed, timeSpentSeconds: $timeSpentSeconds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $QuizSubmissionSummaryModelCopyWith<$Res>  {
  factory $QuizSubmissionSummaryModelCopyWith(QuizSubmissionSummaryModel value, $Res Function(QuizSubmissionSummaryModel) _then) = _$QuizSubmissionSummaryModelCopyWithImpl;
@useResult
$Res call({
 String id, String quizId, String? userId, String? userName, double score, double totalPoints, double percentage, bool isPassed, int timeSpentSeconds, DateTime? createdAt
});




}
/// @nodoc
class _$QuizSubmissionSummaryModelCopyWithImpl<$Res>
    implements $QuizSubmissionSummaryModelCopyWith<$Res> {
  _$QuizSubmissionSummaryModelCopyWithImpl(this._self, this._then);

  final QuizSubmissionSummaryModel _self;
  final $Res Function(QuizSubmissionSummaryModel) _then;

/// Create a copy of QuizSubmissionSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? quizId = null,Object? userId = freezed,Object? userName = freezed,Object? score = null,Object? totalPoints = null,Object? percentage = null,Object? isPassed = null,Object? timeSpentSeconds = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizSubmissionSummaryModel].
extension QuizSubmissionSummaryModelPatterns on QuizSubmissionSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizSubmissionSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizSubmissionSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizSubmissionSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _QuizSubmissionSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizSubmissionSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _QuizSubmissionSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String quizId,  String? userId,  String? userName,  double score,  double totalPoints,  double percentage,  bool isPassed,  int timeSpentSeconds,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizSubmissionSummaryModel() when $default != null:
return $default(_that.id,_that.quizId,_that.userId,_that.userName,_that.score,_that.totalPoints,_that.percentage,_that.isPassed,_that.timeSpentSeconds,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String quizId,  String? userId,  String? userName,  double score,  double totalPoints,  double percentage,  bool isPassed,  int timeSpentSeconds,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _QuizSubmissionSummaryModel():
return $default(_that.id,_that.quizId,_that.userId,_that.userName,_that.score,_that.totalPoints,_that.percentage,_that.isPassed,_that.timeSpentSeconds,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String quizId,  String? userId,  String? userName,  double score,  double totalPoints,  double percentage,  bool isPassed,  int timeSpentSeconds,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _QuizSubmissionSummaryModel() when $default != null:
return $default(_that.id,_that.quizId,_that.userId,_that.userName,_that.score,_that.totalPoints,_that.percentage,_that.isPassed,_that.timeSpentSeconds,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizSubmissionSummaryModel extends QuizSubmissionSummaryModel {
  const _QuizSubmissionSummaryModel({required this.id, required this.quizId, this.userId, this.userName, this.score = 0.0, this.totalPoints = 0.0, this.percentage = 0.0, this.isPassed = false, this.timeSpentSeconds = 0, this.createdAt}): super._();
  factory _QuizSubmissionSummaryModel.fromJson(Map<String, dynamic> json) => _$QuizSubmissionSummaryModelFromJson(json);

@override final  String id;
@override final  String quizId;
@override final  String? userId;
@override final  String? userName;
@override@JsonKey() final  double score;
@override@JsonKey() final  double totalPoints;
@override@JsonKey() final  double percentage;
@override@JsonKey() final  bool isPassed;
@override@JsonKey() final  int timeSpentSeconds;
@override final  DateTime? createdAt;

/// Create a copy of QuizSubmissionSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizSubmissionSummaryModelCopyWith<_QuizSubmissionSummaryModel> get copyWith => __$QuizSubmissionSummaryModelCopyWithImpl<_QuizSubmissionSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizSubmissionSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizSubmissionSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.score, score) || other.score == score)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed)&&(identical(other.timeSpentSeconds, timeSpentSeconds) || other.timeSpentSeconds == timeSpentSeconds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quizId,userId,userName,score,totalPoints,percentage,isPassed,timeSpentSeconds,createdAt);

@override
String toString() {
  return 'QuizSubmissionSummaryModel(id: $id, quizId: $quizId, userId: $userId, userName: $userName, score: $score, totalPoints: $totalPoints, percentage: $percentage, isPassed: $isPassed, timeSpentSeconds: $timeSpentSeconds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$QuizSubmissionSummaryModelCopyWith<$Res> implements $QuizSubmissionSummaryModelCopyWith<$Res> {
  factory _$QuizSubmissionSummaryModelCopyWith(_QuizSubmissionSummaryModel value, $Res Function(_QuizSubmissionSummaryModel) _then) = __$QuizSubmissionSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String quizId, String? userId, String? userName, double score, double totalPoints, double percentage, bool isPassed, int timeSpentSeconds, DateTime? createdAt
});




}
/// @nodoc
class __$QuizSubmissionSummaryModelCopyWithImpl<$Res>
    implements _$QuizSubmissionSummaryModelCopyWith<$Res> {
  __$QuizSubmissionSummaryModelCopyWithImpl(this._self, this._then);

  final _QuizSubmissionSummaryModel _self;
  final $Res Function(_QuizSubmissionSummaryModel) _then;

/// Create a copy of QuizSubmissionSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? quizId = null,Object? userId = freezed,Object? userName = freezed,Object? score = null,Object? totalPoints = null,Object? percentage = null,Object? isPassed = null,Object? timeSpentSeconds = null,Object? createdAt = freezed,}) {
  return _then(_QuizSubmissionSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
