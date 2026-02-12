import 'package:freezed_annotation/freezed_annotation.dart';

part 'servicemodel_model.freezed.dart';
part 'servicemodel_model.g.dart';

@freezed
abstract class Servicemodel with _$Servicemodel {
  const factory Servicemodel({
    @JsonKey(name: 'id', includeIfNull: false) int? id,

    @JsonKey(name: 'created_at') DateTime? createdAt,

    @JsonKey(name: 'name') String? name,

   @Default(0)@JsonKey(name: 'quantity') int quantity,

    @JsonKey(name: 'stock') int? stock,

    @JsonKey(name: 'order') int? order,

    @JsonKey(name: 'category') String? category,

    @JsonKey(name: 'price') int? price,

    @JsonKey(name: 'image') String? image,
  }) = _Servicemodel;

  factory Servicemodel.fromJson(Map<String, dynamic> json) =>
      _$ServicemodelFromJson(json);
}
