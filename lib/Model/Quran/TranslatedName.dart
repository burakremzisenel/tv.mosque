import 'package:json_annotation/json_annotation.dart';
part 'TranslatedName.g.dart';

@JsonSerializable()
class TranslatedName{
  @JsonKey(name: 'language_name')
  String languageName;

  String name;

  TranslatedName({
   required this.languageName,
   required this.name
});

  factory TranslatedName.fromJson(Map<String, dynamic> json) =>
      _$TranslatedNameFromJson(json);
  Map<String, dynamic> toJson() => _$TranslatedNameToJson(this);
}
