// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_status_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentStatusEntity {

 int get orderCode; int get amount; String get status; String get plan; bool get isPaid;
/// Create a copy of PaymentStatusEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentStatusEntityCopyWith<PaymentStatusEntity> get copyWith => _$PaymentStatusEntityCopyWithImpl<PaymentStatusEntity>(this as PaymentStatusEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentStatusEntity&&(identical(other.orderCode, orderCode) || other.orderCode == orderCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid));
}


@override
int get hashCode => Object.hash(runtimeType,orderCode,amount,status,plan,isPaid);

@override
String toString() {
  return 'PaymentStatusEntity(orderCode: $orderCode, amount: $amount, status: $status, plan: $plan, isPaid: $isPaid)';
}


}

/// @nodoc
abstract mixin class $PaymentStatusEntityCopyWith<$Res>  {
  factory $PaymentStatusEntityCopyWith(PaymentStatusEntity value, $Res Function(PaymentStatusEntity) _then) = _$PaymentStatusEntityCopyWithImpl;
@useResult
$Res call({
 int orderCode, int amount, String status, String plan, bool isPaid
});




}
/// @nodoc
class _$PaymentStatusEntityCopyWithImpl<$Res>
    implements $PaymentStatusEntityCopyWith<$Res> {
  _$PaymentStatusEntityCopyWithImpl(this._self, this._then);

  final PaymentStatusEntity _self;
  final $Res Function(PaymentStatusEntity) _then;

/// Create a copy of PaymentStatusEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderCode = null,Object? amount = null,Object? status = null,Object? plan = null,Object? isPaid = null,}) {
  return _then(_self.copyWith(
orderCode: null == orderCode ? _self.orderCode : orderCode // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentStatusEntity].
extension PaymentStatusEntityPatterns on PaymentStatusEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentStatusEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentStatusEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentStatusEntity value)  $default,){
final _that = this;
switch (_that) {
case _PaymentStatusEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentStatusEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentStatusEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int orderCode,  int amount,  String status,  String plan,  bool isPaid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentStatusEntity() when $default != null:
return $default(_that.orderCode,_that.amount,_that.status,_that.plan,_that.isPaid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int orderCode,  int amount,  String status,  String plan,  bool isPaid)  $default,) {final _that = this;
switch (_that) {
case _PaymentStatusEntity():
return $default(_that.orderCode,_that.amount,_that.status,_that.plan,_that.isPaid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int orderCode,  int amount,  String status,  String plan,  bool isPaid)?  $default,) {final _that = this;
switch (_that) {
case _PaymentStatusEntity() when $default != null:
return $default(_that.orderCode,_that.amount,_that.status,_that.plan,_that.isPaid);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentStatusEntity implements PaymentStatusEntity {
  const _PaymentStatusEntity({required this.orderCode, required this.amount, required this.status, required this.plan, required this.isPaid});
  

@override final  int orderCode;
@override final  int amount;
@override final  String status;
@override final  String plan;
@override final  bool isPaid;

/// Create a copy of PaymentStatusEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentStatusEntityCopyWith<_PaymentStatusEntity> get copyWith => __$PaymentStatusEntityCopyWithImpl<_PaymentStatusEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentStatusEntity&&(identical(other.orderCode, orderCode) || other.orderCode == orderCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid));
}


@override
int get hashCode => Object.hash(runtimeType,orderCode,amount,status,plan,isPaid);

@override
String toString() {
  return 'PaymentStatusEntity(orderCode: $orderCode, amount: $amount, status: $status, plan: $plan, isPaid: $isPaid)';
}


}

/// @nodoc
abstract mixin class _$PaymentStatusEntityCopyWith<$Res> implements $PaymentStatusEntityCopyWith<$Res> {
  factory _$PaymentStatusEntityCopyWith(_PaymentStatusEntity value, $Res Function(_PaymentStatusEntity) _then) = __$PaymentStatusEntityCopyWithImpl;
@override @useResult
$Res call({
 int orderCode, int amount, String status, String plan, bool isPaid
});




}
/// @nodoc
class __$PaymentStatusEntityCopyWithImpl<$Res>
    implements _$PaymentStatusEntityCopyWith<$Res> {
  __$PaymentStatusEntityCopyWithImpl(this._self, this._then);

  final _PaymentStatusEntity _self;
  final $Res Function(_PaymentStatusEntity) _then;

/// Create a copy of PaymentStatusEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderCode = null,Object? amount = null,Object? status = null,Object? plan = null,Object? isPaid = null,}) {
  return _then(_PaymentStatusEntity(
orderCode: null == orderCode ? _self.orderCode : orderCode // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
