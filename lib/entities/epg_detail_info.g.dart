// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epg_detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpgDetailInfo _$EpgDetailInfoFromJson(Map<String, dynamic> json) {
  return EpgDetailInfo(json['channelId'] as String, json['startTime'] as int,
      json['endTime'] as int, json['label'] as String);
}

Map<String, dynamic> _$EpgDetailInfoToJson(EpgDetailInfo instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'label': instance.label
    };
