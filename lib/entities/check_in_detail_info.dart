import 'package:json_annotation/json_annotation.dart';
part 'check_in_detail_info.g.dart';

@JsonSerializable()
class CheckInDetailInfo extends Object {

  @JsonKey()
  int id;
  @JsonKey()
  int userId;
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

  factory CheckInDetailInfo.fromJson(Map<String, dynamic> json) => _$CheckInDetailInfoFromJson(json);

  CheckInDetailInfo(this.id, this.userId, this.type, this.agent, this.platform,
      this.flag, this.createTime, this.modifyTime);

  @override
  String toString() {
    return 'CheckInDetailInfo{id: $id, userId: $userId, type: $type, agent: $agent, platform: $platform, flag: $flag, createTime: $createTime, modifyTime: $modifyTime}';
  }


}