// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionPlanModel {

 String get code; String get name; int get price; int get durationDays; String get description;
/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionPlanModelCopyWith<SubscriptionPlanModel> get copyWith => _$SubscriptionPlanModelCopyWithImpl<SubscriptionPlanModel>(this as SubscriptionPlanModel, _$identity);

  /// Serializes this SubscriptionPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPlanModel&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,price,durationDays,description);

@override
String toString() {
  return 'SubscriptionPlanModel(code: $code, name: $name, price: $price, durationDays: $durationDays, description: $description)';
}


}

/// @nodoc
abstract mixin class $SubscriptionPlanModelCopyWith<$Res>  {
  factory $SubscriptionPlanModelCopyWith(SubscriptionPlanModel value, $Res Function(SubscriptionPlanModel) _then) = _$SubscriptionPlanModelCopyWithImpl;
@useResult
$Res call({
 String code, String name, int price, int durationDays, String description
});




}
/// @nodoc
class _$SubscriptionPlanModelCopyWithImpl<$Res>
    implements $SubscriptionPlanModelCopyWith<$Res> {
  _$SubscriptionPlanModelCopyWithImpl(this._self, this._then);

  final SubscriptionPlanModel _self;
  final $Res Function(SubscriptionPlanModel) _then;

/// Create a copy of SubscriptionPlanModel
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


/// Adds pattern-matching-related methods to [SubscriptionPlanModel].
extension SubscriptionPlanModelPatterns on SubscriptionPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
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
case _SubscriptionPlanModel() when $default != null:
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
case _SubscriptionPlanModel():
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
case _SubscriptionPlanModel() when $default != null:
return $default(_that.code,_that.name,_that.price,_that.durationDays,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionPlanModel extends SubscriptionPlanModel {
  const _SubscriptionPlanModel({required this.code, required this.name, required this.price, this.durationDays = 30, this.description = ''}): super._();
  factory _SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanModelFromJson(json);

@override final  String code;
@override final  String name;
@override final  int price;
@override@JsonKey() final  int durationDays;
@override@JsonKey() final  String description;

/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionPlanModelCopyWith<_SubscriptionPlanModel> get copyWith => __$SubscriptionPlanModelCopyWithImpl<_SubscriptionPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionPlanModel&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,price,durationDays,description);

@override
String toString() {
  return 'SubscriptionPlanModel(code: $code, name: $name, price: $price, durationDays: $durationDays, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionPlanModelCopyWith<$Res> implements $SubscriptionPlanModelCopyWith<$Res> {
  factory _$SubscriptionPlanModelCopyWith(_SubscriptionPlanModel value, $Res Function(_SubscriptionPlanModel) _then) = __$SubscriptionPlanModelCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, int price, int durationDays, String description
});




}
/// @nodoc
class __$SubscriptionPlanModelCopyWithImpl<$Res>
    implements _$SubscriptionPlanModelCopyWith<$Res> {
  __$SubscriptionPlanModelCopyWithImpl(this._self, this._then);

  final _SubscriptionPlanModel _self;
  final $Res Function(_SubscriptionPlanModel) _then;

/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? price = null,Object? durationDays = null,Object? description = null,}) {
  return _then(_SubscriptionPlanModel(
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
