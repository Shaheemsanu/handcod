// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authmodel_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Authmodel {

@JsonKey(name: 'id', includeIfNull: false) int? get id;
/// Create a copy of Authmodel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthmodelCopyWith<Authmodel> get copyWith => _$AuthmodelCopyWithImpl<Authmodel>(this as Authmodel, _$identity);

  /// Serializes this Authmodel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authmodel&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'Authmodel(id: $id)';
}


}

/// @nodoc
abstract mixin class $AuthmodelCopyWith<$Res>  {
  factory $AuthmodelCopyWith(Authmodel value, $Res Function(Authmodel) _then) = _$AuthmodelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id', includeIfNull: false) int? id
});




}
/// @nodoc
class _$AuthmodelCopyWithImpl<$Res>
    implements $AuthmodelCopyWith<$Res> {
  _$AuthmodelCopyWithImpl(this._self, this._then);

  final Authmodel _self;
  final $Res Function(Authmodel) _then;

/// Create a copy of Authmodel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Authmodel].
extension AuthmodelPatterns on Authmodel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Authmodel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Authmodel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Authmodel value)  $default,){
final _that = this;
switch (_that) {
case _Authmodel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Authmodel value)?  $default,){
final _that = this;
switch (_that) {
case _Authmodel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', includeIfNull: false)  int? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Authmodel() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', includeIfNull: false)  int? id)  $default,) {final _that = this;
switch (_that) {
case _Authmodel():
return $default(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id', includeIfNull: false)  int? id)?  $default,) {final _that = this;
switch (_that) {
case _Authmodel() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Authmodel implements Authmodel {
  const _Authmodel({@JsonKey(name: 'id', includeIfNull: false) this.id});
  factory _Authmodel.fromJson(Map<String, dynamic> json) => _$AuthmodelFromJson(json);

@override@JsonKey(name: 'id', includeIfNull: false) final  int? id;

/// Create a copy of Authmodel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthmodelCopyWith<_Authmodel> get copyWith => __$AuthmodelCopyWithImpl<_Authmodel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthmodelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authmodel&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'Authmodel(id: $id)';
}


}

/// @nodoc
abstract mixin class _$AuthmodelCopyWith<$Res> implements $AuthmodelCopyWith<$Res> {
  factory _$AuthmodelCopyWith(_Authmodel value, $Res Function(_Authmodel) _then) = __$AuthmodelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id', includeIfNull: false) int? id
});




}
/// @nodoc
class __$AuthmodelCopyWithImpl<$Res>
    implements _$AuthmodelCopyWith<$Res> {
  __$AuthmodelCopyWithImpl(this._self, this._then);

  final _Authmodel _self;
  final $Res Function(_Authmodel) _then;

/// Create a copy of Authmodel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,}) {
  return _then(_Authmodel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
