import 'package:json_annotation/json_annotation.dart';
part 'sport_game_info.g.dart';

@JsonSerializable()
class SportGameInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  int categoryId;
  @JsonKey()
  int eventId;
  @JsonKey()
  int flag;
  @JsonKey()
  String time;
  @JsonKey()
  String homeTeam;
  @JsonKey()
  String guestTeam;
  @JsonKey()
  String channelIds;

  SportGameInfo(this.id, this.categoryId, this.eventId, this.flag, this.time,
      this.homeTeam, this.guestTeam, this.channelIds);

  factory SportGameInfo.fromJson(Map<String, dynamic> json) => _$SportGameInfoFromJson(json);

  @override
  String toString() {
    return 'SportGameInfo{id: $id, categoryId: $categoryId, eventId: $eventId, flag: $flag, time: $time, homeTeam: $homeTeam, guestTeam: $guestTeam, channelIds: $channelIds}';
  }


}