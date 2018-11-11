// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieInfo _$MovieInfoFromJson(Map<String, dynamic> json) {
  return MovieInfo(
      json['id'] as int,
      json['movieId'] as int,
      json['title'] as String,
      json['overview'] as String,
      json['releaseDate'] as String,
      json['adult'] as bool,
      json['video'] as bool,
      (json['popularity'] as num)?.toDouble(),
      json['originalTitle'] as String,
      json['originalLanguage'] as String,
      json['voteCount'] as int,
      (json['voteAverage'] as num)?.toDouble(),
      json['poster'] as String);
}

Map<String, dynamic> _$MovieInfoToJson(MovieInfo instance) => <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'title': instance.title,
      'overview': instance.overview,
      'releaseDate': instance.releaseDate,
      'adult': instance.adult,
      'video': instance.video,
      'popularity': instance.popularity,
      'originalTitle': instance.originalTitle,
      'originalLanguage': instance.originalLanguage,
      'voteCount': instance.voteCount,
      'voteAverage': instance.voteAverage,
      'poster': instance.poster
    };
