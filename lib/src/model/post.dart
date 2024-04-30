import 'package:app_merchants_association/src/model/comment.dart';

class Post {
  int id;
  String? title;
  String? date;
  String? body;
  List<String>? media;
  List<Comment?>? comments;
  int? idCreator;

  Post({
    required this.id,
    required this.title,
    required this.date,
    required this.body,
    required this.media,
    required this.comments,
    required this.idCreator,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // Lista de comments
    var comments = json['comments'] as List;
    List<Comment> commentsList = comments.map((i) => Comment.fromJson(i)).toList();


    return Post(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      body: json['body'],
      media: List<String>.from(json['media']),
      comments: commentsList,
      idCreator: json['idCreator'],
    );
  }


}
