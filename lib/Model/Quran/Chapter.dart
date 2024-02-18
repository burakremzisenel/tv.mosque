import 'package:json_annotation/json_annotation.dart';
import 'TranslatedName.dart';
part 'Chapter.g.dart';

@JsonSerializable()
class Chapter{
  int? id;

  @JsonKey(name: 'revelation_place', defaultValue: '')
  String? revelationPlace;

  @JsonKey(name: 'revelation_order', defaultValue: -1)
  int? revelationOrder;

  @JsonKey(name: 'bismillah_pre', defaultValue: false)
  bool? bismillahPre;

  @JsonKey(name: 'name_simple', defaultValue: '')
  String? nameSimple;

  @JsonKey(name: 'name_complex', defaultValue: '')
  String? nameComplex;

  @JsonKey(name: 'name_arabic', defaultValue: '')
  String? nameArabic;

  @JsonKey(name: 'verses_count', defaultValue: -1)
  int? versesCount;

  @JsonKey(defaultValue: [])
  List<int>? pages;

  @JsonKey(name: 'translated_name')
  TranslatedName translatedName;

  Chapter({
    this.id,
    this.revelationPlace,
    this.revelationOrder,
    this.bismillahPre,
    this.nameSimple,
    this.nameComplex,
    this.nameArabic,
    this.versesCount,
    this.pages,
    required this.translatedName,
});

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}