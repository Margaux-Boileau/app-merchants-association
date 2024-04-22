import 'package:app_merchants_association/src/model/post_image.dart';

class Post {
  final String title;
  final String date;
  final String body;
  final List<String> media;
  final List<String> comments; //TODO Por ahora se dejará un String
  final int idCreator;

  Post({
    required this.title,
    required this.date,
    required this.body,
    required this.media,
    required this.comments, //TODO Por ahora se dejará un String
    required this.idCreator,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      date: json['date'],
      body: json['body'],
      media: List<String>.from(json['media']),
      comments: List<String>.from(json['comments']), //TODO Por ahora se dejará un String
      idCreator: json['idCreator'],
    );
  }
}
