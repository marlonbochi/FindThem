// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) {
  return Request(
    json['id'] as int,
    json['client'] == null
        ? null
        : Client.fromJson(json['client'] as Map<String, dynamic>),
    json['provider'] == null
        ? null
        : Provider.fromJson(json['provider'] as Map<String, dynamic>),
    json['service'] == null
        ? null
        : Service.fromJson(json['service'] as Map<String, dynamic>),
    json['dateStart'] == null
        ? null
        : DateTime.parse(json['dateStart'] as String),
    json['dateEnd'] == null ? null : DateTime.parse(json['dateEnd'] as String),
    json['description'] as String,
    json['cep'] as int,
    json['address'] as String,
    json['numberAddress'] as String,
    json['complementAddress'] as String,
    json['neighborhoodAddress'] as String,
    json['state'] as String,
    json['city'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['status'] as String,
    (json['value'] as num)?.toDouble(),
    json['enabled'] as bool,
  );
}

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'provider': instance.provider,
      'service': instance.service,
      'dateStart': instance.dateStart?.toIso8601String(),
      'dateEnd': instance.dateEnd?.toIso8601String(),
      'description': instance.description,
      'cep': instance.cep,
      'state': instance.state,
      'address': instance.address,
      'numberAddress': instance.numberAddress,
      'complementAddress': instance.complementAddress,
      'neighborhoodAddress': instance.neighborhoodAddress,
      'city': instance.city,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': instance.status,
      'value': instance.value,
      'enabled': instance.enabled,
    };
