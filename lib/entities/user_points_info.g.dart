// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_points_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPointsInfo _$UserPointsInfoFromJson(Map<String, dynamic> json) {
  return UserPointsInfo(
      json['id'] as int,
      json['userId'] as int,
      json['points'] as int,
      json['type'] as int,
      json['agent'] as int,
      json['platform'] as int,
      json['flag'] as int,
      json['createTime'] as String,
      json['modifyTime'] as String);
}

Map<String, dynamic> _$UserPointsInfoToJson(UserPointsInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'points': instance.points,
      'type': instance.type,
      'agent': instance.agent,
      'platform': instance.platform,
      'flag': instance.flag,
      'createTime': instance.createTime,
      'modifyTime': instance.modifyTime
    };
