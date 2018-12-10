// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ufc_event_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UfcEventInfo _$UfcEventInfoFromJson(Map<String, dynamic> json) {
  return UfcEventInfo()
    ..id = json['id'] as int
    ..event_date = json['event_date'] as String
    ..secondary_feature_image = json['secondary_feature_image'] as String
    ..ticket_image = json['ticket_image'] as String
    ..event_time_zone_text = json['event_time_zone_text'] as String
    ..short_description = json['short_description'] as String
    ..event_dategmt = json['event_dategmt'] as String
    ..end_event_dategmt = json['end_event_dategmt'] as String
    ..ticketurl = json['ticketurl'] as String
    ..ticket_seller_name = json['ticket_seller_name'] as String
    ..base_title = json['base_title'] as String
    ..title_tag_line = json['title_tag_line'] as String
    ..statid = json['statid'] as int
    ..feature_image = json['feature_image'] as String
    ..subtitle = json['subtitle'] as String
    ..event_status = json['event_status'] as String
    ..arena = json['arena'] as String
    ..location = json['location'] as String;
}

Map<String, dynamic> _$UfcEventInfoToJson(UfcEventInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_date': instance.event_date,
      'secondary_feature_image': instance.secondary_feature_image,
      'ticket_image': instance.ticket_image,
      'event_time_zone_text': instance.event_time_zone_text,
      'short_description': instance.short_description,
      'event_dategmt': instance.event_dategmt,
      'end_event_dategmt': instance.end_event_dategmt,
      'ticketurl': instance.ticketurl,
      'ticket_seller_name': instance.ticket_seller_name,
      'base_title': instance.base_title,
      'title_tag_line': instance.title_tag_line,
      'statid': instance.statid,
      'feature_image': instance.feature_image,
      'subtitle': instance.subtitle,
      'event_status': instance.event_status,
      'arena': instance.arena,
      'location': instance.location
    };
