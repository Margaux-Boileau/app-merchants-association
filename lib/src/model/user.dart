import 'package:app_merchants_association/src/model/shop.dart';

class User{

  int? id;
  String? name;
  String? password;
  bool shopOwner;
  String? address;
  String? schedule;
  String? image;
  int? sector;
  //Shop? shop;

  User({required this.id,
    required this.name,
    required this.password,
    required this.address,
    required this.schedule,
    required this.image,
    required this.sector,
    required this.shopOwner
    //required this.shop
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["username"],
        password: json["password"],
        address: json["address"],
        schedule: json["schedule"],
        image: json["image"],
        sector: json["sector"],
        shopOwner: json["is_owner_of_shop"]
        //shop: Shop.fromJson(json["shop"])
    );
  }


}