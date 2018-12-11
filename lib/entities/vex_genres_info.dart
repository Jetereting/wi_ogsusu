import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VexGenresInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String label;
  @JsonKey()
  String link;


  VexGenresInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        label = json['label'],
        link = json['link'];
}