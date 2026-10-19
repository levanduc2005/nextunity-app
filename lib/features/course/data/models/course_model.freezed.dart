// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseModel {

 String get id; String get title; String? get code; String? get description; String? get category; String? get categoryName; String get difficulty; String? get difficultyName;@JsonKey(name: 'thumbnailUrl') String? get imageUrl; int get totalLessons; int get totalModules;@JsonKey(name: 'myProgressPercent', fromJson: _progressFromJson) double get progress; bool get isPremium; String? get creatorName; bool get isEnrolled; double get rating; int get reviewCount;
/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseModelCopyWith<CourseModel> get copyWith => _$CourseModelCopyWithImpl<CourseModel>(this as CourseModel, _$identity);

  /// Serializes this CourseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.difficultyName, difficultyName) || other.difficultyName == difficultyName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.totalLessons, totalLessons) || other.totalLessons == totalLessons)&&(identical(other.totalModules, totalModules) || other.totalModules == totalModules)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.isEnrolled, isEnrolled) || other.isEnrolled == isEnrolled)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,code,description,category,categoryName,difficulty,difficultyName,imageUrl,totalLessons,totalModules,progress,isPremium,creatorName,isEnrolled,rating,reviewCount);

@override
String toString() {
  return 'CourseModel(id: $id, title: $title, code: $code, description: $description, category: $category, categoryName: $categoryName, difficulty: $difficulty, difficultyName: $difficultyName, imageUrl: $imageUrl, totalLessons: $totalLessons, totalModules: $totalModules, progress: $progress, isPremium: $isPremium, creatorName: $creatorName, isEnrolled: $isEnrolled, rating: $rating, reviewCount: $reviewCount)';
}


}

/// @nodoc
abstract mixin class $CourseModelCopyWith<$Res>  {
  factory $CourseModelCopyWith(CourseModel value, $Res Function(CourseModel) _then) = _$CourseModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? code, String? description, String? category, String? categoryName, String difficulty, String? difficultyName,@JsonKey(name: 'thumbnailUrl') String? imageUrl, int totalLessons, int totalModules,@JsonKey(name: 'myProgressPercent', fromJson: _progressFromJson) double progress, bool isPremium, String? creatorName, bool isEnrolled, double rating, int reviewCount
});




}
/// @nodoc
class _$CourseModelCopyWithImpl<$Res>
    implements $CourseModelCopyWith<$Res> {
  _$CourseModelCopyWithImpl(this._self, this._then);

  final CourseModel _self;
  final $Res Function(CourseModel) _then;

/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? code = freezed,Object? description = freezed,Object? category = freezed,Object? categoryName = freezed,Object? difficulty = null,Object? difficultyName = freezed,Object? imageUrl = freezed,Object? totalLessons = null,Object? totalModules = null,Object? progress = null,Object? isPremium = null,Object? creatorName = freezed,Object? isEnrolled = null,Object? rating = null,Object? reviewCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,difficultyName: freezed == difficultyName ? _self.difficultyName : difficultyName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,totalLessons: null == totalLessons ? _self.totalLessons : totalLessons // ignore: cast_nullable_to_non_nullable
as int,totalModules: null == totalModules ? _self.totalModules : totalModules // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,creatorName: freezed == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String?,isEnrolled: null == isEnrolled ? _self.isEnrolled : isEnrolled // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseModel].
extension CourseModelPatterns on CourseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseModel value)  $default,){
final _that = this;
switch (_that) {
case _CourseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CourseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? code,  String? description,  String? category,  String? categoryName,  String difficulty,  String? difficultyName, @JsonKey(name: 'thumbnailUrl')  String? imageUrl,  int totalLessons,  int totalModules, @JsonKey(name: 'myProgressPercent', fromJson: _progressFromJson)  double progress,  bool isPremium,  String? creatorName,  bool isEnrolled,  double rating,  int reviewCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseModel() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.description,_that.category,_that.categoryName,_that.difficulty,_that.difficultyName,_that.imageUrl,_that.totalLessons,_that.totalModules,_that.progress,_that.isPremium,_that.creatorName,_that.isEnrolled,_that.rating,_that.reviewCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? code,  String? description,  String? category,  String? categoryName,  String difficulty,  String? difficultyName, @JsonKey(name: 'thumbnailUrl')  String? imageUrl,  int totalLessons,  int totalModules, @JsonKey(name: 'myProgressPercent', fromJson: _progressFromJson)  double progress,  bool isPremium,  String? creatorName,  bool isEnrolled,  double rating,  int reviewCount)  $default,) {final _that = this;
switch (_that) {
case _CourseModel():
return $default(_that.id,_that.title,_that.code,_that.description,_that.category,_that.categoryName,_that.difficulty,_that.difficultyName,_that.imageUrl,_that.totalLessons,_that.totalModules,_that.progress,_that.isPremium,_that.creatorName,_that.isEnrolled,_that.rating,_that.reviewCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? code,  String? description,  String? category,  String? categoryName,  String difficulty,  String? difficultyName, @JsonKey(name: 'thumbnailUrl')  String? imageUrl,  int totalLessons,  int totalModules, @JsonKey(name: 'myProgressPercent', fromJson: _progressFromJson)  double progress,  bool isPremium,  String? creatorName,  bool isEnrolled,  double rating,  int reviewCount)?  $default,) {final _that = this;
switch (_that) {
case _CourseModel() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.description,_that.category,_that.categoryName,_that.difficulty,_that.difficultyName,_that.imageUrl,_that.totalLessons,_that.totalModules,_that.progress,_that.isPremium,_that.creatorName,_that.isEnrolled,_that.rating,_that.reviewCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseModel extends CourseModel {
  const _CourseModel({required this.id, required this.title, this.code, this.description, this.category, this.categoryName, this.difficulty = 'BEGINNER', this.difficultyName, @JsonKey(name: 'thumbnailUrl') this.imageUrl, this.totalLessons = 0, this.totalModules = 0, @JsonKey(name: 'myProgressPercent', fromJson: _progressFromJson) this.progress = 0.0, this.isPremium = false, this.creatorName, this.isEnrolled = false, this.rating = 4.9, this.reviewCount = 0}): super._();
  factory _CourseModel.fromJson(Map<String, dynamic> json) => _$CourseModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? code;
@override final  String? description;
@override final  String? category;
@override final  String? categoryName;
@override@JsonKey() final  String difficulty;
@override final  String? difficultyName;
@override@JsonKey(name: 'thumbnailUrl') final  String? imageUrl;
@override@JsonKey() final  int totalLessons;
@override@JsonKey() final  int totalModules;
@override@JsonKey(name: 'myProgressPercent', fromJson: _progressFromJson) final  double progress;
@override@JsonKey() final  bool isPremium;
@override final  String? creatorName;
@override@JsonKey() final  bool isEnrolled;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;

/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseModelCopyWith<_CourseModel> get copyWith => __$CourseModelCopyWithImpl<_CourseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.difficultyName, difficultyName) || other.difficultyName == difficultyName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.totalLessons, totalLessons) || other.totalLessons == totalLessons)&&(identical(other.totalModules, totalModules) || other.totalModules == totalModules)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.isEnrolled, isEnrolled) || other.isEnrolled == isEnrolled)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,code,description,category,categoryName,difficulty,difficultyName,imageUrl,totalLessons,totalModules,progress,isPremium,creatorName,isEnrolled,rating,reviewCount);

