// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      igmg: json['igmg'] as bool? ?? false,
      igmgApi: json['igmgApi'] as String? ?? '',
      igmgApiKey: json['igmgApiKey'] as String? ?? '',
      directus: json['directus'] as bool? ?? false,
      directusApi: json['directusApi'] as String? ?? '',
      directusKey: json['directusKey'] as String? ?? '',
      orientation:
          $enumDecodeNullable(_$OrientationEnumMap, json['orientation']) ??
              Orientation.landscape,
      translateAR: json['translateAR'] as bool? ?? true,
      translateDE: json['translateDE'] as bool? ?? true,
      languageToggleTimer: json['languageToggleTimer'] as int? ?? 0,
      pageSlideTimer: json['pageSlideTimer'] as int? ?? 0,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      calculationMethod: $enumDecodeNullable(
              _$CalculationMethodEnumMap, json['calculationMethod']) ??
          CalculationMethod.turkey,
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'igmg': instance.igmg,
      'igmgApi': instance.igmgApi,
      'igmgApiKey': instance.igmgApiKey,
      'directus': instance.directus,
      'directusApi': instance.directusApi,
      'directusKey': instance.directusKey,
      'orientation': _$OrientationEnumMap[instance.orientation]!,
      'translateAR': instance.translateAR,
      'translateDE': instance.translateDE,
      'languageToggleTimer': instance.languageToggleTimer,
      'pageSlideTimer': instance.pageSlideTimer,
      'location': instance.location?.toJson(),
      'countries': instance.countries.map((e) => e.toJson()).toList(),
      'calculationMethod':
          _$CalculationMethodEnumMap[instance.calculationMethod]!,
    };

const _$OrientationEnumMap = {
  Orientation.portrait: 'portrait',
  Orientation.landscape: 'landscape',
};

const _$CalculationMethodEnumMap = {
  CalculationMethod.muslim_world_league: 'muslim_world_league',
  CalculationMethod.egyptian: 'egyptian',
  CalculationMethod.karachi: 'karachi',
  CalculationMethod.umm_al_qura: 'umm_al_qura',
  CalculationMethod.dubai: 'dubai',
  CalculationMethod.moon_sighting_committee: 'moon_sighting_committee',
  CalculationMethod.north_america: 'north_america',
  CalculationMethod.kuwait: 'kuwait',
  CalculationMethod.qatar: 'qatar',
  CalculationMethod.singapore: 'singapore',
  CalculationMethod.turkey: 'turkey',
  CalculationMethod.tehran: 'tehran',
  CalculationMethod.other: 'other',
};
