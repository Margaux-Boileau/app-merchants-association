import 'package:app_merchants_association/src/model/post_image.dart';

class Post {
  int id;
  String profileImage;
  String category;
  String localName;
  String title;
  String date;
  String body;
  List<PostImage> images;
  int idCreator;

  Post({
    required this.id,
    required this.profileImage,
    required this.category,
    required this.localName,
    required this.title,
    required this.date,
    required this.body,
    required this.images,
    required this.idCreator,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    var imagesFromJson = json['images'] as List;
    List<PostImage> imagesList =
        imagesFromJson.map((i) => PostImage.fromJson(i)).toList();

    return Post(
      id: json['id'],
      profileImage: json['profile_image'],
      category: json['category'],
      localName: json['local_name'],
      title: json['title'],
      date: json['date'],
      body: json['body'],
      images: imagesList,
      idCreator: json['id_creator'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_image': profileImage,
      'category': category,
      'local_name': localName,
      'title': title,
      'date': date,
      'body': body,
      'images': images,
      'id_creator': idCreator,
    };
  }
}
