// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_event_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportEventInfo _$SportEventInfoFromJson(Map<String, dynamic> json) {
  return SportEventInfo(
      json['id'] as int,
      json['categoryId'] as int,
      json['label'] as String,
      json['name'] as String,
      json['icon'] as String,
      json['description'] as String,
      json['type'] as int,
      json['agent'] as int,
      json['platform'] as int,
      json['flag'] as int);
}

Map<String, dynamic> _$SportEventInfoToJson(SportEventInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'label': instance.label,
      'name': instance.name,
      'icon': instance.icon,
      'description': instance.description,
      'type': instance.type,
      'agent': instance.agent,
      'platform': instance.platform,
      'flag': instance.flag
    };
