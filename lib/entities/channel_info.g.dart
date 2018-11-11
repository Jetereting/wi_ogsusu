// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelInfo _$ChannelInfoFromJson(Map<String, dynamic> json) {
  return ChannelInfo(
      json['id'] as int,
      json['channelId'] as String,
      json['tag'] as String,
      json['label'] as String,
      json['name'] as String,
      json['type'] as int,
      json['visible'] as bool,
      json['blocked'] as bool,
      json['sync'] as int,
      json['flag'] as int,
      json['url'] as String,
      json['icon'] as String,
      json['remark'] as String);
}

Map<String, dynamic> _$ChannelInfoToJson(ChannelInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'tag': instance.tag,
      'label': instance.label,
      'name': instance.name,
      'type': instance.type,
      'visible': instance.visible,
      'blocked': instance.blocked,
      'sync': instance.sync,
      'flag': instance.flag,
      'url': instance.url,
      'icon': instance.icon,
      'remark': instance.remark
    };
