import 'package:json_annotation/json_annotation.dart';
part 'ufc_fighter_info.g.dart';

@JsonSerializable()
class UfcFighterInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  int wins;
  @JsonKey()
  int statid;
  @JsonKey()
  int losses;
  @JsonKey()
  String last_name;
  @JsonKey()
  String weight_class;
  @JsonKey()
  bool title_holder;
  @JsonKey()
  int draws;
  @JsonKey()
  String first_name;
  @JsonKey()
  String fighter_status;
  @JsonKey()
  String thumbnail;

  factory UfcFighterInfo.fromJson(Map<String, dynamic> json) => _$UfcFighterInfoFromJson(json);

  UfcFighterInfo();

  @override
  String toString() {
    return 'UfcFighterInfo{id: $id, wins: $wins, statid: $statid, losses: $losses, last_name: $last_name, weight_class: $weight_class, title_holder: $title_holder, draws: $draws, first_name: $first_name, fighter_status: $fighter_status, thumbnail: $thumbnail}';
  }


}