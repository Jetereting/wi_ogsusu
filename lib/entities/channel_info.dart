import 'package:json_annotation/json_annotation.dart';
part 'channel_info.g.dart';

@JsonSerializable()
class ChannelInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String channelId;
  @JsonKey()
  String tag;
  @JsonKey()
  String label;
  @JsonKey()
  String name;
  @JsonKey()
  int type;
  @JsonKey()
  bool visible;
  @JsonKey()
  bool blocked;
  @JsonKey()
  int sync;
  @JsonKey()
  int flag;
  @JsonKey()
  String url;
  @JsonKey()
  String icon;
  @JsonKey()
  String remark;

  ChannelInfo(this.id, this.channelId, this.tag, this.label, this.name,
      this.type, this.visible, this.blocked, this.sync, this.flag, this.url,
      this.icon, this.remark);


  @override
  String toString() {
    return 'ChannelInfo{id: $id, channelId: $channelId, tag: $tag, label: $label, name: $name, type: $type, visible: $visible, blocked: $blocked, sync: $sync, flag: $flag, url: $url, icon: $icon, remark: $remark}';
  }

  factory ChannelInfo.fromJson(Map<String, dynamic> json) => _$ChannelInfoFromJson(json);



}