// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'take_quiz_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TakeQuizModel {

 String get id; String get lessonId; String get title; String? get description; int get durationMinutes; int get passingScore; int get totalQuestions; List<TakeQuestionModel> get questions;
/// Create a copy of TakeQuizModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TakeQuizModelCopyWith<TakeQuizModel> get copyWith => _$TakeQuizModelCopyWithImpl<TakeQuizModel>(this as TakeQuizModel, _$identity);

  /// Serializes this TakeQuizModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TakeQuizModel&&(identical(other.id, id) || other.id == id)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lessonId,title,description,durationMinutes,passingScore,totalQuestions,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'TakeQuizModel(id: $id, lessonId: $lessonId, title: $title, description: $description, durationMinutes: $durationMinutes, passingScore: $passingScore, totalQuestions: $totalQuestions, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $TakeQuizModelCopyWith<$Res>  {
  factory $TakeQuizModelCopyWith(TakeQuizModel value, $Res Function(TakeQuizModel) _then) = _$TakeQuizModelCopyWithImpl;
@useResult
$Res call({
 String id, String lessonId, String title, String? description, int durationMinutes, int passingScore, int totalQuestions, List<TakeQuestionModel> questions
});




}
/// @nodoc
class _$TakeQuizModelCopyWithImpl<$Res>
    implements $TakeQuizModelCopyWith<$Res> {
  _$TakeQuizModelCopyWithImpl(this._self, this._then);

  final TakeQuizModel _self;
  final $Res Function(TakeQuizModel) _then;

/// Create a copy of TakeQuizModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? lessonId = null,Object? title = null,Object? description = freezed,Object? durationMinutes = null,Object? passingScore = null,Object? totalQuestions = null,Object? questions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,passingScore: null == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<TakeQuestionModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [TakeQuizModel].
extension TakeQuizModelPatterns on TakeQuizModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TakeQuizModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TakeQuizModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TakeQuizModel value)  $default,){
final _that = this;
switch (_that) {
case _TakeQuizModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TakeQuizModel value)?  $default,){
final _that = this;
switch (_that) {
case _TakeQuizModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String lessonId,  String title,  String? description,  int durationMinutes,  int passingScore,  int totalQuestions,  List<TakeQuestionModel> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TakeQuizModel() when $default != null:
return $default(_that.id,_that.lessonId,_that.title,_that.description,_that.durationMinutes,_that.passingScore,_that.totalQuestions,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String lessonId,  String title,  String? description,  int durationMinutes,  int passingScore,  int totalQuestions,  List<TakeQuestionModel> questions)  $default,) {final _that = this;
switch (_that) {
case _TakeQuizModel():
return $default(_that.id,_that.lessonId,_that.title,_that.description,_that.durationMinutes,_that.passingScore,_that.totalQuestions,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String lessonId,  String title,  String? description,  int durationMinutes,  int passingScore,  int totalQuestions,  List<TakeQuestionModel> questions)?  $default,) {final _that = this;
switch (_that) {
case _TakeQuizModel() when $default != null:
return $default(_that.id,_that.lessonId,_that.title,_that.description,_that.durationMinutes,_that.passingScore,_that.totalQuestions,_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TakeQuizModel extends TakeQuizModel {
  const _TakeQuizModel({required this.id, required this.lessonId, required this.title, this.description, this.durationMinutes = 15, this.passingScore = 80, this.totalQuestions = 0, final  List<TakeQuestionModel> questions = const []}): _questions = questions,super._();
  factory _TakeQuizModel.fromJson(Map<String, dynamic> json) => _$TakeQuizModelFromJson(json);

@override final  String id;
@override final  String lessonId;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  int durationMinutes;
@override@JsonKey() final  int passingScore;
@override@JsonKey() final  int totalQuestions;
 final  List<TakeQuestionModel> _questions;
@override@JsonKey() List<TakeQuestionModel> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of TakeQuizModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TakeQuizModelCopyWith<_TakeQuizModel> get copyWith => __$TakeQuizModelCopyWithImpl<_TakeQuizModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TakeQuizModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TakeQuizModel&&(identical(other.id, id) || other.id == id)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lessonId,title,description,durationMinutes,passingScore,totalQuestions,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'TakeQuizModel(id: $id, lessonId: $lessonId, title: $title, description: $description, durationMinutes: $durationMinutes, passingScore: $passingScore, totalQuestions: $totalQuestions, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$TakeQuizModelCopyWith<$Res> implements $TakeQuizModelCopyWith<$Res> {
  factory _$TakeQuizModelCopyWith(_TakeQuizModel value, $Res Function(_TakeQuizModel) _then) = __$TakeQuizModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String lessonId, String title, String? description, int durationMinutes, int passingScore, int totalQuestions, List<TakeQuestionModel> questions
});




}
/// @nodoc
class __$TakeQuizModelCopyWithImpl<$Res>
    implements _$TakeQuizModelCopyWith<$Res> {
  __$TakeQuizModelCopyWithImpl(this._self, this._then);

  final _TakeQuizModel _self;
  final $Res Function(_TakeQuizModel) _then;

/// Create a copy of TakeQuizModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lessonId = null,Object? title = null,Object? description = freezed,Object? durationMinutes = null,Object? passingScore = null,Object? totalQuestions = null,Object? questions = null,}) {
  return _then(_TakeQuizModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,passingScore: null == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<TakeQuestionModel>,
  ));
}


}


/// @nodoc
mixin _$TakeQuestionModel {

 String get id; String get content; String get type; double get points; int get orderIndex; List<TakeOptionModel> get options;
/// Create a copy of TakeQuestionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TakeQuestionModelCopyWith<TakeQuestionModel> get copyWith => _$TakeQuestionModelCopyWithImpl<TakeQuestionModel>(this as TakeQuestionModel, _$identity);

  /// Serializes this TakeQuestionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TakeQuestionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.points, points) || other.points == points)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,type,points,orderIndex,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'TakeQuestionModel(id: $id, content: $content, type: $type, points: $points, orderIndex: $orderIndex, options: $options)';
}


}

