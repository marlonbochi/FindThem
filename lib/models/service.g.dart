// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    json['id'] as int,
    json['name'] as String,
    (json['timeExecution'] as num)?.toDouble(),
    (json['price'] as num)?.toDouble(),
    json['description'] as String,
    json['materials'] as String,
    json['provider'] == null
        ? null
        : Provider.fromJson(json['provider'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'timeExecution': instance.timeExecution,
      'price': instance.price,
      'description': instance.description,
      'materials': instance.materials,
      'provider': instance.provider,
    };
