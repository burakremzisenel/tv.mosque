import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location extends Equatable with _$Location{
  @JsonSerializable(explicitToJson: true)
  const factory Location({
    required int id,

    required String name,
    
    required double latitude,
    required double longitude,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  
  const Location._();

  @override
  List<Object> get props => [
    id
  ];

  /// LatLng
  LatLng get latLng{
    return LatLng(latitude, longitude);
  }

  /// Country
  /// Returns text in last bracket block
  /// ex. Kreuzberg (Berlin) (DE)
  /// DE
  String get country{
    RegExp regex = RegExp(r'\((.*?)\)(?=\s*\(|$)');
    List<Match> matches = regex.allMatches(name).toList();
    if (matches.isNotEmpty) {
      /// Brackets found
      String extractedText1 = matches.last.group(1)!;
      extractedText1 = extractedText1.trim();
      return extractedText1;

    } else {
      return '';
    }
  }

  /// City
  /// Returns text in first bracket block, if there wo blocks is
  /// ex. Kreuzberg (Berlin) (DE)
  /// Berlin
  String get city{
    RegExp regex = RegExp(r'\((.*?)\).*?\(.*?\)');
    Match? match = regex.firstMatch(name);
    if (match != null) {
      /// two bracket blocks found
      String extractedText = match.group(1)!;
      extractedText = extractedText.trim();
      return extractedText;
    }
    return province;
  }

  /// Province
  /// Returns first text block
  /// ex. Kreuzberg (Berlin) (DE)
  /// Kreuzberg
  String get province{
    List<String> chunks = name.split(' ');
    if(chunks.isNotEmpty){
      return chunks[0];
    }
    return '';
  }

  bool get isProvince{
    return province != city;
  }
}