import 'package:find_them/models/user.dart';

class Service {

  int id;
  String name;
  double timeExecution;
  double price;
  String description;
  String materials;
  int providerID;

  Service(
      this.id,
      this.name,
      this.timeExecution,
      this.price,
      this.description,
      this.materials,
      this.providerID,
      );

  Service.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.timeExecution = json["timeExecution"];
    this.price = json["price"];
    this.description = json["description"];
    this.materials = json["materials"];
    this.providerID = json["providerID"];
  }
}