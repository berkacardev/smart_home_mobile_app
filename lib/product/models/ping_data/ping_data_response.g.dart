// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PingDataResponse _$PingDataResponseFromJson(Map<String, dynamic> json) =>
    PingDataResponse(
      type: $enumDecodeNullable(_$DataTypeEnumMap, json['type']),
      timestamp: const BigIntConverter().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$PingDataResponseToJson(PingDataResponse instance) =>
    <String, dynamic>{
      'type': _$DataTypeEnumMap[instance.type],
      'timestamp': const BigIntConverter().toJson(instance.timestamp),
    };

const _$DataTypeEnumMap = {
  DataType.ping: 'ping',
  DataType.pong: 'pong',
  DataType.control: 'control',
  DataType.status: 'status',
};
