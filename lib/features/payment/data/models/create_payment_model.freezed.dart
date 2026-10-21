// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatePaymentModel {

 int get orderCode; String get checkoutUrl; String get qrCode; int get amount; String get plan; DateTime? get expiresAt;
/// Create a copy of CreatePaymentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePaymentModelCopyWith<CreatePaymentModel> get copyWith => _$CreatePaymentModelCopyWithImpl<CreatePaymentModel>(this as CreatePaymentModel, _$identity);

  /// Serializes this CreatePaymentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePaymentModel&&(identical(other.orderCode, orderCode) || other.orderCode == orderCode)&&(identical(other.checkoutUrl, checkoutUrl) || other.checkoutUrl == checkoutUrl)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderCode,checkoutUrl,qrCode,amount,plan,expiresAt);

@override
String toString() {
  return 'CreatePaymentModel(orderCode: $orderCode, checkoutUrl: $checkoutUrl, qrCode: $qrCode, amount: $amount, plan: $plan, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $CreatePaymentModelCopyWith<$Res>  {
  factory $CreatePaymentModelCopyWith(CreatePaymentModel value, $Res Function(CreatePaymentModel) _then) = _$CreatePaymentModelCopyWithImpl;
@useResult
$Res call({
 int orderCode, String checkoutUrl, String qrCode, int amount, String plan, DateTime? expiresAt
});




}
/// @nodoc
class _$CreatePaymentModelCopyWithImpl<$Res>
    implements $CreatePaymentModelCopyWith<$Res> {
  _$CreatePaymentModelCopyWithImpl(this._self, this._then);

  final CreatePaymentModel _self;
  final $Res Function(CreatePaymentModel) _then;

/// Create a copy of CreatePaymentModel
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


/// Adds pattern-matching-related methods to [CreatePaymentModel].
extension CreatePaymentModelPatterns on CreatePaymentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePaymentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePaymentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePaymentModel value)  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePaymentModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentModel() when $default != null:
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
case _CreatePaymentModel() when $default != null:
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
case _CreatePaymentModel():
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
case _CreatePaymentModel() when $default != null:
return $default(_that.orderCode,_that.checkoutUrl,_that.qrCode,_that.amount,_that.plan,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePaymentModel extends CreatePaymentModel {
  const _CreatePaymentModel({required this.orderCode, required this.checkoutUrl, required this.qrCode, required this.amount, required this.plan, this.expiresAt}): super._();
  factory _CreatePaymentModel.fromJson(Map<String, dynamic> json) => _$CreatePaymentModelFromJson(json);

@override final  int orderCode;
@override final  String checkoutUrl;
@override final  String qrCode;
@override final  int amount;
@override final  String plan;
@override final  DateTime? expiresAt;

/// Create a copy of CreatePaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePaymentModelCopyWith<_CreatePaymentModel> get copyWith => __$CreatePaymentModelCopyWithImpl<_CreatePaymentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePaymentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePaymentModel&&(identical(other.orderCode, orderCode) || other.orderCode == orderCode)&&(identical(other.checkoutUrl, checkoutUrl) || other.checkoutUrl == checkoutUrl)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderCode,checkoutUrl,qrCode,amount,plan,expiresAt);

@override
String toString() {
  return 'CreatePaymentModel(orderCode: $orderCode, checkoutUrl: $checkoutUrl, qrCode: $qrCode, amount: $amount, plan: $plan, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$CreatePaymentModelCopyWith<$Res> implements $CreatePaymentModelCopyWith<$Res> {
  factory _$CreatePaymentModelCopyWith(_CreatePaymentModel value, $Res Function(_CreatePaymentModel) _then) = __$CreatePaymentModelCopyWithImpl;
@override @useResult
$Res call({
 int orderCode, String checkoutUrl, String qrCode, int amount, String plan, DateTime? expiresAt
});




}
/// @nodoc
class __$CreatePaymentModelCopyWithImpl<$Res>
    implements _$CreatePaymentModelCopyWith<$Res> {
  __$CreatePaymentModelCopyWithImpl(this._self, this._then);

  final _CreatePaymentModel _self;
  final $Res Function(_CreatePaymentModel) _then;

/// Create a copy of CreatePaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderCode = null,Object? checkoutUrl = null,Object? qrCode = null,Object? amount = null,Object? plan = null,Object? expiresAt = freezed,}) {
  return _then(_CreatePaymentModel(
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
