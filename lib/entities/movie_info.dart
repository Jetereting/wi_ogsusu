import 'package:json_annotation/json_annotation.dart';
import 'epg_detail_info.dart';
part 'movie_info.g.dart';

@JsonSerializable()
class MovieInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  int movieId;
  @JsonKey()
  String title;
  @JsonKey()
  String overview;
  @JsonKey()
  String releaseDate;
  @JsonKey()
  bool adult;
  @JsonKey()
  bool video;
  @JsonKey()
  double popularity;
  @JsonKey()
  String originalTitle;
  @JsonKey()
  String originalLanguage;
  @JsonKey()
  int voteCount;
  @JsonKey()
  double voteAverage;
  @JsonKey()
  String poster;

  MovieInfo(this.id, this.movieId, this.title, this.overview, this.releaseDate,
      this.adult, this.video, this.popularity, this.originalTitle,
      this.originalLanguage, this.voteCount, this.voteAverage, this.poster);

  @override
  String toString() {
    return 'MovieInfo{id: $id, movieId: $movieId, title: $title, overview: $overview, releaseDate: $releaseDate, adult: $adult, video: $video, popularity: $popularity, originalTitle: $originalTitle, originalLanguage: $originalLanguage, voteCount: $voteCount, voteAverage: $voteAverage, poster: $poster}';
  }

  factory MovieInfo.fromJson(Map<String, dynamic> json) => _$MovieInfoFromJson(json);



}