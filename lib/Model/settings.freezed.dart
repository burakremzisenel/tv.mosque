// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Settings _$SettingsFromJson(Map<String, dynamic> json) {
  return _Settings.fromJson(json);
}

/// @nodoc
mixin _$Settings {
  bool get igmg => throw _privateConstructorUsedError;
  set igmg(bool value) => throw _privateConstructorUsedError;
  String get igmgApi => throw _privateConstructorUsedError;
  set igmgApi(String value) => throw _privateConstructorUsedError;
  String get igmgApiKey => throw _privateConstructorUsedError;
  set igmgApiKey(String value) => throw _privateConstructorUsedError;
  bool get directus => throw _privateConstructorUsedError;
  set directus(bool value) => throw _privateConstructorUsedError;
  String get directusApi => throw _privateConstructorUsedError;
  set directusApi(String value) => throw _privateConstructorUsedError;
  String get directusKey => throw _privateConstructorUsedError;
  set directusKey(String value) => throw _privateConstructorUsedError;
  Orientation get orientation => throw _privateConstructorUsedError;
  set orientation(Orientation value) => throw _privateConstructorUsedError;
  bool get translateAR => throw _privateConstructorUsedError;
  set translateAR(bool value) => throw _privateConstructorUsedError;
  bool get translateDE => throw _privateConstructorUsedError;
  set translateDE(bool value) => throw _privateConstructorUsedError;
  int get languageToggleTimer => throw _privateConstructorUsedError;
  set languageToggleTimer(int value) => throw _privateConstructorUsedError;
  int get pageSlideTimer => throw _privateConstructorUsedError;
  set pageSlideTimer(int value) => throw _privateConstructorUsedError;
  Location? get location => throw _privateConstructorUsedError;
  set location(Location? value) => throw _privateConstructorUsedError;
  List<Country> get countries => throw _privateConstructorUsedError;
  set countries(List<Country> value) => throw _privateConstructorUsedError;
  CalculationMethod get calculationMethod => throw _privateConstructorUsedError;
  set calculationMethod(CalculationMethod value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res, Settings>;
  @useResult
  $Res call(
      {bool igmg,
      String igmgApi,
      String igmgApiKey,
      bool directus,
      String directusApi,
      String directusKey,
      Orientation orientation,
      bool translateAR,
      bool translateDE,
      int languageToggleTimer,
      int pageSlideTimer,
      Location? location,
      List<Country> countries,
      CalculationMethod calculationMethod});

  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res, $Val extends Settings>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? igmg = null,
    Object? igmgApi = null,
    Object? igmgApiKey = null,
    Object? directus = null,
    Object? directusApi = null,
    Object? directusKey = null,
    Object? orientation = null,
    Object? translateAR = null,
    Object? translateDE = null,
    Object? languageToggleTimer = null,
    Object? pageSlideTimer = null,
    Object? location = freezed,
    Object? countries = null,
    Object? calculationMethod = null,
  }) {
    return _then(_value.copyWith(
      igmg: null == igmg
          ? _value.igmg
          : igmg // ignore: cast_nullable_to_non_nullable
              as bool,
      igmgApi: null == igmgApi
          ? _value.igmgApi
          : igmgApi // ignore: cast_nullable_to_non_nullable
              as String,
      igmgApiKey: null == igmgApiKey
          ? _value.igmgApiKey
          : igmgApiKey // ignore: cast_nullable_to_non_nullable
              as String,
      directus: null == directus
          ? _value.directus
          : directus // ignore: cast_nullable_to_non_nullable
              as bool,
      directusApi: null == directusApi
          ? _value.directusApi
          : directusApi // ignore: cast_nullable_to_non_nullable
              as String,
      directusKey: null == directusKey
          ? _value.directusKey
          : directusKey // ignore: cast_nullable_to_non_nullable
              as String,
      orientation: null == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
      translateAR: null == translateAR
          ? _value.translateAR
          : translateAR // ignore: cast_nullable_to_non_nullable
              as bool,
      translateDE: null == translateDE
          ? _value.translateDE
          : translateDE // ignore: cast_nullable_to_non_nullable
              as bool,
      languageToggleTimer: null == languageToggleTimer
          ? _value.languageToggleTimer
          : languageToggleTimer // ignore: cast_nullable_to_non_nullable
              as int,
      pageSlideTimer: null == pageSlideTimer
          ? _value.pageSlideTimer
          : pageSlideTimer // ignore: cast_nullable_to_non_nullable
              as int,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location?,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<Country>,
      calculationMethod: null == calculationMethod
          ? _value.calculationMethod
          : calculationMethod // ignore: cast_nullable_to_non_nullable
              as CalculationMethod,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SettingsImplCopyWith<$Res>
    implements $SettingsCopyWith<$Res> {
  factory _$$SettingsImplCopyWith(
          _$SettingsImpl value, $Res Function(_$SettingsImpl) then) =
      __$$SettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool igmg,
      String igmgApi,
      String igmgApiKey,
      bool directus,
      String directusApi,
      String directusKey,
      Orientation orientation,
      bool translateAR,
      bool translateDE,
      int languageToggleTimer,
      int pageSlideTimer,
      Location? location,
      List<Country> countries,
      CalculationMethod calculationMethod});

  @override
  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class __$$SettingsImplCopyWithImpl<$Res>
    extends _$SettingsCopyWithImpl<$Res, _$SettingsImpl>
    implements _$$SettingsImplCopyWith<$Res> {
  __$$SettingsImplCopyWithImpl(
      _$SettingsImpl _value, $Res Function(_$SettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? igmg = null,
    Object? igmgApi = null,
    Object? igmgApiKey = null,
    Object? directus = null,
    Object? directusApi = null,
    Object? directusKey = null,
    Object? orientation = null,
    Object? translateAR = null,
    Object? translateDE = null,
    Object? languageToggleTimer = null,
    Object? pageSlideTimer = null,
    Object? location = freezed,
    Object? countries = null,
    Object? calculationMethod = null,
  }) {
    return _then(_$SettingsImpl(
      igmg: null == igmg
          ? _value.igmg
          : igmg // ignore: cast_nullable_to_non_nullable
              as bool,
      igmgApi: null == igmgApi
          ? _value.igmgApi
          : igmgApi // ignore: cast_nullable_to_non_nullable
              as String,
      igmgApiKey: null == igmgApiKey
          ? _value.igmgApiKey
          : igmgApiKey // ignore: cast_nullable_to_non_nullable
              as String,
      directus: null == directus
          ? _value.directus
          : directus // ignore: cast_nullable_to_non_nullable
              as bool,
      directusApi: null == directusApi
          ? _value.directusApi
          : directusApi // ignore: cast_nullable_to_non_nullable
              as String,
      directusKey: null == directusKey
          ? _value.directusKey
          : directusKey // ignore: cast_nullable_to_non_nullable
              as String,
      orientation: null == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
      translateAR: null == translateAR
          ? _value.translateAR
          : translateAR // ignore: cast_nullable_to_non_nullable
              as bool,
      translateDE: null == translateDE
          ? _value.translateDE
          : translateDE // ignore: cast_nullable_to_non_nullable
              as bool,
      languageToggleTimer: null == languageToggleTimer
          ? _value.languageToggleTimer
          : languageToggleTimer // ignore: cast_nullable_to_non_nullable
              as int,
      pageSlideTimer: null == pageSlideTimer
          ? _value.pageSlideTimer
          : pageSlideTimer // ignore: cast_nullable_to_non_nullable
              as int,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location?,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<Country>,
      calculationMethod: null == calculationMethod
          ? _value.calculationMethod
          : calculationMethod // ignore: cast_nullable_to_non_nullable
              as CalculationMethod,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SettingsImpl extends _Settings {
  _$SettingsImpl(
      {this.igmg = false,
      this.igmgApi = '',
      this.igmgApiKey = '',
      this.directus = false,
      this.directusApi = '',
      this.directusKey = '',
      this.orientation = Orientation.landscape,
      this.translateAR = true,
      this.translateDE = true,
      this.languageToggleTimer = 0,
      this.pageSlideTimer = 0,
      this.location,
      this.countries = const [],
      this.calculationMethod = CalculationMethod.turkey})
      : super._();

  factory _$SettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsImplFromJson(json);

  @override
  @JsonKey()
  bool igmg;
  @override
  @JsonKey()
  String igmgApi;
  @override
  @JsonKey()
  String igmgApiKey;
  @override
  @JsonKey()
  bool directus;
  @override
  @JsonKey()
  String directusApi;
  @override
  @JsonKey()
  String directusKey;
  @override
  @JsonKey()
  Orientation orientation;
  @override
  @JsonKey()
  bool translateAR;
  @override
  @JsonKey()
  bool translateDE;
  @override
  @JsonKey()
  int languageToggleTimer;
  @override
  @JsonKey()
  int pageSlideTimer;
  @override
  Location? location;
  @override
  @JsonKey()
  List<Country> countries;
  @override
  @JsonKey()
  CalculationMethod calculationMethod;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsImplCopyWith<_$SettingsImpl> get copyWith =>
      __$$SettingsImplCopyWithImpl<_$SettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsImplToJson(
      this,
    );
  }
}

abstract class _Settings extends Settings {
  factory _Settings(
      {bool igmg,
      String igmgApi,
      String igmgApiKey,
      bool directus,
      String directusApi,
      String directusKey,
      Orientation orientation,
      bool translateAR,
      bool translateDE,
      int languageToggleTimer,
      int pageSlideTimer,
      Location? location,
      List<Country> countries,
      CalculationMethod calculationMethod}) = _$SettingsImpl;
  _Settings._() : super._();

  factory _Settings.fromJson(Map<String, dynamic> json) =
      _$SettingsImpl.fromJson;

  @override
  bool get igmg;
  set igmg(bool value);
  @override
  String get igmgApi;
  set igmgApi(String value);
  @override
  String get igmgApiKey;
  set igmgApiKey(String value);
  @override
  bool get directus;
  set directus(bool value);
  @override
  String get directusApi;
  set directusApi(String value);
  @override
  String get directusKey;
  set directusKey(String value);
  @override
  Orientation get orientation;
  set orientation(Orientation value);
  @override
  bool get translateAR;
  set translateAR(bool value);
  @override
  bool get translateDE;
  set translateDE(bool value);
  @override
  int get languageToggleTimer;
  set languageToggleTimer(int value);
  @override
  int get pageSlideTimer;
  set pageSlideTimer(int value);
  @override
  Location? get location;
  set location(Location? value);
  @override
  List<Country> get countries;
  set countries(List<Country> value);
  @override
  CalculationMethod get calculationMethod;
  set calculationMethod(CalculationMethod value);
  @override
  @JsonKey(ignore: true)
  _$$SettingsImplCopyWith<_$SettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
