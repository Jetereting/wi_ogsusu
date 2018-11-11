// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_game_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportGameInfo _$SportGameInfoFromJson(Map<String, dynamic> json) {
  return SportGameInfo(
      json['id'] as int,
      json['categoryId'] as int,
      json['eventId'] as int,
      json['flag'] as int,
      json['time'] as String,
      json['homeTeam'] as String,
      json['guestTeam'] as String,
      json['channelIds'] as String);
}

Map<String, dynamic> _$SportGameInfoToJson(SportGameInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'eventId': instance.eventId,
      'flag': instance.flag,
      'time': instance.time,
      'homeTeam': instance.homeTeam,
      'guestTeam': instance.guestTeam,
      'channelIds': instance.channelIds
    };
