import 'package:json_annotation/json_annotation.dart';

part 'image_info.g.dart';

@JsonSerializable()
class ImageInfo extends Object {

  int id;
  String label;
  String name;
  String url;
  String link;
  int flag;
  int type;
  int agentId;
  int platform;
  int location;
  bool visible;
  String description;
  DateTime createTime;
  DateTime modifyTime;

  ImageInfo(this.id, this.label, this.name, this.url, this.link,
      this.flag, this.type, this.agentId, this.platform,
      this.location, this.visible, this.description, this.createTime,
      this.modifyTime);

  factory ImageInfo.fromJson(Map<String, dynamic> json) => _$ImageInfoFromJson(json);

  @override
  String toString() {
    return 'ImageInfo{'
        'id: $id, '
        'label: $label, '
        'name: $name, '
        'url: $url, '
        'link: $link, '
        'flag: $flag, '
        'type: $type, '
        'agentId: $agentId, '
        'platform: $platform, '
        'location: $location, '
        'visible: $visible, '
        'description: $description, '
        'createTime: $createTime, '
        'modifyTime: $modifyTime}';
  }


}