// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TelemetryDataRequest _$TelemetryDataRequestFromJson(
        Map<String, dynamic> json) =>
    TelemetryDataRequest(
      type: $enumDecodeNullable(_$DataTypeEnumMap, json['type']),
      deviceIsActive: json['deviceIsActive'] as bool?,
      lockIsActive: json['lockIsActive'] as bool?,
      lightingIsActive: json['lightingIsActive'] as bool?,
    );

Map<String, dynamic> _$TelemetryDataRequestToJson(
        TelemetryDataRequest instance) =>
    <String, dynamic>{
      'type': _$DataTypeEnumMap[instance.type],
      'deviceIsActive': instance.deviceIsActive,
      'lockIsActive': instance.lockIsActive,
      'lightingIsActive': instance.lightingIsActive,
    };

const _$DataTypeEnumMap = {
  DataType.ping: 'ping',
  DataType.pong: 'pong',
  DataType.control: 'control',
  DataType.status: 'status',
};
