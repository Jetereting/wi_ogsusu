// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInInfo _$CheckInInfoFromJson(Map<String, dynamic> json) {
  return CheckInInfo(
      json['id'] as int,
      json['userId'] as int,
      json['checkInDays'] as int,
      json['checkInContinuousDays'] as int,
      json['points'] as int,
      json['type'] as int,
      json['agent'] as int,
      json['platform'] as int,
      json['flag'] as int,
      json['currentChecked'] as bool,
      json['createTime'] as String,
      json['modifyTime'] as String,
      (json['checkInDetailInfoList'] as List)
          ?.map((e) => e == null
              ? null
              : CheckInDetailInfo.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CheckInInfoToJson(CheckInInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'checkInDays': instance.checkInDays,
      'checkInContinuousDays': instance.checkInContinuousDays,
      'points': instance.points,
      'type': instance.type,
      'agent': instance.agent,
      'platform': instance.platform,
      'flag': instance.flag,
      'currentChecked': instance.currentChecked,
      'createTime': instance.createTime,
      'modifyTime': instance.modifyTime,
      'checkInDetailInfoList': instance.checkInDetailInfoList
    };
