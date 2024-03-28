import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'announcement.g.dart';

enum AnnoTypes{
  DIRECTUS(0),
  IGMG(1);

  final int key;
  const AnnoTypes(this.key);
}

@JsonSerializable()
class Announcement extends Equatable{
  final int id;
  final String title;
  final String body;
  final String? url;
  final String? image;
  @JsonKey(name: 'published_from')
  final DateTime? publishedFrom;
  @JsonKey(name: 'published_until')
  final DateTime? publishedUntil;
  @JsonKey(name: 'date_updated')
  final DateTime? updatedAt;
  @JsonKey(name: 'date_created')
  final DateTime? createdAt;

  @JsonKey(defaultValue: AnnoTypes.DIRECTUS)
  final AnnoTypes type;

  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    this.url,
    this.image,
    this.publishedFrom,
    this.publishedUntil,
    this.updatedAt,
    this.createdAt,
    required this.type,
  });

  static List<Announcement> listFromJson(List<dynamic> json) {
    return List<Announcement>.from(json.map((e) => Announcement.fromJson(e)));
  }
  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  @override
  List<Object?> get props => [
    id,
    title
  ];
}