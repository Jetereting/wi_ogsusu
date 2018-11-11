// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) {
  return ProductInfo(
      json['id'] as int,
      json['label'] as String,
      json['subtitle'] as String,
      json['currency'] as String,
      (json['price'] as num)?.toDouble(),
      (json['discount'] as num)?.toDouble(),
      json['description'] as String,
      json['icon'] as String,
      json['link'] as String,
      json['remark'] as String,
      json['type'] as int,
      json['agent'] as int,
      json['platform'] as int,
      json['flag'] as int,
      json['visible'] as bool);
}

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'subtitle': instance.subtitle,
      'currency': instance.currency,
      'price': instance.price,
      'discount': instance.discount,
      'description': instance.description,
      'icon': instance.icon,
      'link': instance.link,
      'remark': instance.remark,
      'type': instance.type,
      'agent': instance.agent,
      'platform': instance.platform,
      'flag': instance.flag,
      'visible': instance.visible
    };
