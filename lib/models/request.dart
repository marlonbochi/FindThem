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
  String complementAddress;
  String neighborhoodAddress;
  String city;
  double latitude;
  double longitude;
  String status;

  Request(
      this.id,
      this.client,
      this.provider,
      this.service,
      this.dateStart,
      this.dateEnd,
      this.description,
      this.cep,
      this.address,
      this.numberAddress,
      this.complementAddress,
      this.neighborhoodAddress,
      this.state,
      this.city,
      this.latitude,
      this.longitude,
      this.status
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
    this.complementAddress = json["complementAddress"];
    this.neighborhoodAddress = json["neighborhoodAddress"];
    this.city = json["city"];
    this.latitude = json["latitude"];
    this.longitude = json["longitude"];
    this.status = json["status"];
  }
}