// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarInfo _$CalendarInfoFromJson(Map<String, dynamic> json) => CalendarInfo(
      daysTopic: json['DaysTopic'] as String?,
      daysTopicText: json['DaysTopicText'] as String?,
      ayahOrHadith: json['AyahOrHadith'] as String?,
      event: json['Event'] as String?,
      eventTranslations:
          (json['eventTranslations'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              {},
      daysTopicTranslations:
          (json['daysTopicTranslations'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              {},
      daysTopicTextTranslations:
          (json['daysTopicTextTranslations'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              {},
      ayahTranslations:
          (json['ayahTranslations'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              {},
    );

Map<String, dynamic> _$CalendarInfoToJson(CalendarInfo instance) =>
    <String, dynamic>{
      'DaysTopicText': instance.daysTopicText,
      'Event': instance.event,
      'DaysTopic': instance.daysTopic,
      'AyahOrHadith': instance.ayahOrHadith,
      'eventTranslations': instance.eventTranslations,
      'daysTopicTranslations': instance.daysTopicTranslations,
      'daysTopicTextTranslations': instance.daysTopicTextTranslations,
      'ayahTranslations': instance.ayahTranslations,
    };
