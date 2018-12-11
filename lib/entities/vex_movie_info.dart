import 'package:json_annotation/json_annotation.dart';
part 'vex_movie_info.g.dart';

@JsonSerializable()
class VexMovieInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String label;
  @JsonKey()
  String icon;
  @JsonKey()
  String link;
  @JsonKey()
  String genres;
  @JsonKey(name: 'releaseYear')
  String releaseYear;

  factory VexMovieInfo.fromJson(Map<String, dynamic> json) => _$VexMovieInfoFromJson(json);

  VexMovieInfo(this.id, this.label, this.icon, this.link, this.genres,
      this.releaseYear);

  @override
  String toString() {
    return 'VexMovieInfo{id: $id, label: $label, icon: $icon, link: $link, genres: $genres, releaseYear: $releaseYear}';
  }

}