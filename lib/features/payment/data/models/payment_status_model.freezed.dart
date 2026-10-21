// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentStatusModel {

 int get orderCode; int get amount; String get status; String get plan;
/// Create a copy of PaymentStatusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentStatusModelCopyWith<PaymentStatusModel> get copyWith => _$PaymentStatusModelCopyWithImpl<PaymentStatusModel>(this as PaymentStatusModel, _$identity);

  /// Serializes this PaymentStatusModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentStatusModel&&(identical(other.orderCode, orderCode) || other.orderCode == orderCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderCode,amount,status,plan);

@override
String toString() {
  return 'PaymentStatusModel(orderCode: $orderCode, amount: $amount, status: $status, plan: $plan)';
}


}

/// @nodoc
abstract mixin class $PaymentStatusModelCopyWith<$Res>  {
  factory $PaymentStatusModelCopyWith(PaymentStatusModel value, $Res Function(PaymentStatusModel) _then) = _$PaymentStatusModelCopyWithImpl;
@useResult
$Res call({
 int orderCode, int amount, String status, String plan
});




}
/// @nodoc
class _$PaymentStatusModelCopyWithImpl<$Res>
    implements $PaymentStatusModelCopyWith<$Res> {
  _$PaymentStatusModelCopyWithImpl(this._self, this._then);

  final PaymentStatusModel _self;
  final $Res Function(PaymentStatusModel) _then;

/// Create a copy of PaymentStatusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderCode = null,Object? amount = null,Object? status = null,Object? plan = null,}) {
  return _then(_self.copyWith(
orderCode: null == orderCode ? _self.orderCode : orderCode // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentStatusModel].
extension PaymentStatusModelPatterns on PaymentStatusModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentStatusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentStatusModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentStatusModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentStatusModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentStatusModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentStatusModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int orderCode,  int amount,  String status,  String plan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentStatusModel() when $default != null:
return $default(_that.orderCode,_that.amount,_that.status,_that.plan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int orderCode,  int amount,  String status,  String plan)  $default,) {final _that = this;
switch (_that) {
case _PaymentStatusModel():
return $default(_that.orderCode,_that.amount,_that.status,_that.plan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int orderCode,  int amount,  String status,  String plan)?  $default,) {final _that = this;
switch (_that) {
case _PaymentStatusModel() when $default != null:
return $default(_that.orderCode,_that.amount,_that.status,_that.plan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentStatusModel extends PaymentStatusModel {
  const _PaymentStatusModel({required this.orderCode, required this.amount, required this.status, this.plan = ''}): super._();
  factory _PaymentStatusModel.fromJson(Map<String, dynamic> json) => _$PaymentStatusModelFromJson(json);

@override final  int orderCode;
@override final  int amount;
@override final  String status;
@override@JsonKey() final  String plan;

/// Create a copy of PaymentStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentStatusModelCopyWith<_PaymentStatusModel> get copyWith => __$PaymentStatusModelCopyWithImpl<_PaymentStatusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentStatusModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentStatusModel&&(identical(other.orderCode, orderCode) || other.orderCode == orderCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderCode,amount,status,plan);

@override
String toString() {
  return 'PaymentStatusModel(orderCode: $orderCode, amount: $amount, status: $status, plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$PaymentStatusModelCopyWith<$Res> implements $PaymentStatusModelCopyWith<$Res> {
  factory _$PaymentStatusModelCopyWith(_PaymentStatusModel value, $Res Function(_PaymentStatusModel) _then) = __$PaymentStatusModelCopyWithImpl;
@override @useResult
$Res call({
 int orderCode, int amount, String status, String plan
});




}
/// @nodoc
class __$PaymentStatusModelCopyWithImpl<$Res>
    implements _$PaymentStatusModelCopyWith<$Res> {
  __$PaymentStatusModelCopyWithImpl(this._self, this._then);

  final _PaymentStatusModel _self;
  final $Res Function(_PaymentStatusModel) _then;

/// Create a copy of PaymentStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderCode = null,Object? amount = null,Object? status = null,Object? plan = null,}) {
  return _then(_PaymentStatusModel(
orderCode: null == orderCode ? _self.orderCode : orderCode // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
