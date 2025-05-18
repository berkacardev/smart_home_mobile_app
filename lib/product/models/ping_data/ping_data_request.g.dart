// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PingDataRequest _$PingDataRequestFromJson(Map<String, dynamic> json) =>
    PingDataRequest(
      type: $enumDecodeNullable(_$DataTypeEnumMap, json['type']),
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PingDataRequestToJson(PingDataRequest instance) =>
    <String, dynamic>{
      'type': _$DataTypeEnumMap[instance.type],
      'timestamp': instance.timestamp,
    };

const _$DataTypeEnumMap = {
  DataType.ping: 'ping',
  DataType.pong: 'pong',
  DataType.control: 'control',
  DataType.status: 'status',
};