@override
String toString() {
  return 'CourseModel(id: $id, title: $title, code: $code, description: $description, category: $category, categoryName: $categoryName, difficulty: $difficulty, difficultyName: $difficultyName, imageUrl: $imageUrl, totalLessons: $totalLessons, totalModules: $totalModules, progress: $progress, isPremium: $isPremium, creatorName: $creatorName, isEnrolled: $isEnrolled, rating: $rating, reviewCount: $reviewCount)';
}


}

/// @nodoc
abstract mixin class _$CourseModelCopyWith<$Res> implements $CourseModelCopyWith<$Res> {
  factory _$CourseModelCopyWith(_CourseModel value, $Res Function(_CourseModel) _then) = __$CourseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? code, String? description, String? category, String? categoryName, String difficulty, String? difficultyName,@JsonKey(name: 'thumbnailUrl') String? imageUrl, int totalLessons, int totalModules,@JsonKey(name: 'myProgressPercent', fromJson: _progressFromJson) double progress, bool isPremium, String? creatorName, bool isEnrolled, double rating, int reviewCount
});




}
/// @nodoc
class __$CourseModelCopyWithImpl<$Res>
    implements _$CourseModelCopyWith<$Res> {
  __$CourseModelCopyWithImpl(this._self, this._then);

  final _CourseModel _self;
  final $Res Function(_CourseModel) _then;

/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? code = freezed,Object? description = freezed,Object? category = freezed,Object? categoryName = freezed,Object? difficulty = null,Object? difficultyName = freezed,Object? imageUrl = freezed,Object? totalLessons = null,Object? totalModules = null,Object? progress = null,Object? isPremium = null,Object? creatorName = freezed,Object? isEnrolled = null,Object? rating = null,Object? reviewCount = null,}) {
  return _then(_CourseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,difficultyName: freezed == difficultyName ? _self.difficultyName : difficultyName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,totalLessons: null == totalLessons ? _self.totalLessons : totalLessons // ignore: cast_nullable_to_non_nullable
as int,totalModules: null == totalModules ? _self.totalModules : totalModules // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,creatorName: freezed == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String?,isEnrolled: null == isEnrolled ? _self.isEnrolled : isEnrolled // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
