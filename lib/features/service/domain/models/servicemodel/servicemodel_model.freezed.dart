// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'servicemodel_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Servicemodel {

@JsonKey(name: 'id', includeIfNull: false) int? get id;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'name') String? get name;@JsonKey(name: 'quantity') int get quantity;@JsonKey(name: 'stock') int? get stock;@JsonKey(name: 'order') int? get order;@JsonKey(name: 'category') String? get category;@JsonKey(name: 'price') int? get price;@JsonKey(name: 'image') String? get image;
/// Create a copy of Servicemodel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicemodelCopyWith<Servicemodel> get copyWith => _$ServicemodelCopyWithImpl<Servicemodel>(this as Servicemodel, _$identity);

  /// Serializes this Servicemodel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Servicemodel&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.order, order) || other.order == order)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,name,quantity,stock,order,category,price,image);

@override
String toString() {
  return 'Servicemodel(id: $id, createdAt: $createdAt, name: $name, quantity: $quantity, stock: $stock, order: $order, category: $category, price: $price, image: $image)';
}


}

/// @nodoc
abstract mixin class $ServicemodelCopyWith<$Res>  {
  factory $ServicemodelCopyWith(Servicemodel value, $Res Function(Servicemodel) _then) = _$ServicemodelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id', includeIfNull: false) int? id,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'name') String? name,@JsonKey(name: 'quantity') int quantity,@JsonKey(name: 'stock') int? stock,@JsonKey(name: 'order') int? order,@JsonKey(name: 'category') String? category,@JsonKey(name: 'price') int? price,@JsonKey(name: 'image') String? image
});




}
/// @nodoc
class _$ServicemodelCopyWithImpl<$Res>
    implements $ServicemodelCopyWith<$Res> {
  _$ServicemodelCopyWithImpl(this._self, this._then);

  final Servicemodel _self;
  final $Res Function(Servicemodel) _then;

/// Create a copy of Servicemodel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? createdAt = freezed,Object? name = freezed,Object? quantity = null,Object? stock = freezed,Object? order = freezed,Object? category = freezed,Object? price = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Servicemodel].
extension ServicemodelPatterns on Servicemodel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Servicemodel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Servicemodel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Servicemodel value)  $default,){
final _that = this;
switch (_that) {
case _Servicemodel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Servicemodel value)?  $default,){
final _that = this;
switch (_that) {
case _Servicemodel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', includeIfNull: false)  int? id, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'quantity')  int quantity, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'order')  int? order, @JsonKey(name: 'category')  String? category, @JsonKey(name: 'price')  int? price, @JsonKey(name: 'image')  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Servicemodel() when $default != null:
return $default(_that.id,_that.createdAt,_that.name,_that.quantity,_that.stock,_that.order,_that.category,_that.price,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', includeIfNull: false)  int? id, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'quantity')  int quantity, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'order')  int? order, @JsonKey(name: 'category')  String? category, @JsonKey(name: 'price')  int? price, @JsonKey(name: 'image')  String? image)  $default,) {final _that = this;
switch (_that) {
case _Servicemodel():
return $default(_that.id,_that.createdAt,_that.name,_that.quantity,_that.stock,_that.order,_that.category,_that.price,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id', includeIfNull: false)  int? id, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'quantity')  int quantity, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'order')  int? order, @JsonKey(name: 'category')  String? category, @JsonKey(name: 'price')  int? price, @JsonKey(name: 'image')  String? image)?  $default,) {final _that = this;
switch (_that) {
case _Servicemodel() when $default != null:
return $default(_that.id,_that.createdAt,_that.name,_that.quantity,_that.stock,_that.order,_that.category,_that.price,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Servicemodel implements Servicemodel {
  const _Servicemodel({@JsonKey(name: 'id', includeIfNull: false) this.id, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'name') this.name, @JsonKey(name: 'quantity') this.quantity = 0, @JsonKey(name: 'stock') this.stock, @JsonKey(name: 'order') this.order, @JsonKey(name: 'category') this.category, @JsonKey(name: 'price') this.price, @JsonKey(name: 'image') this.image});
  factory _Servicemodel.fromJson(Map<String, dynamic> json) => _$ServicemodelFromJson(json);

@override@JsonKey(name: 'id', includeIfNull: false) final  int? id;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'name') final  String? name;
@override@JsonKey(name: 'quantity') final  int quantity;
@override@JsonKey(name: 'stock') final  int? stock;
@override@JsonKey(name: 'order') final  int? order;
@override@JsonKey(name: 'category') final  String? category;
@override@JsonKey(name: 'price') final  int? price;
@override@JsonKey(name: 'image') final  String? image;

/// Create a copy of Servicemodel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServicemodelCopyWith<_Servicemodel> get copyWith => __$ServicemodelCopyWithImpl<_Servicemodel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServicemodelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Servicemodel&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.order, order) || other.order == order)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,name,quantity,stock,order,category,price,image);

@override
String toString() {
  return 'Servicemodel(id: $id, createdAt: $createdAt, name: $name, quantity: $quantity, stock: $stock, order: $order, category: $category, price: $price, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ServicemodelCopyWith<$Res> implements $ServicemodelCopyWith<$Res> {
  factory _$ServicemodelCopyWith(_Servicemodel value, $Res Function(_Servicemodel) _then) = __$ServicemodelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id', includeIfNull: false) int? id,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'name') String? name,@JsonKey(name: 'quantity') int quantity,@JsonKey(name: 'stock') int? stock,@JsonKey(name: 'order') int? order,@JsonKey(name: 'category') String? category,@JsonKey(name: 'price') int? price,@JsonKey(name: 'image') String? image
});




}
/// @nodoc
class __$ServicemodelCopyWithImpl<$Res>
    implements _$ServicemodelCopyWith<$Res> {
  __$ServicemodelCopyWithImpl(this._self, this._then);

  final _Servicemodel _self;
  final $Res Function(_Servicemodel) _then;

/// Create a copy of Servicemodel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? createdAt = freezed,Object? name = freezed,Object? quantity = null,Object? stock = freezed,Object? order = freezed,Object? category = freezed,Object? price = freezed,Object? image = freezed,}) {
  return _then(_Servicemodel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
