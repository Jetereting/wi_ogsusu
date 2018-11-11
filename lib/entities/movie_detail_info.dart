import 'package:json_annotation/json_annotation.dart';
import 'epg_detail_info.dart';
part 'movie_detail_info.g.dart';

@JsonSerializable()
class MovieDetailInfo extends Object{

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
  String homePage;
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
  int budget;
  @JsonKey()
  String poster;
  @JsonKey()
  String backdropPath;
  @JsonKey()
  String status;


  MovieDetailInfo(this.id, this.movieId, this.title, this.overview,
      this.releaseDate, this.homePage, this.adult, this.video, this.popularity,
      this.originalTitle, this.originalLanguage, this.voteCount,
      this.voteAverage, this.budget, this.poster, this.backdropPath,
      this.status);

  @override
  String toString() {
    return 'MovieDetailInfo{id: $id, movieId: $movieId, title: $title, overview: $overview, releaseDate: $releaseDate, homePage: $homePage, adult: $adult, video: $video, popularity: $popularity, originalTitle: $originalTitle, originalLanguage: $originalLanguage, voteCount: $voteCount, voteAverage: $voteAverage, budget: $budget, poster: $poster, backdropPath: $backdropPath, status: $status}';
  }

  factory MovieDetailInfo.fromJson(Map<String, dynamic> json) => _$MovieDetailInfoFromJson(json);



}