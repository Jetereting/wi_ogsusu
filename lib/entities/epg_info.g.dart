// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epg_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpgInfo _$EpgInfoFromJson(Map<String, dynamic> json) {
  return EpgInfo(
      json['id'] as int,
      json['category'] as int,
      json['channelId'] as String,
      json['label'] as String,
      json['name'] as String,
      json['icon'] as String,
      json['currentPlay'] as String,
      json['nextPlay'] as String);
}

Map<String, dynamic> _$EpgInfoToJson(EpgInfo instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'channelId': instance.channelId,
      'label': instance.label,
      'name': instance.name,
      'icon': instance.icon,
      'currentPlay': instance.currentPlay,
      'nextPlay': instance.nextPlay
    };
