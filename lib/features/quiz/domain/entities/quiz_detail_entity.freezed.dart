// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuizDetailEntity {

 String get id; String get lessonId; String get title; String? get description; int get durationMinutes; int get passingScore; int get totalQuestions; List<QuizQuestionEntity> get questions;
/// Create a copy of QuizDetailEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizDetailEntityCopyWith<QuizDetailEntity> get copyWith => _$QuizDetailEntityCopyWithImpl<QuizDetailEntity>(this as QuizDetailEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizDetailEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&const DeepCollectionEquality().equals(other.questions, questions));
}


@override
int get hashCode => Object.hash(runtimeType,id,lessonId,title,description,durationMinutes,passingScore,totalQuestions,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'QuizDetailEntity(id: $id, lessonId: $lessonId, title: $title, description: $description, durationMinutes: $durationMinutes, passingScore: $passingScore, totalQuestions: $totalQuestions, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $QuizDetailEntityCopyWith<$Res>  {
  factory $QuizDetailEntityCopyWith(QuizDetailEntity value, $Res Function(QuizDetailEntity) _then) = _$QuizDetailEntityCopyWithImpl;
@useResult
$Res call({
 String id, String lessonId, String title, String? description, int durationMinutes, int passingScore, int totalQuestions, List<QuizQuestionEntity> questions
});




}
/// @nodoc
class _$QuizDetailEntityCopyWithImpl<$Res>
    implements $QuizDetailEntityCopyWith<$Res> {
  _$QuizDetailEntityCopyWithImpl(this._self, this._then);

  final QuizDetailEntity _self;
  final $Res Function(QuizDetailEntity) _then;

/// Create a copy of QuizDetailEntity
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
as List<QuizQuestionEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizDetailEntity].
extension QuizDetailEntityPatterns on QuizDetailEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizDetailEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizDetailEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizDetailEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuizDetailEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizDetailEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuizDetailEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String lessonId,  String title,  String? description,  int durationMinutes,  int passingScore,  int totalQuestions,  List<QuizQuestionEntity> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizDetailEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String lessonId,  String title,  String? description,  int durationMinutes,  int passingScore,  int totalQuestions,  List<QuizQuestionEntity> questions)  $default,) {final _that = this;
switch (_that) {
case _QuizDetailEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String lessonId,  String title,  String? description,  int durationMinutes,  int passingScore,  int totalQuestions,  List<QuizQuestionEntity> questions)?  $default,) {final _that = this;
switch (_that) {
case _QuizDetailEntity() when $default != null:
return $default(_that.id,_that.lessonId,_that.title,_that.description,_that.durationMinutes,_that.passingScore,_that.totalQuestions,_that.questions);case _:
  return null;

}
}

}

/// @nodoc


class _QuizDetailEntity extends QuizDetailEntity {
  const _QuizDetailEntity({required this.id, required this.lessonId, required this.title, this.description, this.durationMinutes = 15, this.passingScore = 80, this.totalQuestions = 0, final  List<QuizQuestionEntity> questions = const []}): _questions = questions,super._();
  

@override final  String id;
@override final  String lessonId;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  int durationMinutes;
@override@JsonKey() final  int passingScore;
@override@JsonKey() final  int totalQuestions;
 final  List<QuizQuestionEntity> _questions;
@override@JsonKey() List<QuizQuestionEntity> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of QuizDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizDetailEntityCopyWith<_QuizDetailEntity> get copyWith => __$QuizDetailEntityCopyWithImpl<_QuizDetailEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizDetailEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&const DeepCollectionEquality().equals(other._questions, _questions));
}


