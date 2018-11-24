// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_points_detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPointsDetailInfo _$UserPointsDetailInfoFromJson(Map<String, dynamic> json) {
  return UserPointsDetailInfo(
      json['id'] as int,
      json['userId'] as int,
      json['action'] as int,
      json['points'] as int,
      json['description'] as String,
      json['type'] as int,
      json['agent'] as int,
      json['platform'] as int,
      json['flag'] as int,
      json['createTime'] as String,
      json['modifyTime'] as String);
}

Map<String, dynamic> _$UserPointsDetailInfoToJson(
        UserPointsDetailInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'action': instance.action,
      'points': instance.points,
      'description': instance.description,
      'type': instance.type,
      'agent': instance.agent,
      'platform': instance.platform,
      'flag': instance.flag,
      'createTime': instance.createTime,
      'modifyTime': instance.modifyTime
    };
