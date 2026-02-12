// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servicemodel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Servicemodel _$ServicemodelFromJson(Map<String, dynamic> json) =>
    _Servicemodel(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      name: json['name'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      stock: (json['stock'] as num?)?.toInt(),
      order: (json['order'] as num?)?.toInt(),
      category: json['category'] as String?,
      price: (json['price'] as num?)?.toInt(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ServicemodelToJson(_Servicemodel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'created_at': instance.createdAt?.toIso8601String(),
      'name': instance.name,
      'quantity': instance.quantity,
      'stock': instance.stock,
      'order': instance.order,
      'category': instance.category,
      'price': instance.price,
      'image': instance.image,
    };
