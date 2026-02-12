// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceState {

 List<Servicemodel> get services; ServiceStatus get status; bool get isUploading; String? get error;
/// Create a copy of ServiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceStateCopyWith<ServiceState> get copyWith => _$ServiceStateCopyWithImpl<ServiceState>(this as ServiceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceState&&const DeepCollectionEquality().equals(other.services, services)&&(identical(other.status, status) || other.status == status)&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(services),status,isUploading,error);

@override
String toString() {
  return 'ServiceState(services: $services, status: $status, isUploading: $isUploading, error: $error)';
}


}

/// @nodoc
abstract mixin class $ServiceStateCopyWith<$Res>  {
  factory $ServiceStateCopyWith(ServiceState value, $Res Function(ServiceState) _then) = _$ServiceStateCopyWithImpl;
@useResult
$Res call({
 List<Servicemodel> services, ServiceStatus status, bool isUploading, String? error
});




}
/// @nodoc
class _$ServiceStateCopyWithImpl<$Res>
    implements $ServiceStateCopyWith<$Res> {
  _$ServiceStateCopyWithImpl(this._self, this._then);

  final ServiceState _self;
  final $Res Function(ServiceState) _then;

/// Create a copy of ServiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? services = null,Object? status = null,Object? isUploading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<Servicemodel>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceStatus,isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceState].
extension ServiceStatePatterns on ServiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceState value)  $default,){
final _that = this;
switch (_that) {
case _ServiceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceState value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Servicemodel> services,  ServiceStatus status,  bool isUploading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceState() when $default != null:
return $default(_that.services,_that.status,_that.isUploading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Servicemodel> services,  ServiceStatus status,  bool isUploading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ServiceState():
return $default(_that.services,_that.status,_that.isUploading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Servicemodel> services,  ServiceStatus status,  bool isUploading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ServiceState() when $default != null:
return $default(_that.services,_that.status,_that.isUploading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceState implements ServiceState {
  const _ServiceState({final  List<Servicemodel> services = const [], this.status = ServiceStatus.initial, this.isUploading = false, this.error}): _services = services;
  

 final  List<Servicemodel> _services;
@override@JsonKey() List<Servicemodel> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

@override@JsonKey() final  ServiceStatus status;
@override@JsonKey() final  bool isUploading;
@override final  String? error;

/// Create a copy of ServiceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceStateCopyWith<_ServiceState> get copyWith => __$ServiceStateCopyWithImpl<_ServiceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceState&&const DeepCollectionEquality().equals(other._services, _services)&&(identical(other.status, status) || other.status == status)&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_services),status,isUploading,error);

@override
String toString() {
  return 'ServiceState(services: $services, status: $status, isUploading: $isUploading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ServiceStateCopyWith<$Res> implements $ServiceStateCopyWith<$Res> {
  factory _$ServiceStateCopyWith(_ServiceState value, $Res Function(_ServiceState) _then) = __$ServiceStateCopyWithImpl;
@override @useResult
$Res call({
 List<Servicemodel> services, ServiceStatus status, bool isUploading, String? error
});




}
/// @nodoc
class __$ServiceStateCopyWithImpl<$Res>
    implements _$ServiceStateCopyWith<$Res> {
  __$ServiceStateCopyWithImpl(this._self, this._then);

  final _ServiceState _self;
  final $Res Function(_ServiceState) _then;

/// Create a copy of ServiceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? services = null,Object? status = null,Object? isUploading = null,Object? error = freezed,}) {
  return _then(_ServiceState(
services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<Servicemodel>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceStatus,isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
