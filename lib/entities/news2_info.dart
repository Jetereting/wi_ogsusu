import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class News2Info extends Object{

  @JsonKey()
  int id;
  @JsonKey()
  String category;
  @JsonKey()
  String country;
  @JsonKey()
  String title;
  @JsonKey()
  String description;
  @JsonKey()
  String content;
  @JsonKey()
  String link;
  @JsonKey()
  String icon;
  @JsonKey()
  String source;
  @JsonKey()
  int releaseTime;

  News2Info.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        category = json['category'],
        country = json['country'],
        title = json['title'],
        description = json['description'],
        content = json['content'],
        link = json['link'],
        icon = json['icon'],
        source = json['source'],
        releaseTime = json['releaseTime'];

  @override
  String toString() {
    return 'News2Info{id: $id, category: $category, country: $country, title: $title, description: $description, content: $content, link: $link, icon: $icon, source: $source, releaseTime: $releaseTime}';
  }


}