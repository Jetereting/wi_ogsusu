import 'package:json_annotation/json_annotation.dart';
import 'epg_detail_info.dart';
part 'product_info.g.dart';

@JsonSerializable()
class ProductInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String label;
  @JsonKey()
  String subtitle;
  @JsonKey()
  String currency;
  @JsonKey()
  double price;
  @JsonKey()
  double discount;
  @JsonKey()
  String description;
  @JsonKey()
  String icon;
  @JsonKey()
  String link;
  @JsonKey()
  String remark;
  @JsonKey()
  int type;
  @JsonKey()
  int agent;
  @JsonKey()
  int platform;
  @JsonKey()
  int flag;
  @JsonKey()
  bool visible;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => _$ProductInfoFromJson(json);

  ProductInfo(this.id, this.label, this.subtitle, this.currency, this.price,
      this.discount, this.description, this.icon, this.link, this.remark,
      this.type, this.agent, this.platform, this.flag, this.visible);

  @override
  String toString() {
    return 'ProductInfo{id: $id, label: $label, subtitle: $subtitle, currency: $currency, price: $price, discount: $discount, description: $description, icon: $icon, link: $link, remark: $remark, type: $type, agent: $agent, platform: $platform, flag: $flag, visible: $visible}';
  }


}