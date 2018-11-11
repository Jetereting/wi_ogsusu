// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsInfo _$NewsInfoFromJson(Map<String, dynamic> json) {
  return NewsInfo(
      json['id'] as int,
      json['newsId'] as String,
      json['categoryId'] as String,
      json['releaseDate'] as String,
      json['title'] as String,
      json['description'] as String,
      json['detailLink'] as String,
      json['icon'] as String,
      json['iconCaption'] as String);
}

Map<String, dynamic> _$NewsInfoToJson(NewsInfo instance) => <String, dynamic>{
      'id': instance.id,
      'newsId': instance.newsId,
      'categoryId': instance.categoryId,
      'releaseDate': instance.releaseDate,
      'title': instance.title,
      'description': instance.description,
      'detailLink': instance.detailLink,
      'icon': instance.icon,
      'iconCaption': instance.iconCaption
    };
