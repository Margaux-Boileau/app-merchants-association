class User{

  int? id;
  String? name;
  String? password;
  String? address;
  String? schedule;
  String? image;
  int? sector;

  User({required this.id,
    required this.name,
    required this.password,
    required this.address,
    required this.schedule,
    required this.image,
    required this.sector});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        address: json["address"],
        schedule: json["schedule"],
        image: json["image"],
        sector: json["sector"]
    );
  }


}