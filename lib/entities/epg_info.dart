import 'package:json_annotation/json_annotation.dart';
import 'epg_detail_info.dart';
part 'epg_info.g.dart';

@JsonSerializable()
class EpgInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  int category;
  @JsonKey()
  String channelId;
  @JsonKey()
  String label;
  @JsonKey()
  String name;
  @JsonKey()
  String icon;
  @JsonKey()
  String currentPlay;
  @JsonKey()
  String nextPlay;

  EpgInfo(this.id, this.category, this.channelId, this.label, this.name,
      this.icon, this.currentPlay, this.nextPlay);

  @override
  String toString() {
    return 'EpgInfo{id: $id, category: $category, channelId: $channelId, label: $label, name: $name, icon: $icon, currentPlay: $currentPlay, nextPlay: $nextPlay}';
  }

  factory EpgInfo.fromJson(Map<String, dynamic> json) => _$EpgInfoFromJson(json);



}