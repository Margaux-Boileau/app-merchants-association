class Comment {
  int? id;
  int? idCreator;
  String? content;
  String date;

  Comment({
    required this.id,
    required this.idCreator,
    required this.content,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      idCreator: json['idCreator'],
      content: json['content'],
      date: json['date'],
    );
  }
}