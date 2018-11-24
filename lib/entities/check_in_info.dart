import 'package:json_annotation/json_annotation.dart';
import 'check_in_detail_info.dart';
part 'check_in_info.g.dart';

@JsonSerializable()
class CheckInInfo extends Object {

  @JsonKey()
  int id;
  @JsonKey()
  int userId;
  @JsonKey()
  int checkInDays;
  @JsonKey()
  int checkInContinuousDays;
  @JsonKey()
  int type;
  @JsonKey()
  int agent;
  @JsonKey()
  int platform;
  @JsonKey()
  int flag;
  @JsonKey()
  bool currentChecked;
  @JsonKey()
  String createTime;
  @JsonKey()
  String modifyTime;
  @JsonKey()
  List<CheckInDetailInfo> checkInDetailInfoList;

  factory CheckInInfo.fromJson(Map<String, dynamic> json) => _$CheckInInfoFromJson(json);

  CheckInInfo(this.id, this.userId, this.checkInDays,
      this.checkInContinuousDays, this.type, this.agent, this.platform,
      this.flag, this.currentChecked, this.createTime, this.modifyTime,
      this.checkInDetailInfoList);

  @override
  String toString() {
    return 'CheckInInfo{id: $id, userId: $userId, checkInDays: $checkInDays, checkInContinuousDays: $checkInContinuousDays, type: $type, agent: $agent, platform: $platform, flag: $flag, currentChecked: $currentChecked, createTime: $createTime, modifyTime: $modifyTime, checkInDetailInfoList: $checkInDetailInfoList}';
  }


}