@override
int get hashCode => Object.hash(runtimeType,id,lessonId,title,description,durationMinutes,passingScore,totalQuestions,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'QuizDetailEntity(id: $id, lessonId: $lessonId, title: $title, description: $description, durationMinutes: $durationMinutes, passingScore: $passingScore, totalQuestions: $totalQuestions, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$QuizDetailEntityCopyWith<$Res> implements $QuizDetailEntityCopyWith<$Res> {
  factory _$QuizDetailEntityCopyWith(_QuizDetailEntity value, $Res Function(_QuizDetailEntity) _then) = __$QuizDetailEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String lessonId, String title, String? description, int durationMinutes, int passingScore, int totalQuestions, List<QuizQuestionEntity> questions
});




}
/// @nodoc
class __$QuizDetailEntityCopyWithImpl<$Res>
    implements _$QuizDetailEntityCopyWith<$Res> {
  __$QuizDetailEntityCopyWithImpl(this._self, this._then);

  final _QuizDetailEntity _self;
  final $Res Function(_QuizDetailEntity) _then;

/// Create a copy of QuizDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lessonId = null,Object? title = null,Object? description = freezed,Object? durationMinutes = null,Object? passingScore = null,Object? totalQuestions = null,Object? questions = null,}) {
  return _then(_QuizDetailEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,passingScore: null == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuizQuestionEntity>,
  ));
}


}

/// @nodoc
mixin _$QuizQuestionEntity {

 String get id; String get content; String get type; double get points; int get orderIndex; List<QuizOptionEntity> get options;
/// Create a copy of QuizQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizQuestionEntityCopyWith<QuizQuestionEntity> get copyWith => _$QuizQuestionEntityCopyWithImpl<QuizQuestionEntity>(this as QuizQuestionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizQuestionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.points, points) || other.points == points)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&const DeepCollectionEquality().equals(other.options, options));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,type,points,orderIndex,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'QuizQuestionEntity(id: $id, content: $content, type: $type, points: $points, orderIndex: $orderIndex, options: $options)';
}


}

/// @nodoc
abstract mixin class $QuizQuestionEntityCopyWith<$Res>  {
  factory $QuizQuestionEntityCopyWith(QuizQuestionEntity value, $Res Function(QuizQuestionEntity) _then) = _$QuizQuestionEntityCopyWithImpl;
@useResult
$Res call({
 String id, String content, String type, double points, int orderIndex, List<QuizOptionEntity> options
});




}
/// @nodoc
class _$QuizQuestionEntityCopyWithImpl<$Res>
    implements $QuizQuestionEntityCopyWith<$Res> {
  _$QuizQuestionEntityCopyWithImpl(this._self, this._then);

  final QuizQuestionEntity _self;
  final $Res Function(QuizQuestionEntity) _then;

/// Create a copy of QuizQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? type = null,Object? points = null,Object? orderIndex = null,Object? options = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<QuizOptionEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizQuestionEntity].
extension QuizQuestionEntityPatterns on QuizQuestionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizQuestionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizQuestionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizQuestionEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuizQuestionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizQuestionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuizQuestionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String content,  String type,  double points,  int orderIndex,  List<QuizOptionEntity> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizQuestionEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String content,  String type,  double points,  int orderIndex,  List<QuizOptionEntity> options)  $default,) {final _that = this;
switch (_that) {
case _QuizQuestionEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String content,  String type,  double points,  int orderIndex,  List<QuizOptionEntity> options)?  $default,) {final _that = this;
switch (_that) {
case _QuizQuestionEntity() when $default != null:
return $default(_that.id,_that.content,_that.type,_that.points,_that.orderIndex,_that.options);case _:
  return null;

}
}

}

/// @nodoc


class _QuizQuestionEntity extends QuizQuestionEntity {
  const _QuizQuestionEntity({required this.id, required this.content, this.type = 'SINGLE_CHOICE', this.points = 10.0, this.orderIndex = 1, final  List<QuizOptionEntity> options = const []}): _options = options,super._();
  

@override final  String id;
@override final  String content;
@override@JsonKey() final  String type;
@override@JsonKey() final  double points;
@override@JsonKey() final  int orderIndex;
 final  List<QuizOptionEntity> _options;
@override@JsonKey() List<QuizOptionEntity> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of QuizQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizQuestionEntityCopyWith<_QuizQuestionEntity> get copyWith => __$QuizQuestionEntityCopyWithImpl<_QuizQuestionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizQuestionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.points, points) || other.points == points)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&const DeepCollectionEquality().equals(other._options, _options));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,type,points,orderIndex,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'QuizQuestionEntity(id: $id, content: $content, type: $type, points: $points, orderIndex: $orderIndex, options: $options)';
}


}

