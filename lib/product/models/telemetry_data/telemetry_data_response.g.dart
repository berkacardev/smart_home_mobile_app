// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TelemetryDataResponse _$TelemetryDataResponseFromJson(
        Map<String, dynamic> json) =>
    TelemetryDataResponse(
      type: $enumDecodeNullable(_$DataTypeEnumMap, json['type']),
      deviceIsActive: json['deviceIsActive'] as bool?,
      lockIsActive: json['lockIsActive'] as bool?,
      lightingIsActive: json['lightingIsActive'] as bool?,
      temperatureValue: (json['temperatureValue'] as num?)?.toDouble(),
      temperatureSensorIsInError: json['temperatureSensorIsInError'] as bool?,
    );

Map<String, dynamic> _$TelemetryDataResponseToJson(
        TelemetryDataResponse instance) =>
    <String, dynamic>{
      'type': _$DataTypeEnumMap[instance.type],
      'deviceIsActive': instance.deviceIsActive,
      'lockIsActive': instance.lockIsActive,
      'lightingIsActive': instance.lightingIsActive,
      'temperatureValue': instance.temperatureValue,
      'temperatureSensorIsInError': instance.temperatureSensorIsInError,
    };

const _$DataTypeEnumMap = {
  DataType.ping: 'ping',
  DataType.pong: 'pong',
  DataType.control: 'control',
  DataType.status: 'status',
};
