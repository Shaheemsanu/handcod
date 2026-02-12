// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IPModel {

 String get country;
/// Create a copy of IPModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IPModelCopyWith<IPModel> get copyWith => _$IPModelCopyWithImpl<IPModel>(this as IPModel, _$identity);

  /// Serializes this IPModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IPModel&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country);

@override
String toString() {
  return 'IPModel(country: $country)';
}


}

/// @nodoc
abstract mixin class $IPModelCopyWith<$Res>  {
  factory $IPModelCopyWith(IPModel value, $Res Function(IPModel) _then) = _$IPModelCopyWithImpl;
@useResult
$Res call({
 String country
});




}
/// @nodoc
class _$IPModelCopyWithImpl<$Res>
    implements $IPModelCopyWith<$Res> {
  _$IPModelCopyWithImpl(this._self, this._then);

  final IPModel _self;
  final $Res Function(IPModel) _then;

/// Create a copy of IPModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? country = null,}) {
  return _then(_self.copyWith(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IPModel].
extension IPModelPatterns on IPModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IPModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IPModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IPModel value)  $default,){
final _that = this;
switch (_that) {
case _IPModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IPModel value)?  $default,){
final _that = this;
switch (_that) {
case _IPModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IPModel() when $default != null:
return $default(_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String country)  $default,) {final _that = this;
switch (_that) {
case _IPModel():
return $default(_that.country);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String country)?  $default,) {final _that = this;
switch (_that) {
case _IPModel() when $default != null:
return $default(_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IPModel extends IPModel {
  const _IPModel({this.country = 'IN'}): super._();
  factory _IPModel.fromJson(Map<String, dynamic> json) => _$IPModelFromJson(json);

@override@JsonKey() final  String country;

/// Create a copy of IPModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IPModelCopyWith<_IPModel> get copyWith => __$IPModelCopyWithImpl<_IPModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IPModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IPModel&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country);

@override
String toString() {
  return 'IPModel(country: $country)';
}


}

/// @nodoc
abstract mixin class _$IPModelCopyWith<$Res> implements $IPModelCopyWith<$Res> {
  factory _$IPModelCopyWith(_IPModel value, $Res Function(_IPModel) _then) = __$IPModelCopyWithImpl;
@override @useResult
$Res call({
 String country
});




}
/// @nodoc
class __$IPModelCopyWithImpl<$Res>
    implements _$IPModelCopyWith<$Res> {
  __$IPModelCopyWithImpl(this._self, this._then);

  final _IPModel _self;
  final $Res Function(_IPModel) _then;

/// Create a copy of IPModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? country = null,}) {
  return _then(_IPModel(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
