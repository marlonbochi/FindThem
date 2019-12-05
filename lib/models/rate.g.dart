// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rate _$RateFromJson(Map<String, dynamic> json) {
  return Rate(
    json['id'] as int,
    json['requestID'] as int,
    json['clientID'] as int,
    json['providerID'] as int,
    json['rate'] as int,
    json['enabled'] as bool,
  );
}

Map<String, dynamic> _$RateToJson(Rate instance) => <String, dynamic>{
      'id': instance.id,
      'requestID': instance.requestID,
      'clientID': instance.clientID,
      'providerID': instance.providerID,
      'rate': instance.rate,
      'enabled': instance.enabled,
    };
