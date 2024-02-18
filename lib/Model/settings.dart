
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@unfreezed
class Settings with _$Settings {
  factory Settings({
    @Default('') String igmgApi,
    @Default('') String igmgApiKey,
    @Default('') String directusApi,
    @Default('') String directusKey,

    @Default(Orientation.landscape) Orientation orientation,

    @Default(true) bool translateAR,
    @Default(true) bool translateDE,
    @Default(20) int languageToggleTimer,

    @Default(60) int pageSlideTimer,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
}