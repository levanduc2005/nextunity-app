// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentResultEntity {

 int get orderCode; String get checkoutUrl; String get qrCode; int get amount; String get plan; DateTime? get expiresAt;
/// Create a copy of PaymentResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentResultEntityCopyWith<PaymentResultEntity> get copyWith => _$PaymentResultEntityCopyWithImpl<PaymentResultEntity>(this as PaymentResultEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentResultEntity&&(identical(other.orderCode, orderCode) || other.orderCode == orderCode)&&(identical(other.checkoutUrl, checkoutUrl) || other.checkoutUrl == checkoutUrl)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,orderCode,checkoutUrl,qrCode,amount,plan,expiresAt);

@override
String toString() {
  return 'PaymentResultEntity(orderCode: $orderCode, checkoutUrl: $checkoutUrl, qrCode: $qrCode, amount: $amount, plan: $plan, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $PaymentResultEntityCopyWith<$Res>  {
  factory $PaymentResultEntityCopyWith(PaymentResultEntity value, $Res Function(PaymentResultEntity) _then) = _$PaymentResultEntityCopyWithImpl;
@useResult
$Res call({
 int orderCode, String checkoutUrl, String qrCode, int amount, String plan, DateTime? expiresAt
});




}
/// @nodoc
class _$PaymentResultEntityCopyWithImpl<$Res>
    implements $PaymentResultEntityCopyWith<$Res> {
  _$PaymentResultEntityCopyWithImpl(this._self, this._then);

  final PaymentResultEntity _self;
  final $Res Function(PaymentResultEntity) _then;

/// Create a copy of PaymentResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderCode = null,Object? checkoutUrl = null,Object? qrCode = null,Object? amount = null,Object? plan = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
orderCode: null == orderCode ? _self.orderCode : orderCode // ignore: cast_nullable_to_non_nullable
as int,checkoutUrl: null == checkoutUrl ? _self.checkoutUrl : checkoutUrl // ignore: cast_nullable_to_non_nullable
as String,qrCode: null == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentResultEntity].
extension PaymentResultEntityPatterns on PaymentResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _PaymentResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int orderCode,  String checkoutUrl,  String qrCode,  int amount,  String plan,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentResultEntity() when $default != null:
return $default(_that.orderCode,_that.checkoutUrl,_that.qrCode,_that.amount,_that.plan,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int orderCode,  String checkoutUrl,  String qrCode,  int amount,  String plan,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _PaymentResultEntity():
return $default(_that.orderCode,_that.checkoutUrl,_that.qrCode,_that.amount,_that.plan,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int orderCode,  String checkoutUrl,  String qrCode,  int amount,  String plan,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _PaymentResultEntity() when $default != null:
return $default(_that.orderCode,_that.checkoutUrl,_that.qrCode,_that.amount,_that.plan,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentResultEntity implements PaymentResultEntity {
  const _PaymentResultEntity({required this.orderCode, required this.checkoutUrl, required this.qrCode, required this.amount, required this.plan, this.expiresAt});
  

@override final  int orderCode;
@override final  String checkoutUrl;
@override final  String qrCode;
@override final  int amount;
@override final  String plan;
@override final  DateTime? expiresAt;

/// Create a copy of PaymentResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentResultEntityCopyWith<_PaymentResultEntity> get copyWith => __$PaymentResultEntityCopyWithImpl<_PaymentResultEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentResultEntity&&(identical(other.orderCode, orderCode) || other.orderCode == orderCode)&&(identical(other.checkoutUrl, checkoutUrl) || other.checkoutUrl == checkoutUrl)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,orderCode,checkoutUrl,qrCode,amount,plan,expiresAt);

@override
String toString() {
  return 'PaymentResultEntity(orderCode: $orderCode, checkoutUrl: $checkoutUrl, qrCode: $qrCode, amount: $amount, plan: $plan, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$PaymentResultEntityCopyWith<$Res> implements $PaymentResultEntityCopyWith<$Res> {
  factory _$PaymentResultEntityCopyWith(_PaymentResultEntity value, $Res Function(_PaymentResultEntity) _then) = __$PaymentResultEntityCopyWithImpl;
@override @useResult
$Res call({
 int orderCode, String checkoutUrl, String qrCode, int amount, String plan, DateTime? expiresAt
});




}
/// @nodoc
class __$PaymentResultEntityCopyWithImpl<$Res>
    implements _$PaymentResultEntityCopyWith<$Res> {
  __$PaymentResultEntityCopyWithImpl(this._self, this._then);

  final _PaymentResultEntity _self;
  final $Res Function(_PaymentResultEntity) _then;

/// Create a copy of PaymentResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderCode = null,Object? checkoutUrl = null,Object? qrCode = null,Object? amount = null,Object? plan = null,Object? expiresAt = freezed,}) {
  return _then(_PaymentResultEntity(
orderCode: null == orderCode ? _self.orderCode : orderCode // ignore: cast_nullable_to_non_nullable
as int,checkoutUrl: null == checkoutUrl ? _self.checkoutUrl : checkoutUrl // ignore: cast_nullable_to_non_nullable
as String,qrCode: null == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
