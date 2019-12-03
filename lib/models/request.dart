import 'package:find_them/models/client.dart';
import 'package:find_them/models/provider.dart';
import 'package:find_them/models/service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable()
class Request {

  int id;
  Client client;
  Provider provider;
  Service service;
  DateTime dateStart;
  DateTime dateEnd;
  String description;
  int cep;
  String state;
  String address;
  String numberAddress;
  String complementAddress;
  String neighborhoodAddress;
  String city;
  double latitude;
  double longitude;
  String status;
  double value;
  bool enabled;

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
      this.status,
      this.value,
      this.enabled
      );

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}