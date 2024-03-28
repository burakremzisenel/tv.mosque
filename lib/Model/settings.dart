
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_mosque/Model/country.dart';
import 'package:tv_mosque/Model/location.dart';
import 'package:adhan/adhan.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@unfreezed
class Settings extends Equatable with _$Settings {
  @JsonSerializable(explicitToJson: true)
  factory Settings({
    @Default(false) bool igmg,
    @Default('') String igmgApi,
    @Default('') String igmgApiKey,
    @Default(false) bool directus,
    @Default('') String directusApi,
    @Default('') String directusKey,

    @Default(Orientation.landscape) Orientation orientation,

    @Default(true) bool translateAR,
    @Default(true) bool translateDE,
    @Default(0) int languageToggleTimer,

    @Default(0) int pageSlideTimer,

    Location? location,
    @Default([]) List<Country> countries,

    @Default(CalculationMethod.turkey) CalculationMethod calculationMethod,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  const Settings._();

  @override
  List<Object> get props => [
    igmg,
    igmgApi,
    igmgApiKey,
    directus,
    directusApi,
    directusKey,
    orientation,
    translateAR,
    translateDE,
    languageToggleTimer,
    pageSlideTimer,
    location ?? const Location(id: 0, name: '', latitude: 0, longitude: 0),
    calculationMethod
  ];

  /// Read locations from assets
  Future readCountriesFromAssets() async{
    final String response = await rootBundle.loadString('assets/countries/countries.json');
    final data = await json.decode(response);
    List<Location> locations = List<Location>.from(data['list'].map((e) => Location.fromJson(e)));

    /// Group by country
    Map<String, List<Location>> groupedByCountry = groupBy(locations, (location) => location.country);

    /// Sorting
    List<MapEntry<String, List<Location>>> sortedEntries = groupedByCountry.entries.toList()
      ..sort((a, b) {
        // Sort by country
        int compareCountry = a.key.compareTo(b.key);
        if (compareCountry != 0) {
          return compareCountry;
        }

        // Sort by city
        int compareCity = (a.value.first.city).compareTo(b.value.first.city);
        if (compareCity != 0) {
          return compareCity;
        }

        // Sort by name
        return a.value.first.name.compareTo(b.value.first.name);
      });

    /// Loop entries
    /// Create country & add locations
    /// Add country to list
    List<Country> tmpList = [];
    for (var entry in sortedEntries) {
      Country country = Country(name: entry.key, locations: []);
      country.locations.addAll(entry.value);
      tmpList.add(country);
    }
    countries = tmpList;
  }
}