import 'package:find_them/models/user.dart';

class Client {

  int id;
  String name;
  double rateAVG;
  User user;

  Client(
      this.id,
      this.name,
      this.rateAVG,
      this.user,
      );

  Client.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.rateAVG = json["rateAVG"];
    this.user = User.fromJson(json["user"]);
  }
}