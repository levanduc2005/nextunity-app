// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEntity {

 String get email; String? get id; String? get fullName; String? get university; String? get studentId; String? get avatarUrl; int get points; int get streak; String? get gender; String? get genderName; DateTime? get dateOfBirth; int? get cohort; String? get major; String? get bio; String get role; String get subscriptionTier; DateTime? get premiumUntil; bool get isPlus; DateTime? get createdAt;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.university, university) || other.university == university)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.points, points) || other.points == points)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.genderName, genderName) || other.genderName == genderName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.cohort, cohort) || other.cohort == cohort)&&(identical(other.major, major) || other.major == major)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.role, role) || other.role == role)&&(identical(other.subscriptionTier, subscriptionTier) || other.subscriptionTier == subscriptionTier)&&(identical(other.premiumUntil, premiumUntil) || other.premiumUntil == premiumUntil)&&(identical(other.isPlus, isPlus) || other.isPlus == isPlus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,email,id,fullName,university,studentId,avatarUrl,points,streak,gender,genderName,dateOfBirth,cohort,major,bio,role,subscriptionTier,premiumUntil,isPlus,createdAt]);

@override
String toString() {
  return 'UserEntity(email: $email, id: $id, fullName: $fullName, university: $university, studentId: $studentId, avatarUrl: $avatarUrl, points: $points, streak: $streak, gender: $gender, genderName: $genderName, dateOfBirth: $dateOfBirth, cohort: $cohort, major: $major, bio: $bio, role: $role, subscriptionTier: $subscriptionTier, premiumUntil: $premiumUntil, isPlus: $isPlus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 String email, String? id, String? fullName, String? university, String? studentId, String? avatarUrl, int points, int streak, String? gender, String? genderName, DateTime? dateOfBirth, int? cohort, String? major, String? bio, String role, String subscriptionTier, DateTime? premiumUntil, bool isPlus, DateTime? createdAt
});




}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? id = freezed,Object? fullName = freezed,Object? university = freezed,Object? studentId = freezed,Object? avatarUrl = freezed,Object? points = null,Object? streak = null,Object? gender = freezed,Object? genderName = freezed,Object? dateOfBirth = freezed,Object? cohort = freezed,Object? major = freezed,Object? bio = freezed,Object? role = null,Object? subscriptionTier = null,Object? premiumUntil = freezed,Object? isPlus = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,university: freezed == university ? _self.university : university // ignore: cast_nullable_to_non_nullable
as String?,studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,genderName: freezed == genderName ? _self.genderName : genderName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,cohort: freezed == cohort ? _self.cohort : cohort // ignore: cast_nullable_to_non_nullable
as int?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,subscriptionTier: null == subscriptionTier ? _self.subscriptionTier : subscriptionTier // ignore: cast_nullable_to_non_nullable
as String,premiumUntil: freezed == premiumUntil ? _self.premiumUntil : premiumUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,isPlus: null == isPlus ? _self.isPlus : isPlus // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String? id,  String? fullName,  String? university,  String? studentId,  String? avatarUrl,  int points,  int streak,  String? gender,  String? genderName,  DateTime? dateOfBirth,  int? cohort,  String? major,  String? bio,  String role,  String subscriptionTier,  DateTime? premiumUntil,  bool isPlus,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.email,_that.id,_that.fullName,_that.university,_that.studentId,_that.avatarUrl,_that.points,_that.streak,_that.gender,_that.genderName,_that.dateOfBirth,_that.cohort,_that.major,_that.bio,_that.role,_that.subscriptionTier,_that.premiumUntil,_that.isPlus,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String? id,  String? fullName,  String? university,  String? studentId,  String? avatarUrl,  int points,  int streak,  String? gender,  String? genderName,  DateTime? dateOfBirth,  int? cohort,  String? major,  String? bio,  String role,  String subscriptionTier,  DateTime? premiumUntil,  bool isPlus,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.email,_that.id,_that.fullName,_that.university,_that.studentId,_that.avatarUrl,_that.points,_that.streak,_that.gender,_that.genderName,_that.dateOfBirth,_that.cohort,_that.major,_that.bio,_that.role,_that.subscriptionTier,_that.premiumUntil,_that.isPlus,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String? id,  String? fullName,  String? university,  String? studentId,  String? avatarUrl,  int points,  int streak,  String? gender,  String? genderName,  DateTime? dateOfBirth,  int? cohort,  String? major,  String? bio,  String role,  String subscriptionTier,  DateTime? premiumUntil,  bool isPlus,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.email,_that.id,_that.fullName,_that.university,_that.studentId,_that.avatarUrl,_that.points,_that.streak,_that.gender,_that.genderName,_that.dateOfBirth,_that.cohort,_that.major,_that.bio,_that.role,_that.subscriptionTier,_that.premiumUntil,_that.isPlus,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _UserEntity extends UserEntity {
  const _UserEntity({required this.email, this.id, this.fullName, this.university, this.studentId, this.avatarUrl, this.points = 0, this.streak = 0, this.gender, this.genderName, this.dateOfBirth, this.cohort, this.major, this.bio, this.role = 'STUDENT', this.subscriptionTier = 'FREE', this.premiumUntil, this.isPlus = false, this.createdAt}): super._();
  

