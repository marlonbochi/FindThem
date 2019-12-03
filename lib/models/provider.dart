import 'package:find_them/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'provider.g.dart';

@JsonSerializable()

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

  factory Provider.fromJson(Map<String, dynamic> json) => _$ProviderFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderToJson(this);
}