import 'package:json_annotation/json_annotation.dart';
part 'ufc_event_info.g.dart';

@JsonSerializable()
class UfcEventInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String event_date;
  @JsonKey()
  String secondary_feature_image;
  @JsonKey()
  String ticket_image;
  @JsonKey()
  String event_time_zone_text;
  @JsonKey()
  String short_description;
  @JsonKey()
  String event_dategmt;
  @JsonKey()
  String end_event_dategmt;
  @JsonKey()
  String ticketurl;
  @JsonKey()
  String ticket_seller_name;
  @JsonKey()
  String base_title;
  @JsonKey()
  String title_tag_line;
  @JsonKey()
  int statid;
  @JsonKey()
  String feature_image;
  @JsonKey()
  String subtitle;
  @JsonKey()
  String event_status;
  @JsonKey()
  String arena;
  @JsonKey()
  String location;

  factory UfcEventInfo.fromJson(Map<String, dynamic> json) => _$UfcEventInfoFromJson(json);

  UfcEventInfo();

  @override
  String toString() {
    return 'UfcEventInfo{id: $id, event_date: $event_date, secondary_feature_image: $secondary_feature_image, ticket_image: $ticket_image, event_time_zone_text: $event_time_zone_text, short_description: $short_description, event_dategmt: $event_dategmt, end_event_dategmt: $end_event_dategmt, ticketurl: $ticketurl, ticket_seller_name: $ticket_seller_name, base_title: $base_title, title_tag_line: $title_tag_line, statid: $statid}';
  }


}