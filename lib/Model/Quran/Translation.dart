import 'package:json_annotation/json_annotation.dart';
part 'Translation.g.dart';

@JsonSerializable()
class Translation{
  @JsonKey(defaultValue: -1)
  int? id;

  @JsonKey(name: 'resource_id')
  int resourceId;

  String text;

  Translation({
    this.id,
    required this.resourceId,
    required this.text,
});

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);
  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}