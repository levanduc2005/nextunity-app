// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuizResultEntity {

 String get submissionId; String get quizId; double get score; double get totalPoints; double get percentage; bool get isPassed; int get timeSpentSeconds; DateTime? get submittedAt; List<QuestionResultEntity> get questionResults;
/// Create a copy of QuizResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizResultEntityCopyWith<QuizResultEntity> get copyWith => _$QuizResultEntityCopyWithImpl<QuizResultEntity>(this as QuizResultEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizResultEntity&&(identical(other.submissionId, submissionId) || other.submissionId == submissionId)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.score, score) || other.score == score)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed)&&(identical(other.timeSpentSeconds, timeSpentSeconds) || other.timeSpentSeconds == timeSpentSeconds)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&const DeepCollectionEquality().equals(other.questionResults, questionResults));
}


@override
int get hashCode => Object.hash(runtimeType,submissionId,quizId,score,totalPoints,percentage,isPassed,timeSpentSeconds,submittedAt,const DeepCollectionEquality().hash(questionResults));

@override
String toString() {
  return 'QuizResultEntity(submissionId: $submissionId, quizId: $quizId, score: $score, totalPoints: $totalPoints, percentage: $percentage, isPassed: $isPassed, timeSpentSeconds: $timeSpentSeconds, submittedAt: $submittedAt, questionResults: $questionResults)';
}


}

/// @nodoc
abstract mixin class $QuizResultEntityCopyWith<$Res>  {
  factory $QuizResultEntityCopyWith(QuizResultEntity value, $Res Function(QuizResultEntity) _then) = _$QuizResultEntityCopyWithImpl;
@useResult
$Res call({
 String submissionId, String quizId, double score, double totalPoints, double percentage, bool isPassed, int timeSpentSeconds, DateTime? submittedAt, List<QuestionResultEntity> questionResults
});




}
/// @nodoc
class _$QuizResultEntityCopyWithImpl<$Res>
    implements $QuizResultEntityCopyWith<$Res> {
  _$QuizResultEntityCopyWithImpl(this._self, this._then);

  final QuizResultEntity _self;
  final $Res Function(QuizResultEntity) _then;

/// Create a copy of QuizResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? submissionId = null,Object? quizId = null,Object? score = null,Object? totalPoints = null,Object? percentage = null,Object? isPassed = null,Object? timeSpentSeconds = null,Object? submittedAt = freezed,Object? questionResults = null,}) {
  return _then(_self.copyWith(
submissionId: null == submissionId ? _self.submissionId : submissionId // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,questionResults: null == questionResults ? _self.questionResults : questionResults // ignore: cast_nullable_to_non_nullable
as List<QuestionResultEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizResultEntity].
extension QuizResultEntityPatterns on QuizResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuizResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuizResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String submissionId,  String quizId,  double score,  double totalPoints,  double percentage,  bool isPassed,  int timeSpentSeconds,  DateTime? submittedAt,  List<QuestionResultEntity> questionResults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizResultEntity() when $default != null:
return $default(_that.submissionId,_that.quizId,_that.score,_that.totalPoints,_that.percentage,_that.isPassed,_that.timeSpentSeconds,_that.submittedAt,_that.questionResults);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String submissionId,  String quizId,  double score,  double totalPoints,  double percentage,  bool isPassed,  int timeSpentSeconds,  DateTime? submittedAt,  List<QuestionResultEntity> questionResults)  $default,) {final _that = this;
switch (_that) {
case _QuizResultEntity():
return $default(_that.submissionId,_that.quizId,_that.score,_that.totalPoints,_that.percentage,_that.isPassed,_that.timeSpentSeconds,_that.submittedAt,_that.questionResults);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String submissionId,  String quizId,  double score,  double totalPoints,  double percentage,  bool isPassed,  int timeSpentSeconds,  DateTime? submittedAt,  List<QuestionResultEntity> questionResults)?  $default,) {final _that = this;
switch (_that) {
case _QuizResultEntity() when $default != null:
return $default(_that.submissionId,_that.quizId,_that.score,_that.totalPoints,_that.percentage,_that.isPassed,_that.timeSpentSeconds,_that.submittedAt,_that.questionResults);case _:
  return null;

}
}

}

/// @nodoc


class _QuizResultEntity extends QuizResultEntity {
  const _QuizResultEntity({required this.submissionId, required this.quizId, this.score = 0.0, this.totalPoints = 0.0, this.percentage = 0.0, this.isPassed = false, this.timeSpentSeconds = 0, this.submittedAt, final  List<QuestionResultEntity> questionResults = const []}): _questionResults = questionResults,super._();
  

@override final  String submissionId;
@override final  String quizId;
@override@JsonKey() final  double score;
@override@JsonKey() final  double totalPoints;
@override@JsonKey() final  double percentage;
@override@JsonKey() final  bool isPassed;
@override@JsonKey() final  int timeSpentSeconds;
@override final  DateTime? submittedAt;
 final  List<QuestionResultEntity> _questionResults;
@override@JsonKey() List<QuestionResultEntity> get questionResults {
  if (_questionResults is EqualUnmodifiableListView) return _questionResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questionResults);
}


