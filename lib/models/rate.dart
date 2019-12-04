import 'package:json_annotation/json_annotation.dart';

part 'rate.g.dart';

@JsonSerializable()
class Rate {

  int id;
  int requestID;
  int clientID;
  int providerID;
  int rate;
  bool enabled;

  Rate(this.id,
      this.requestID,
      this.clientID,
      this.providerID,
      this.rate,
      this.enabled);

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);

  Map<String, dynamic> toJson() => _$RateToJson(this);

}