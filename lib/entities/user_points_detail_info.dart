import 'package:json_annotation/json_annotation.dart';
import 'check_in_detail_info.dart';
part 'user_points_detail_info.g.dart';

@JsonSerializable()
class UserPointsDetailInfo extends Object {

  @JsonKey()
  int id;
  @JsonKey()
  int userId;
  @JsonKey()
  int action;
  @JsonKey()
  int points;
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
  @JsonKey()
  String createTime;
  @JsonKey()
  String modifyTime;

  factory UserPointsDetailInfo.fromJson(Map<String, dynamic> json) => _$UserPointsDetailInfoFromJson(json);

  UserPointsDetailInfo(this.id, this.userId, this.action, this.points,
      this.description, this.type, this.agent, this.platform, this.flag,
      this.createTime, this.modifyTime);

  @override
  String toString() {
    return 'UserPointDetailInfo{id: $id, userId: $userId, action: $action, points: $points, description: $description, type: $type, agent: $agent, platform: $platform, flag: $flag, createTime: $createTime, modifyTime: $modifyTime}';
  }


}