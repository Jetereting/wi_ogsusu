import 'package:json_annotation/json_annotation.dart';
part 'epg_detail_info.g.dart';

@JsonSerializable()
class EpgDetailInfo extends Object{

  @JsonKey()
  String channelId;
  @JsonKey()
  int startTime;
  @JsonKey()
  int endTime;
  @JsonKey()
  String label;

  EpgDetailInfo(this.channelId, this.startTime, this.endTime, this.label);

  @override
  String toString() {
    return 'EpgDetailInfo{channelId: $channelId, startTime: $startTime, endTime: $endTime, label: $label}';
  }

  factory EpgDetailInfo.fromJson(Map<String, dynamic> json) => _$EpgDetailInfoFromJson(json);



}