/// Create a copy of QuizResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizResultEntityCopyWith<_QuizResultEntity> get copyWith => __$QuizResultEntityCopyWithImpl<_QuizResultEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizResultEntity&&(identical(other.submissionId, submissionId) || other.submissionId == submissionId)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.score, score) || other.score == score)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed)&&(identical(other.timeSpentSeconds, timeSpentSeconds) || other.timeSpentSeconds == timeSpentSeconds)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&const DeepCollectionEquality().equals(other._questionResults, _questionResults));
}


@override
int get hashCode => Object.hash(runtimeType,submissionId,quizId,score,totalPoints,percentage,isPassed,timeSpentSeconds,submittedAt,const DeepCollectionEquality().hash(_questionResults));

@override
String toString() {
  return 'QuizResultEntity(submissionId: $submissionId, quizId: $quizId, score: $score, totalPoints: $totalPoints, percentage: $percentage, isPassed: $isPassed, timeSpentSeconds: $timeSpentSeconds, submittedAt: $submittedAt, questionResults: $questionResults)';
}


}

/// @nodoc
abstract mixin class _$QuizResultEntityCopyWith<$Res> implements $QuizResultEntityCopyWith<$Res> {
  factory _$QuizResultEntityCopyWith(_QuizResultEntity value, $Res Function(_QuizResultEntity) _then) = __$QuizResultEntityCopyWithImpl;
@override @useResult
$Res call({
 String submissionId, String quizId, double score, double totalPoints, double percentage, bool isPassed, int timeSpentSeconds, DateTime? submittedAt, List<QuestionResultEntity> questionResults
});




}
/// @nodoc
class __$QuizResultEntityCopyWithImpl<$Res>
    implements _$QuizResultEntityCopyWith<$Res> {
  __$QuizResultEntityCopyWithImpl(this._self, this._then);

  final _QuizResultEntity _self;
  final $Res Function(_QuizResultEntity) _then;

/// Create a copy of QuizResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? submissionId = null,Object? quizId = null,Object? score = null,Object? totalPoints = null,Object? percentage = null,Object? isPassed = null,Object? timeSpentSeconds = null,Object? submittedAt = freezed,Object? questionResults = null,}) {
  return _then(_QuizResultEntity(
submissionId: null == submissionId ? _self.submissionId : submissionId // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,questionResults: null == questionResults ? _self._questionResults : questionResults // ignore: cast_nullable_to_non_nullable
as List<QuestionResultEntity>,
  ));
}


}

/// @nodoc
mixin _$QuestionResultEntity {

 String get questionId; String get content; String? get explanation; double get points; double get earnedPoints; bool get isCorrect; List<String> get selectedOptionIds; List<String> get correctOptionIds;
/// Create a copy of QuestionResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionResultEntityCopyWith<QuestionResultEntity> get copyWith => _$QuestionResultEntityCopyWithImpl<QuestionResultEntity>(this as QuestionResultEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionResultEntity&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.content, content) || other.content == content)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.points, points) || other.points == points)&&(identical(other.earnedPoints, earnedPoints) || other.earnedPoints == earnedPoints)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&const DeepCollectionEquality().equals(other.selectedOptionIds, selectedOptionIds)&&const DeepCollectionEquality().equals(other.correctOptionIds, correctOptionIds));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,content,explanation,points,earnedPoints,isCorrect,const DeepCollectionEquality().hash(selectedOptionIds),const DeepCollectionEquality().hash(correctOptionIds));

@override
String toString() {
  return 'QuestionResultEntity(questionId: $questionId, content: $content, explanation: $explanation, points: $points, earnedPoints: $earnedPoints, isCorrect: $isCorrect, selectedOptionIds: $selectedOptionIds, correctOptionIds: $correctOptionIds)';
}


}

