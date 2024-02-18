// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Translation _$TranslationFromJson(Map<String, dynamic> json) => Translation(
      id: json['id'] as int? ?? -1,
      resourceId: json['resource_id'] as int,
      text: json['text'] as String,
    );

Map<String, dynamic> _$TranslationToJson(Translation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_id': instance.resourceId,
      'text': instance.text,
    };
