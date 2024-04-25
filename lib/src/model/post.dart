import 'package:app_merchants_association/src/model/post_image.dart';

class Post {
  int id;
  String? title;
  String? date;
  String? body;
  List<String?>? media;
  List<String?>? comments; //TODO Por ahora se dejará un String
  int? idCreator;

  Post({
    required this.id,
    required this.title,
    required this.date,
    required this.body,
    required this.media,
    required this.comments, //TODO Por ahora se dejará un String
    required this.idCreator,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      title: json['title'],
      date: json['date'],
      body: json['body'],
      media: List<String>.from(json['media']),
      comments: List<String>.from(json['comments']), //TODO Por ahora se dejará un String
      idCreator: json['idCreator'],
    );
  }
}
