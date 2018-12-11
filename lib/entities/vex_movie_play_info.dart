import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VexMoviePlayInfo extends Object{

  @JsonKey()
  String source;
  @JsonKey()
  String url;
  @JsonKey()
  int type;

  VexMoviePlayInfo.fromJson(Map<String, dynamic> json)
      : source = json['source'],
        url = json['play_url'],
        type = json['type'];

  @override
  String toString() {
    return 'VexMoviePlayInfo{source: $source, url: $url, type: $type}';
  }


}