/// @nodoc
abstract mixin class $QuestionResultEntityCopyWith<$Res>  {
  factory $QuestionResultEntityCopyWith(QuestionResultEntity value, $Res Function(QuestionResultEntity) _then) = _$QuestionResultEntityCopyWithImpl;
@useResult
$Res call({
 String questionId, String content, String? explanation, double points, double earnedPoints, bool isCorrect, List<String> selectedOptionIds, List<String> correctOptionIds
});




}
/// @nodoc
class _$QuestionResultEntityCopyWithImpl<$Res>
    implements $QuestionResultEntityCopyWith<$Res> {
  _$QuestionResultEntityCopyWithImpl(this._self, this._then);

  final QuestionResultEntity _self;
  final $Res Function(QuestionResultEntity) _then;

/// Create a copy of QuestionResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? content = null,Object? explanation = freezed,Object? points = null,Object? earnedPoints = null,Object? isCorrect = null,Object? selectedOptionIds = null,Object? correctOptionIds = null,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,earnedPoints: null == earnedPoints ? _self.earnedPoints : earnedPoints // ignore: cast_nullable_to_non_nullable
as double,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,selectedOptionIds: null == selectedOptionIds ? _self.selectedOptionIds : selectedOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,correctOptionIds: null == correctOptionIds ? _self.correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionResultEntity].
extension QuestionResultEntityPatterns on QuestionResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuestionResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String questionId,  String content,  String? explanation,  double points,  double earnedPoints,  bool isCorrect,  List<String> selectedOptionIds,  List<String> correctOptionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionResultEntity() when $default != null:
return $default(_that.questionId,_that.content,_that.explanation,_that.points,_that.earnedPoints,_that.isCorrect,_that.selectedOptionIds,_that.correctOptionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String questionId,  String content,  String? explanation,  double points,  double earnedPoints,  bool isCorrect,  List<String> selectedOptionIds,  List<String> correctOptionIds)  $default,) {final _that = this;
switch (_that) {
case _QuestionResultEntity():
return $default(_that.questionId,_that.content,_that.explanation,_that.points,_that.earnedPoints,_that.isCorrect,_that.selectedOptionIds,_that.correctOptionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String questionId,  String content,  String? explanation,  double points,  double earnedPoints,  bool isCorrect,  List<String> selectedOptionIds,  List<String> correctOptionIds)?  $default,) {final _that = this;
switch (_that) {
case _QuestionResultEntity() when $default != null:
return $default(_that.questionId,_that.content,_that.explanation,_that.points,_that.earnedPoints,_that.isCorrect,_that.selectedOptionIds,_that.correctOptionIds);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionResultEntity extends QuestionResultEntity {
  const _QuestionResultEntity({required this.questionId, this.content = '', this.explanation, this.points = 0.0, this.earnedPoints = 0.0, this.isCorrect = false, final  List<String> selectedOptionIds = const [], final  List<String> correctOptionIds = const []}): _selectedOptionIds = selectedOptionIds,_correctOptionIds = correctOptionIds,super._();
  

@override final  String questionId;
@override@JsonKey() final  String content;
@override final  String? explanation;
@override@JsonKey() final  double points;
@override@JsonKey() final  double earnedPoints;
@override@JsonKey() final  bool isCorrect;
 final  List<String> _selectedOptionIds;
@override@JsonKey() List<String> get selectedOptionIds {
  if (_selectedOptionIds is EqualUnmodifiableListView) return _selectedOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedOptionIds);
}

 final  List<String> _correctOptionIds;
@override@JsonKey() List<String> get correctOptionIds {
  if (_correctOptionIds is EqualUnmodifiableListView) return _correctOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctOptionIds);
}


/// Create a copy of QuestionResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionResultEntityCopyWith<_QuestionResultEntity> get copyWith => __$QuestionResultEntityCopyWithImpl<_QuestionResultEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionResultEntity&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.content, content) || other.content == content)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.points, points) || other.points == points)&&(identical(other.earnedPoints, earnedPoints) || other.earnedPoints == earnedPoints)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&const DeepCollectionEquality().equals(other._selectedOptionIds, _selectedOptionIds)&&const DeepCollectionEquality().equals(other._correctOptionIds, _correctOptionIds));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,content,explanation,points,earnedPoints,isCorrect,const DeepCollectionEquality().hash(_selectedOptionIds),const DeepCollectionEquality().hash(_correctOptionIds));

@override
String toString() {
  return 'QuestionResultEntity(questionId: $questionId, content: $content, explanation: $explanation, points: $points, earnedPoints: $earnedPoints, isCorrect: $isCorrect, selectedOptionIds: $selectedOptionIds, correctOptionIds: $correctOptionIds)';
}


}

/// @nodoc
abstract mixin class _$QuestionResultEntityCopyWith<$Res> implements $QuestionResultEntityCopyWith<$Res> {
  factory _$QuestionResultEntityCopyWith(_QuestionResultEntity value, $Res Function(_QuestionResultEntity) _then) = __$QuestionResultEntityCopyWithImpl;
@override @useResult
$Res call({
 String questionId, String content, String? explanation, double points, double earnedPoints, bool isCorrect, List<String> selectedOptionIds, List<String> correctOptionIds
});




}
/// @nodoc
class __$QuestionResultEntityCopyWithImpl<$Res>
    implements _$QuestionResultEntityCopyWith<$Res> {
  __$QuestionResultEntityCopyWithImpl(this._self, this._then);

  final _QuestionResultEntity _self;
  final $Res Function(_QuestionResultEntity) _then;

/// Create a copy of QuestionResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? content = null,Object? explanation = freezed,Object? points = null,Object? earnedPoints = null,Object? isCorrect = null,Object? selectedOptionIds = null,Object? correctOptionIds = null,}) {
  return _then(_QuestionResultEntity(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,earnedPoints: null == earnedPoints ? _self.earnedPoints : earnedPoints // ignore: cast_nullable_to_non_nullable
as double,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,selectedOptionIds: null == selectedOptionIds ? _self._selectedOptionIds : selectedOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,correctOptionIds: null == correctOptionIds ? _self._correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
