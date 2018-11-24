import 'package:json_annotation/json_annotation.dart';
import 'check_in_detail_info.dart';
part 'user_points_info.g.dart';

@JsonSerializable()
class UserPointsInfo extends Object {

  @JsonKey()
  int id;
  @JsonKey()
  int userId;
  @JsonKey()
  int points;
  @JsonKey()
  int type;
  @JsonKey()
  int agent;
  @JsonKey()
  int platform;
  @JsonKey()
  int flag;
  @JsonKey()
  String createTime;
  @JsonKey()
  String modifyTime;

  factory UserPointsInfo.fromJson(Map<String, dynamic> json) => _$UserPointsInfoFromJson(json);

  UserPointsInfo(this.id, this.userId, this.points, this.type, this.agent,
      this.platform, this.flag, this.createTime, this.modifyTime);

  @override
  String toString() {
    return 'UserPointsInfo{id: $id, userId: $userId, points: $points, type: $type, agent: $agent, platform: $platform, flag: $flag, createTime: $createTime, modifyTime: $modifyTime}';
  }


}