// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventInfo _$EventInfoFromJson(Map<String, dynamic> json) {
  return EventInfo()
    ..id = json['id'] as int
    ..categoryId = json['categoryId'] as int
    ..label = json['label'] as String
    ..name = json['name'] as String
    ..icon = json['icon'] as String
    ..link = json['link'] as String
    ..description = json['description'] as String
    ..type = json['type'] as int
    ..agent = json['agent'] as int
    ..platform = json['platform'] as int
    ..flag = json['flag'] as int;
}

Map<String, dynamic> _$EventInfoToJson(EventInfo instance) => <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'label': instance.label,
      'name': instance.name,
      'icon': instance.icon,
      'link': instance.link,
      'description': instance.description,
      'type': instance.type,
      'agent': instance.agent,
      'platform': instance.platform,
      'flag': instance.flag
    };
