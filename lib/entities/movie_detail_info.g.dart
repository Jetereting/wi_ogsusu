// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailInfo _$MovieDetailInfoFromJson(Map<String, dynamic> json) {
  return MovieDetailInfo(
      json['id'] as int,
      json['movieId'] as int,
      json['title'] as String,
      json['overview'] as String,
      json['releaseDate'] as String,
      json['homePage'] as String,
      json['adult'] as bool,
      json['video'] as bool,
      (json['popularity'] as num)?.toDouble(),
      json['originalTitle'] as String,
      json['originalLanguage'] as String,
      json['voteCount'] as int,
      (json['voteAverage'] as num)?.toDouble(),
      json['budget'] as int,
      json['poster'] as String,
      json['backdropPath'] as String,
      json['status'] as String);
}

Map<String, dynamic> _$MovieDetailInfoToJson(MovieDetailInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'title': instance.title,
      'overview': instance.overview,
      'releaseDate': instance.releaseDate,
      'homePage': instance.homePage,
      'adult': instance.adult,
      'video': instance.video,
      'popularity': instance.popularity,
      'originalTitle': instance.originalTitle,
      'originalLanguage': instance.originalLanguage,
      'voteCount': instance.voteCount,
      'voteAverage': instance.voteAverage,
      'budget': instance.budget,
      'poster': instance.poster,
      'backdropPath': instance.backdropPath,
      'status': instance.status
    };
