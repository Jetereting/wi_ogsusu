import 'package:json_annotation/json_annotation.dart';
import 'epg_detail_info.dart';
part 'product_sku_info.g.dart';

@JsonSerializable()
class ProductSkuInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  int productId;
  @JsonKey()
  String label;
  @JsonKey()
  String color;
  @JsonKey()
  String model;
  @JsonKey()
  String size;
  @JsonKey()
  int stock;
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
  bool visible;

  factory ProductSkuInfo.fromJson(Map<String, dynamic> json) => _$ProductSkuInfoFromJson(json);

  ProductSkuInfo(this.id, this.productId, this.label, this.color, this.model,
      this.size, this.stock, this.currency, this.price, this.discount,
      this.description, this.icon, this.link, this.remark, this.visible);

  @override
  String toString() {
    return 'ProductSkuInfo{id: $id, productId: $productId, label: $label, color: $color, model: $model, size: $size, stock: $stock, currency: $currency, price: $price, discount: $discount, description: $description, icon: $icon, link: $link, remark: $remark, visible: $visible}';
  }


}