/// @nodoc
abstract mixin class $TakeQuestionModelCopyWith<$Res>  {
  factory $TakeQuestionModelCopyWith(TakeQuestionModel value, $Res Function(TakeQuestionModel) _then) = _$TakeQuestionModelCopyWithImpl;
@useResult
$Res call({
 String id, String content, String type, double points, int orderIndex, List<TakeOptionModel> options
});




}
/// @nodoc
class _$TakeQuestionModelCopyWithImpl<$Res>
    implements $TakeQuestionModelCopyWith<$Res> {
  _$TakeQuestionModelCopyWithImpl(this._self, this._then);

  final TakeQuestionModel _self;
  final $Res Function(TakeQuestionModel) _then;

/// Create a copy of TakeQuestionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? type = null,Object? points = null,Object? orderIndex = null,Object? options = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<TakeOptionModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [TakeQuestionModel].
extension TakeQuestionModelPatterns on TakeQuestionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TakeQuestionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TakeQuestionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TakeQuestionModel value)  $default,){
final _that = this;
switch (_that) {
case _TakeQuestionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TakeQuestionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TakeQuestionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String content,  String type,  double points,  int orderIndex,  List<TakeOptionModel> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TakeQuestionModel() when $default != null:
return $default(_that.id,_that.content,_that.type,_that.points,_that.orderIndex,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String content,  String type,  double points,  int orderIndex,  List<TakeOptionModel> options)  $default,) {final _that = this;
switch (_that) {
case _TakeQuestionModel():
return $default(_that.id,_that.content,_that.type,_that.points,_that.orderIndex,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String content,  String type,  double points,  int orderIndex,  List<TakeOptionModel> options)?  $default,) {final _that = this;
switch (_that) {
case _TakeQuestionModel() when $default != null:
return $default(_that.id,_that.content,_that.type,_that.points,_that.orderIndex,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TakeQuestionModel extends TakeQuestionModel {
  const _TakeQuestionModel({required this.id, required this.content, this.type = 'SINGLE_CHOICE', this.points = 10.0, this.orderIndex = 1, final  List<TakeOptionModel> options = const []}): _options = options,super._();
  factory _TakeQuestionModel.fromJson(Map<String, dynamic> json) => _$TakeQuestionModelFromJson(json);

@override final  String id;
@override final  String content;
@override@JsonKey() final  String type;
@override@JsonKey() final  double points;
@override@JsonKey() final  int orderIndex;
 final  List<TakeOptionModel> _options;
@override@JsonKey() List<TakeOptionModel> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of TakeQuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TakeQuestionModelCopyWith<_TakeQuestionModel> get copyWith => __$TakeQuestionModelCopyWithImpl<_TakeQuestionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TakeQuestionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TakeQuestionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.points, points) || other.points == points)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,type,points,orderIndex,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'TakeQuestionModel(id: $id, content: $content, type: $type, points: $points, orderIndex: $orderIndex, options: $options)';
}


}

/// @nodoc
abstract mixin class _$TakeQuestionModelCopyWith<$Res> implements $TakeQuestionModelCopyWith<$Res> {
  factory _$TakeQuestionModelCopyWith(_TakeQuestionModel value, $Res Function(_TakeQuestionModel) _then) = __$TakeQuestionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String content, String type, double points, int orderIndex, List<TakeOptionModel> options
});




}
/// @nodoc
class __$TakeQuestionModelCopyWithImpl<$Res>
    implements _$TakeQuestionModelCopyWith<$Res> {
  __$TakeQuestionModelCopyWithImpl(this._self, this._then);

  final _TakeQuestionModel _self;
  final $Res Function(_TakeQuestionModel) _then;

/// Create a copy of TakeQuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? type = null,Object? points = null,Object? orderIndex = null,Object? options = null,}) {
  return _then(_TakeQuestionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<TakeOptionModel>,
  ));
}


}


