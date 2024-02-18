// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Verse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Verse _$VerseFromJson(Map<String, dynamic> json) => Verse(
      id: json['id'] as int,
      verseKey: json['verse_key'] as String,
      pageNumber: json['page_number'] as int? ?? -1,
      juzNumber: json['juz_number'] as int? ?? -1,
      translations: (json['translations'] as List<dynamic>?)
              ?.map((e) => Translation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      textImlaei: json['text_imlaei'] as String? ?? '',
    );

Map<String, dynamic> _$VerseToJson(Verse instance) => <String, dynamic>{
      'id': instance.id,
      'verse_key': instance.verseKey,
      'page_number': instance.pageNumber,
      'juz_number': instance.juzNumber,
      'translations': instance.translations,
      'text_imlaei': instance.textImlaei,
    };
