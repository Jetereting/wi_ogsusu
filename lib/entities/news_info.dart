import 'package:json_annotation/json_annotation.dart';
import 'epg_detail_info.dart';
part 'news_info.g.dart';

@JsonSerializable()
class NewsInfo extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String newsId;
  @JsonKey()
  String categoryId;
  @JsonKey()
  String releaseDate;
  @JsonKey()
  String title;
  @JsonKey()
  String description;
  @JsonKey()
  String detailLink;
  @JsonKey()
  String icon;
  @JsonKey()
  String iconCaption;


  NewsInfo(this.id, this.newsId, this.categoryId, this.releaseDate, this.title,
      this.description, this.detailLink, this.icon, this.iconCaption);


  @override
  String toString() {
    return 'NewsInfo{id: $id, newsId: $newsId, categoryId: $categoryId, releaseDate: $releaseDate, title: $title, description: $description, detailLink: $detailLink, icon: $icon, iconCaption: $iconCaption}';
  }

  factory NewsInfo.fromJson(Map<String, dynamic> json) => _$NewsInfoFromJson(json);



}