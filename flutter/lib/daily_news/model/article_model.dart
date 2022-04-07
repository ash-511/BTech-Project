//Now let's create the article model
// for that we just need to copy the property from the json structure
// and make a dart object

import 'source_model.dart';

class Article {
  Source source;
  //String author;
  String title;
  // String description;
  // String url;
  // String urlToImage;
  // String publishedAt;
  //String content;

  //Now let's create the constructor
  Article(
      {required this.source,
        required this.title,
        // required this.description,
        // required this.url,
        // required this.urlToImage,
        //required this.publishedAt,
      });
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      //author: json['author']  as String?,//key1: json["key1"] == null ? null : json["key1"],
      title: json['title'] as String,
      //description: json['description'] as String?,
      // url: json['url'] ==null? "": json["url"] as String?,
      // urlToImage: json['urlToImage'] ==null? "": json["urlToImage"] as String?,
      // publishedAt: json['publishedAt'] ==null? "": json["publishedAt"] as String?,
      //content: json['content'] as String,
    );
  }
}
