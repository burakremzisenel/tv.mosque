// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      id: json['id'] as int?,
      revelationPlace: json['revelation_place'] as String? ?? '',
      revelationOrder: json['revelation_order'] as int? ?? -1,
      bismillahPre: json['bismillah_pre'] as bool? ?? false,
      nameSimple: json['name_simple'] as String? ?? '',
      nameComplex: json['name_complex'] as String? ?? '',
      nameArabic: json['name_arabic'] as String? ?? '',
      versesCount: json['verses_count'] as int? ?? -1,
      pages: (json['pages'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          [],
      translatedName: TranslatedName.fromJson(
          json['translated_name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'id': instance.id,
      'revelation_place': instance.revelationPlace,
      'revelation_order': instance.revelationOrder,
      'bismillah_pre': instance.bismillahPre,
      'name_simple': instance.nameSimple,
      'name_complex': instance.nameComplex,
      'name_arabic': instance.nameArabic,
      'verses_count': instance.versesCount,
      'pages': instance.pages,
      'translated_name': instance.translatedName,
    };
