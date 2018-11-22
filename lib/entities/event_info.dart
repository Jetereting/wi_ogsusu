import 'package:json_annotation/json_annotation.dart';
import 'sport_game_info.dart';
part 'event_info.g.dart';

@JsonSerializable()
class EventInfo extends Object{

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
  String link;
  @JsonKey()
  String description;
  @JsonKey()
  int action;
  @JsonKey()
  int type;
  @JsonKey()
  int agent;
  @JsonKey()
  int platform;
  @JsonKey()
  int flag;
  @JsonKey()
  bool visible;
  @JsonKey()
  bool labelVisible;

  factory EventInfo.fromJson(Map<String, dynamic> json) => _$EventInfoFromJson(json);


  EventInfo();

  @override
  String toString() {
    return 'EventInfo{id: $id, categoryId: $categoryId, label: $label, name: $name, icon: $icon, link: $link, description: $description, type: $type, agent: $agent, platform: $platform, flag: $flag, visible: $visible, labelVisible: $labelVisible}';
  }


}