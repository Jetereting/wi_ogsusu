import 'package:json_annotation/json_annotation.dart';
import 'sport_game_info.dart';
part 'sport_event_info.g.dart';

@JsonSerializable()
class SportEventInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  int categoryId;
  @JsonKey()
  String label;
  @JsonKey()
  String name;
  @JsonKey()
  String icon;
  @JsonKey()
  String description;
  @JsonKey()
  int type;
  @JsonKey()
  int agent;
  @JsonKey()
  int platform;
  @JsonKey()
  int flag;

  factory SportEventInfo.fromJson(Map<String, dynamic> json) => _$SportEventInfoFromJson(json);

  SportEventInfo(this.id, this.categoryId, this.label, this.name, this.icon,
      this.description, this.type, this.agent, this.platform, this.flag);

  @override
  String toString() {
    return 'SportEventInfo{type: $type}';
  }


}