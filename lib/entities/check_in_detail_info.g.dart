// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInDetailInfo _$CheckInDetailInfoFromJson(Map<String, dynamic> json) {
  return CheckInDetailInfo(
      json['id'] as int,
      json['userId'] as int,
      json['type'] as int,
      json['agent'] as int,
      json['platform'] as int,
      json['flag'] as int,
      json['createTime'] as String,
      json['modifyTime'] as String);
}

Map<String, dynamic> _$CheckInDetailInfoToJson(CheckInDetailInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'agent': instance.agent,
      'platform': instance.platform,
      'flag': instance.flag,
      'createTime': instance.createTime,
      'modifyTime': instance.modifyTime
    };
