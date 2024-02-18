import 'package:json_annotation/json_annotation.dart';
import 'Translation.dart';
part 'Verse.g.dart';

@JsonSerializable()
class Verse{
  int id;

  @JsonKey(name: 'verse_key')
  String verseKey;

  @JsonKey(name: 'page_number', defaultValue: -1)
  int? pageNumber;

  @JsonKey(name: 'juz_number', defaultValue: -1)
  int? juzNumber;

  @JsonKey(defaultValue: [])
  List<Translation>? translations;

  @JsonKey(name: 'text_imlaei', defaultValue: '')
  String? textImlaei;

  Verse({
    required this.id,
    required this.verseKey,
    this.pageNumber,
    this.juzNumber,
    this.translations,
    this.textImlaei,
});

  factory Verse.fromJson(Map<String, dynamic> json) =>
      _$VerseFromJson(json);
  Map<String, dynamic> toJson() => _$VerseToJson(this);
}