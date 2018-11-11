// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_game_channel_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportGameChannelInfo _$SportGameChannelInfoFromJson(Map<String, dynamic> json) {
  return SportGameChannelInfo(json['id'] as int, json['channelId'] as String,
      json['label'] as String, json['icon'] as String);
}

Map<String, dynamic> _$SportGameChannelInfoToJson(
        SportGameChannelInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'label': instance.label,
      'icon': instance.icon
    };
