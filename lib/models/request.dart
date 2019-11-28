import 'package:find_them/models/client.dart';
import 'package:find_them/models/provider.dart';
import 'package:find_them/models/service.dart';
import 'package:find_them/models/user.dart';

class Request {

  int id;
  Client client;
  Provider provider;
  Service service;
  DateTime dateStart;
  DateTime dateEnd;
  String description;
  String cep;
  String state;
  String address;
  String numberAddress;
  String city;
  double latitude;
  double longitude;

  Request(
      this.id,
      this.client,
      this.provider,
      this.service,
      this.dateStart,
      this.dateEnd,
      this.description,
      this.cep,
      this.state,
      this.address,
      this.numberAddress,
      this.city,
      this.latitude,
      this.longitude
      );

  Request.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.client = Client.fromJson(json["client"]);
    this.provider = Provider.fromJson(json["provider"]);
    this.service = Service.fromJson(json["service"]);
    this.dateStart = json["dateStart"];
    this.dateEnd = json["dateEnd"];
    this.description = json["description"];
    this.address = json["address"];
    this.state = json["state"];
    this.cep = json["cep"];
    this.numberAddress = json["numberAddress"];
    this.city = json["city"];
    this.latitude = json["latitude"];
    this.longitude = json["longitude"];
  }
}