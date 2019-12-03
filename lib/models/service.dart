import 'package:find_them/models/provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {

  int id;
  String name;
  double timeExecution;
  double price;
  String description;
  String materials;
  Provider provider;

  Service(
      this.id,
      this.name,
      this.timeExecution,
      this.price,
      this.description,
      this.materials,
      this.provider,
      );

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}