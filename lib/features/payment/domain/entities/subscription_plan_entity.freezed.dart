// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_plan_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionPlanEntity {

 String get code; String get name; int get price; int get durationDays; String get description;
/// Create a copy of SubscriptionPlanEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionPlanEntityCopyWith<SubscriptionPlanEntity> get copyWith => _$SubscriptionPlanEntityCopyWithImpl<SubscriptionPlanEntity>(this as SubscriptionPlanEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPlanEntity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,price,durationDays,description);

@override
String toString() {
  return 'SubscriptionPlanEntity(code: $code, name: $name, price: $price, durationDays: $durationDays, description: $description)';
}


}

/// @nodoc
abstract mixin class $SubscriptionPlanEntityCopyWith<$Res>  {
  factory $SubscriptionPlanEntityCopyWith(SubscriptionPlanEntity value, $Res Function(SubscriptionPlanEntity) _then) = _$SubscriptionPlanEntityCopyWithImpl;
@useResult
$Res call({
 String code, String name, int price, int durationDays, String description
});




}
/// @nodoc
class _$SubscriptionPlanEntityCopyWithImpl<$Res>
    implements $SubscriptionPlanEntityCopyWith<$Res> {
  _$SubscriptionPlanEntityCopyWithImpl(this._self, this._then);

  final SubscriptionPlanEntity _self;
  final $Res Function(SubscriptionPlanEntity) _then;

/// Create a copy of SubscriptionPlanEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? price = null,Object? durationDays = null,Object? description = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionPlanEntity].
extension SubscriptionPlanEntityPatterns on SubscriptionPlanEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionPlanEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionPlanEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionPlanEntity value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPlanEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionPlanEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPlanEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  int price,  int durationDays,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionPlanEntity() when $default != null:
return $default(_that.code,_that.name,_that.price,_that.durationDays,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  int price,  int durationDays,  String description)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPlanEntity():
return $default(_that.code,_that.name,_that.price,_that.durationDays,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  int price,  int durationDays,  String description)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPlanEntity() when $default != null:
return $default(_that.code,_that.name,_that.price,_that.durationDays,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _SubscriptionPlanEntity extends SubscriptionPlanEntity {
  const _SubscriptionPlanEntity({required this.code, required this.name, required this.price, required this.durationDays, required this.description}): super._();
  

@override final  String code;
@override final  String name;
@override final  int price;
@override final  int durationDays;
@override final  String description;

/// Create a copy of SubscriptionPlanEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionPlanEntityCopyWith<_SubscriptionPlanEntity> get copyWith => __$SubscriptionPlanEntityCopyWithImpl<_SubscriptionPlanEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionPlanEntity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,price,durationDays,description);

@override
String toString() {
  return 'SubscriptionPlanEntity(code: $code, name: $name, price: $price, durationDays: $durationDays, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionPlanEntityCopyWith<$Res> implements $SubscriptionPlanEntityCopyWith<$Res> {
  factory _$SubscriptionPlanEntityCopyWith(_SubscriptionPlanEntity value, $Res Function(_SubscriptionPlanEntity) _then) = __$SubscriptionPlanEntityCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, int price, int durationDays, String description
});




}
/// @nodoc
class __$SubscriptionPlanEntityCopyWithImpl<$Res>
    implements _$SubscriptionPlanEntityCopyWith<$Res> {
  __$SubscriptionPlanEntityCopyWithImpl(this._self, this._then);

  final _SubscriptionPlanEntity _self;
  final $Res Function(_SubscriptionPlanEntity) _then;

/// Create a copy of SubscriptionPlanEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? price = null,Object? durationDays = null,Object? description = null,}) {
  return _then(_SubscriptionPlanEntity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
