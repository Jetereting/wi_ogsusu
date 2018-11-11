// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) {
  return ImageInfo(
      json['id'] as int,
      json['label'] as String,
      json['name'] as String,
      json['url'] as String,
      json['link'] as String,
      json['flag'] as int,
      json['type'] as int,
      json['agentId'] as int,
      json['platform'] as int,
      json['location'] as int,
      json['visible'] as bool,
      json['description'] as String,
      json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      json['modifyTime'] == null
          ? null
          : DateTime.parse(json['modifyTime'] as String));
}

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'name': instance.name,
      'url': instance.url,
      'link': instance.link,
      'flag': instance.flag,
      'type': instance.type,
      'agentId': instance.agentId,
      'platform': instance.platform,
      'location': instance.location,
      'visible': instance.visible,
      'description': instance.description,
      'createTime': instance.createTime?.toIso8601String(),
      'modifyTime': instance.modifyTime?.toIso8601String()
    };
