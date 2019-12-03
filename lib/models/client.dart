import 'package:find_them/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {

  int id;
  double rateAVG;
  User user;

  Client(
      this.id,
      this.rateAVG,
      this.user,
      );

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}