class Shop {
  int? id;
  String? name;
  String? address;
  String? schedule;
  String? phone;
  String? sector;
  String? image;
  String? instagram;
  String? facebook;
  String? webpage;

  Shop({this.id, this.name, this.address, this.schedule, this.phone, this.sector, this.image, this.instagram, this.facebook, this.webpage});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    schedule = json['schedule'];
    phone = json['phone'];
    sector = json['sector'];
    image = json['image'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    webpage = json['webpage'];
  }

}

