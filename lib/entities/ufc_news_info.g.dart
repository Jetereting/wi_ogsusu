// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ufc_news_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UfcNewsInfo _$UfcNewsInfoFromJson(Map<String, dynamic> json) {
  return UfcNewsInfo()
    ..id = json['id'] as int
    ..external_url_text = json['external_url_text'] as String
    ..author = json['author'] as String
    ..title = json['title'] as String
    ..article_media_id = json['article_media_id'] as String
    ..article_date = json['article_date'] as String
    ..thumbnail = json['thumbnail'] as String
    ..external_url = json['external_url'] as String
    ..introduction = json['introduction'] as String
    ..article_fighter_id = json['article_fighter_id'] as String
    ..featured_news_category = json['featured_news_category'] as String
    ..last_modified = json['last_modified'] as String
    ..url_name = json['url_name'] as String
    ..created = json['created'] as String
    ..published_start_date = json['published_start_date'] as String
    ..keyword_ids =
        (json['keyword_ids'] as List)?.map((e) => e as int)?.toList();
}

Map<String, dynamic> _$UfcNewsInfoToJson(UfcNewsInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'external_url_text': instance.external_url_text,
      'author': instance.author,
      'title': instance.title,
      'article_media_id': instance.article_media_id,
      'article_date': instance.article_date,
      'thumbnail': instance.thumbnail,
      'external_url': instance.external_url,
      'introduction': instance.introduction,
      'article_fighter_id': instance.article_fighter_id,
      'featured_news_category': instance.featured_news_category,
      'last_modified': instance.last_modified,
      'url_name': instance.url_name,
      'created': instance.created,
      'published_start_date': instance.published_start_date,
      'keyword_ids': instance.keyword_ids
    };
