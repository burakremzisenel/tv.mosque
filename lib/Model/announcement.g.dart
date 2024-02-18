// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      url: json['url'] as String?,
      image: json['image'] as String?,
      publishedFrom: json['published_from'] == null
          ? null
          : DateTime.parse(json['published_from'] as String),
      publishedUntil: json['published_until'] == null
          ? null
          : DateTime.parse(json['published_until'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'url': instance.url,
      'image': instance.image,
      'published_from': instance.publishedFrom?.toIso8601String(),
      'published_until': instance.publishedUntil?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
