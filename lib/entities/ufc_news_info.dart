import 'package:json_annotation/json_annotation.dart';
part 'ufc_news_info.g.dart';

@JsonSerializable()
class UfcNewsInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String external_url_text;
  @JsonKey()
  String author;
  @JsonKey()
  String title;
  @JsonKey()
  String article_media_id;
  @JsonKey()
  String article_date;
  @JsonKey()
  String thumbnail;
  @JsonKey()
  String external_url;
  @JsonKey()
  String introduction;
  @JsonKey()
  String article_fighter_id;
  @JsonKey()
  String featured_news_category;
  @JsonKey()
  String last_modified;
  @JsonKey()
  String url_name;
  @JsonKey()
  String created;
  @JsonKey()
  String published_start_date;
  @JsonKey()
  List<int> keyword_ids;

  factory UfcNewsInfo.fromJson(Map<String, dynamic> json) => _$UfcNewsInfoFromJson(json);

  UfcNewsInfo();

  @override
  String toString() {
    return 'UfcNewsInfo{id: $id, external_url_text: $external_url_text, author: $author, title: $title, article_media_id: $article_media_id, article_date: $article_date, thumbnail: $thumbnail, external_url: $external_url, introduction: $introduction, article_fighter_id: $article_fighter_id, featured_news_category: $featured_news_category, last_modified: $last_modified, url_name: $url_name, created: $created, published_start_date: $published_start_date, keyword_ids: $keyword_ids}';
  }


}