/// @nodoc
mixin _$TakeOptionModel {

 String get id; String get content; int get orderIndex;
/// Create a copy of TakeOptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TakeOptionModelCopyWith<TakeOptionModel> get copyWith => _$TakeOptionModelCopyWithImpl<TakeOptionModel>(this as TakeOptionModel, _$identity);

  /// Serializes this TakeOptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TakeOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,orderIndex);

@override
String toString() {
  return 'TakeOptionModel(id: $id, content: $content, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class $TakeOptionModelCopyWith<$Res>  {
  factory $TakeOptionModelCopyWith(TakeOptionModel value, $Res Function(TakeOptionModel) _then) = _$TakeOptionModelCopyWithImpl;
@useResult
$Res call({
 String id, String content, int orderIndex
});




}
/// @nodoc
class _$TakeOptionModelCopyWithImpl<$Res>
    implements $TakeOptionModelCopyWith<$Res> {
  _$TakeOptionModelCopyWithImpl(this._self, this._then);

  final TakeOptionModel _self;
  final $Res Function(TakeOptionModel) _then;

/// Create a copy of TakeOptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? orderIndex = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TakeOptionModel].
extension TakeOptionModelPatterns on TakeOptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TakeOptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TakeOptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TakeOptionModel value)  $default,){
final _that = this;
switch (_that) {
case _TakeOptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TakeOptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TakeOptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String content,  int orderIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TakeOptionModel() when $default != null:
return $default(_that.id,_that.content,_that.orderIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String content,  int orderIndex)  $default,) {final _that = this;
switch (_that) {
case _TakeOptionModel():
return $default(_that.id,_that.content,_that.orderIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String content,  int orderIndex)?  $default,) {final _that = this;
switch (_that) {
case _TakeOptionModel() when $default != null:
return $default(_that.id,_that.content,_that.orderIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TakeOptionModel extends TakeOptionModel {
  const _TakeOptionModel({required this.id, required this.content, this.orderIndex = 1}): super._();
  factory _TakeOptionModel.fromJson(Map<String, dynamic> json) => _$TakeOptionModelFromJson(json);

@override final  String id;
@override final  String content;
@override@JsonKey() final  int orderIndex;

/// Create a copy of TakeOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TakeOptionModelCopyWith<_TakeOptionModel> get copyWith => __$TakeOptionModelCopyWithImpl<_TakeOptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TakeOptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TakeOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,orderIndex);

@override
String toString() {
  return 'TakeOptionModel(id: $id, content: $content, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class _$TakeOptionModelCopyWith<$Res> implements $TakeOptionModelCopyWith<$Res> {
  factory _$TakeOptionModelCopyWith(_TakeOptionModel value, $Res Function(_TakeOptionModel) _then) = __$TakeOptionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String content, int orderIndex
});




}
/// @nodoc
class __$TakeOptionModelCopyWithImpl<$Res>
    implements _$TakeOptionModelCopyWith<$Res> {
  __$TakeOptionModelCopyWithImpl(this._self, this._then);

  final _TakeOptionModel _self;
  final $Res Function(_TakeOptionModel) _then;

/// Create a copy of TakeOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? orderIndex = null,}) {
  return _then(_TakeOptionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
