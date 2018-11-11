// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDetailInfo _$NewsDetailInfoFromJson(Map<String, dynamic> json) {
  return NewsDetailInfo(
      json['id'] as int,
      json['newsId'] as String,
      json['tag'] as String,
      json['releaseDate'] as String,
      json['title'] as String,
      json['content'] as String,
      json['icon'] as String);
}

Map<String, dynamic> _$NewsDetailInfoToJson(NewsDetailInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'newsId': instance.newsId,
      'tag': instance.tag,
      'releaseDate': instance.releaseDate,
      'title': instance.title,
      'content': instance.content,
      'icon': instance.icon
    };
