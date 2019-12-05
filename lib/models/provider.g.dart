// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Provider _$ProviderFromJson(Map<String, dynamic> json) {
  return Provider(
    json['id'] as int,
    json['name'] as String,
    json['photo'] as String,
    (json['rateAVG'] as num)?.toDouble(),
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['city'] as String,
    json['neighborhood'] as String,
    json['address'] as String,
    json['state'] as String,
    json['cep'] as String,
    json['number'] as String,
    json['complement'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProviderToJson(Provider instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'rateAVG': instance.rateAVG,
      'user': instance.user,
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'address': instance.address,
      'state': instance.state,
      'cep': instance.cep,
      'number': instance.number,
      'complement': instance.complement,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
