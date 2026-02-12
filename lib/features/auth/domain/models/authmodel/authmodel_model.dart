import 'package:freezed_annotation/freezed_annotation.dart';

part 'authmodel_model.freezed.dart';
part 'authmodel_model.g.dart';

@freezed
sealed class Authmodel with _$Authmodel {
  const factory Authmodel({
    @JsonKey(name: 'id', includeIfNull: false) int? id,
  }) = _Authmodel;

  factory Authmodel.fromJson(Map<String, dynamic> json) =>
      _$AuthmodelFromJson(json);
}
