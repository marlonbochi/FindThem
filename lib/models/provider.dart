import 'package:find_them/models/user.dart';

class Provider {

  int id;
  String name;
  String photo;
  double rateAVG;
  User user;
  String city;
  String neighborhood;
  String address;
  String state;
  String cep;
  String number;
  String complement;
  double latitude;
  double longitude;

  Provider(
      this.id,
      this.name,
      this.photo,
      this.rateAVG,
      this.user,
      this.city,
      this.neighborhood,
      this.address,
      this.state,
      this.cep,
      this.number,
      this.complement,
      this.latitude,
      this.longitude
      );

  Provider.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.photo = json["photo"];
    this.rateAVG = json["rateAVG"];
    this.user = User.fromJson(json["user"]);
    this.city = json["city"];
    this.neighborhood = json["neighborhood"];
    this.address = json["address"];
    this.state = json["state"];
    this.cep = json["cep"];
    this.number = json["number"];
    this.complement = json["complement"];
    this.latitude = json["latitude"];
    this.longitude = json["longitude"];
  }
}