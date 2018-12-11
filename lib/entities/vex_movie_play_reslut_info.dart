import 'package:json_annotation/json_annotation.dart';
import 'vex_movie_play_info.dart';

@JsonSerializable()
class VexMoviePlayResultInfo extends Object{

  @JsonKey()
  int error_code;
  @JsonKey()
  String error_msg;
//  List<VexMoviePlayInfo> data;

  VexMoviePlayResultInfo.fromJson(Map<String, dynamic> json)
      : error_code = json['error_code'],
        error_msg = json['error_msg'];


}