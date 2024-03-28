import 'package:freezed_annotation/freezed_annotation.dart';
import 'location.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@unfreezed
class Country with _$Country {
  @JsonSerializable(explicitToJson: true)
  factory Country({
    required String name,
    required List<Location> locations
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}