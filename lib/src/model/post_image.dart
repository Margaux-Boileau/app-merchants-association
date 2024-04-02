class PostImage {
  int id;
  String imageUrl;
  int idPost;

  PostImage({
    required this.id,
    required this.imageUrl,
    required this.idPost,
  });

  factory PostImage.fromJson(Map<String, dynamic> json) {
    return PostImage(
      id: json['id'],
      imageUrl: json['image_url'],
      idPost: json['id_post'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'id_post': idPost,
    };
  }
}