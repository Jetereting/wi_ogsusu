import 'package:json_annotation/json_annotation.dart';
part 'sport_game_channel_info.g.dart';

@JsonSerializable()
class SportGameChannelInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String channelId;
  @JsonKey()
  String label;
  @JsonKey()
  String icon;

  factory SportGameChannelInfo.fromJson(Map<String, dynamic> json) => _$SportGameChannelInfoFromJson(json);

  SportGameChannelInfo(this.id, this.channelId, this.label, this.icon);

  @override
  String toString() {
    return 'SportGameChannelInfo{label: $label}';
  }


}