class PushNotification{
  String? title;
  String? content;

  PushNotification(this.title, this.content);

  PushNotification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    return data;
  }

}