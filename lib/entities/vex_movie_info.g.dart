// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vex_movie_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VexMovieInfo _$VexMovieInfoFromJson(Map<String, dynamic> json) {
  return VexMovieInfo(
      json['id'] as int,
      json['label'] as String,
      json['icon'] as String,
      json['link'] as String,
      json['genres'] as String,
      json['releaseYear'] as String);
}

Map<String, dynamic> _$VexMovieInfoToJson(VexMovieInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'icon': instance.icon,
      'link': instance.link,
      'genres': instance.genres,
      'releaseYear': instance.releaseYear
    };