/// @nodoc
abstract mixin class _$QuizQuestionEntityCopyWith<$Res> implements $QuizQuestionEntityCopyWith<$Res> {
  factory _$QuizQuestionEntityCopyWith(_QuizQuestionEntity value, $Res Function(_QuizQuestionEntity) _then) = __$QuizQuestionEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String content, String type, double points, int orderIndex, List<QuizOptionEntity> options
});




}
/// @nodoc
class __$QuizQuestionEntityCopyWithImpl<$Res>
    implements _$QuizQuestionEntityCopyWith<$Res> {
  __$QuizQuestionEntityCopyWithImpl(this._self, this._then);

  final _QuizQuestionEntity _self;
  final $Res Function(_QuizQuestionEntity) _then;

/// Create a copy of QuizQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? type = null,Object? points = null,Object? orderIndex = null,Object? options = null,}) {
  return _then(_QuizQuestionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as double,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<QuizOptionEntity>,
  ));
}


}

/// @nodoc
mixin _$QuizOptionEntity {

 String get id; String get content; int get orderIndex;
/// Create a copy of QuizOptionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizOptionEntityCopyWith<QuizOptionEntity> get copyWith => _$QuizOptionEntityCopyWithImpl<QuizOptionEntity>(this as QuizOptionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizOptionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,orderIndex);

@override
String toString() {
  return 'QuizOptionEntity(id: $id, content: $content, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class $QuizOptionEntityCopyWith<$Res>  {
  factory $QuizOptionEntityCopyWith(QuizOptionEntity value, $Res Function(QuizOptionEntity) _then) = _$QuizOptionEntityCopyWithImpl;
@useResult
$Res call({
 String id, String content, int orderIndex
});




}
/// @nodoc
class _$QuizOptionEntityCopyWithImpl<$Res>
    implements $QuizOptionEntityCopyWith<$Res> {
  _$QuizOptionEntityCopyWithImpl(this._self, this._then);

  final QuizOptionEntity _self;
  final $Res Function(QuizOptionEntity) _then;

/// Create a copy of QuizOptionEntity
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


/// Adds pattern-matching-related methods to [QuizOptionEntity].
extension QuizOptionEntityPatterns on QuizOptionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizOptionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizOptionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizOptionEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuizOptionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizOptionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuizOptionEntity() when $default != null:
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
case _QuizOptionEntity() when $default != null:
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
case _QuizOptionEntity():
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
case _QuizOptionEntity() when $default != null:
return $default(_that.id,_that.content,_that.orderIndex);case _:
  return null;

}
}

}

/// @nodoc


class _QuizOptionEntity extends QuizOptionEntity {
  const _QuizOptionEntity({required this.id, required this.content, this.orderIndex = 1}): super._();
  

@override final  String id;
@override final  String content;
@override@JsonKey() final  int orderIndex;

/// Create a copy of QuizOptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizOptionEntityCopyWith<_QuizOptionEntity> get copyWith => __$QuizOptionEntityCopyWithImpl<_QuizOptionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizOptionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,orderIndex);

@override
String toString() {
  return 'QuizOptionEntity(id: $id, content: $content, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class _$QuizOptionEntityCopyWith<$Res> implements $QuizOptionEntityCopyWith<$Res> {
  factory _$QuizOptionEntityCopyWith(_QuizOptionEntity value, $Res Function(_QuizOptionEntity) _then) = __$QuizOptionEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String content, int orderIndex
});




}
/// @nodoc
class __$QuizOptionEntityCopyWithImpl<$Res>
    implements _$QuizOptionEntityCopyWith<$Res> {
  __$QuizOptionEntityCopyWithImpl(this._self, this._then);

  final _QuizOptionEntity _self;
  final $Res Function(_QuizOptionEntity) _then;

/// Create a copy of QuizOptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? orderIndex = null,}) {
  return _then(_QuizOptionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
