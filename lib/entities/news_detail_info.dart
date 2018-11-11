import 'package:json_annotation/json_annotation.dart';
part 'news_detail_info.g.dart';

@JsonSerializable()
class NewsDetailInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String newsId;
  @JsonKey()
  String tag;
  @JsonKey()
  String releaseDate;
  @JsonKey()
  String title;
  @JsonKey()
  String content;
  @JsonKey()
  String icon;

  factory NewsDetailInfo.fromJson(Map<String, dynamic> json) => _$NewsDetailInfoFromJson(json);

  NewsDetailInfo(this.id, this.newsId, this.tag, this.releaseDate, this.title,
      this.content, this.icon);

  @override
  String toString() {
    return 'NewsDetailInfo{id: $id, newsId: $newsId, tag: $tag, releaseDate: $releaseDate, title: $title, content: $content, icon: $icon}';
  }


}