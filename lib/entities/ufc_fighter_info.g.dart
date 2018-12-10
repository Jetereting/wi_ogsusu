// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ufc_fighter_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UfcFighterInfo _$UfcFighterInfoFromJson(Map<String, dynamic> json) {
  return UfcFighterInfo()
    ..id = json['id'] as int
    ..wins = json['wins'] as int
    ..statid = json['statid'] as int
    ..losses = json['losses'] as int
    ..last_name = json['last_name'] as String
    ..weight_class = json['weight_class'] as String
    ..title_holder = json['title_holder'] as bool
    ..draws = json['draws'] as int
    ..first_name = json['first_name'] as String
    ..fighter_status = json['fighter_status'] as String
    ..thumbnail = json['thumbnail'] as String;
}

Map<String, dynamic> _$UfcFighterInfoToJson(UfcFighterInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wins': instance.wins,
      'statid': instance.statid,
      'losses': instance.losses,
      'last_name': instance.last_name,
      'weight_class': instance.weight_class,
      'title_holder': instance.title_holder,
      'draws': instance.draws,
      'first_name': instance.first_name,
      'fighter_status': instance.fighter_status,
      'thumbnail': instance.thumbnail
    };
