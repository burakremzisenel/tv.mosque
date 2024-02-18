// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      igmgApi: json['igmgApi'] as String? ?? '',
      igmgApiKey: json['igmgApiKey'] as String? ?? '',
      directusApi: json['directusApi'] as String? ?? '',
      directusKey: json['directusKey'] as String? ?? '',
      orientation:
          $enumDecodeNullable(_$OrientationEnumMap, json['orientation']) ??
              Orientation.landscape,
      translateAR: json['translateAR'] as bool? ?? true,
      translateDE: json['translateDE'] as bool? ?? true,
      languageToggleTimer: json['languageToggleTimer'] as int? ?? 20,
      pageSlideTimer: json['pageSlideTimer'] as int? ?? 60,
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'igmgApi': instance.igmgApi,
      'igmgApiKey': instance.igmgApiKey,
      'directusApi': instance.directusApi,
      'directusKey': instance.directusKey,
      'orientation': _$OrientationEnumMap[instance.orientation]!,
      'translateAR': instance.translateAR,
      'translateDE': instance.translateDE,
      'languageToggleTimer': instance.languageToggleTimer,
      'pageSlideTimer': instance.pageSlideTimer,
    };

const _$OrientationEnumMap = {
  Orientation.portrait: 'portrait',
  Orientation.landscape: 'landscape',
};
