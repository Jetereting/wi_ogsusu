import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OgsusuVipInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String label;
  @JsonKey()
  int level;
  @JsonKey()
  int month;
  @JsonKey()
  double price;
  @JsonKey()
  String description;
  @JsonKey()
  String rights;


  OgsusuVipInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        label = json['label'],
        level = json['level'],
        month = json['month'],
        price = json['price'],
        description = json['description'],
        rights = json['rights'];

  @override
  String toString() {
    return 'OgsusuVipInfo{id: $id, label: $label, level: $level, month: $month, price: $price, description: $description, rights: $rights}';
  }


}