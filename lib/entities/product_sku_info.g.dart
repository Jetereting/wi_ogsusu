// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sku_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSkuInfo _$ProductSkuInfoFromJson(Map<String, dynamic> json) {
  return ProductSkuInfo(
      json['id'] as int,
      json['productId'] as int,
      json['label'] as String,
      json['color'] as String,
      json['model'] as String,
      json['size'] as String,
      json['stock'] as int,
      json['currency'] as String,
      (json['price'] as num)?.toDouble(),
      (json['discount'] as num)?.toDouble(),
      json['description'] as String,
      json['icon'] as String,
      json['link'] as String,
      json['remark'] as String,
      json['visible'] as bool);
}

Map<String, dynamic> _$ProductSkuInfoToJson(ProductSkuInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'label': instance.label,
      'color': instance.color,
      'model': instance.model,
      'size': instance.size,
      'stock': instance.stock,
      'currency': instance.currency,
      'price': instance.price,
      'discount': instance.discount,
      'description': instance.description,
      'icon': instance.icon,
      'link': instance.link,
      'remark': instance.remark,
      'visible': instance.visible
    };
