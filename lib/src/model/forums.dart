class Forums {
  final int id;
  final String title;
  final String date;

  Forums({
    required this.id,
    required this.title,
    required this.date,
  });

  factory Forums.fromJson(Map<String, dynamic> json) {
    return Forums(
      id: json['id'],
      title: json['title'],
      date: json['date'],
    );
  }
}