@override final  String email;
@override final  String? id;
@override final  String? fullName;
@override final  String? university;
@override final  String? studentId;
@override final  String? avatarUrl;
@override@JsonKey() final  int points;
@override@JsonKey() final  int streak;
@override final  String? gender;
@override final  String? genderName;
@override final  DateTime? dateOfBirth;
@override final  int? cohort;
@override final  String? major;
@override final  String? bio;
@override@JsonKey() final  String role;
@override@JsonKey() final  String subscriptionTier;
@override final  DateTime? premiumUntil;
@override@JsonKey() final  bool isPlus;
@override final  DateTime? createdAt;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.university, university) || other.university == university)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.points, points) || other.points == points)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.genderName, genderName) || other.genderName == genderName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.cohort, cohort) || other.cohort == cohort)&&(identical(other.major, major) || other.major == major)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.role, role) || other.role == role)&&(identical(other.subscriptionTier, subscriptionTier) || other.subscriptionTier == subscriptionTier)&&(identical(other.premiumUntil, premiumUntil) || other.premiumUntil == premiumUntil)&&(identical(other.isPlus, isPlus) || other.isPlus == isPlus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,email,id,fullName,university,studentId,avatarUrl,points,streak,gender,genderName,dateOfBirth,cohort,major,bio,role,subscriptionTier,premiumUntil,isPlus,createdAt]);

@override
String toString() {
  return 'UserEntity(email: $email, id: $id, fullName: $fullName, university: $university, studentId: $studentId, avatarUrl: $avatarUrl, points: $points, streak: $streak, gender: $gender, genderName: $genderName, dateOfBirth: $dateOfBirth, cohort: $cohort, major: $major, bio: $bio, role: $role, subscriptionTier: $subscriptionTier, premiumUntil: $premiumUntil, isPlus: $isPlus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 String email, String? id, String? fullName, String? university, String? studentId, String? avatarUrl, int points, int streak, String? gender, String? genderName, DateTime? dateOfBirth, int? cohort, String? major, String? bio, String role, String subscriptionTier, DateTime? premiumUntil, bool isPlus, DateTime? createdAt
});




}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? id = freezed,Object? fullName = freezed,Object? university = freezed,Object? studentId = freezed,Object? avatarUrl = freezed,Object? points = null,Object? streak = null,Object? gender = freezed,Object? genderName = freezed,Object? dateOfBirth = freezed,Object? cohort = freezed,Object? major = freezed,Object? bio = freezed,Object? role = null,Object? subscriptionTier = null,Object? premiumUntil = freezed,Object? isPlus = null,Object? createdAt = freezed,}) {
  return _then(_UserEntity(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,university: freezed == university ? _self.university : university // ignore: cast_nullable_to_non_nullable
as String?,studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,genderName: freezed == genderName ? _self.genderName : genderName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,cohort: freezed == cohort ? _self.cohort : cohort // ignore: cast_nullable_to_non_nullable
as int?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,subscriptionTier: null == subscriptionTier ? _self.subscriptionTier : subscriptionTier // ignore: cast_nullable_to_non_nullable
as String,premiumUntil: freezed == premiumUntil ? _self.premiumUntil : premiumUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,isPlus: null == isPlus ? _self.isPlus : isPlus // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
