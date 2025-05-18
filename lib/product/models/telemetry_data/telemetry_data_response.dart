import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_home_mobile_app/product/enums/data_type.dart';

part 'telemetry_data_response.g.dart';

@immutable
@JsonSerializable()
class TelemetryDataResponse extends Equatable {
  final DataType? type;
  final bool? deviceIsActive;
  final bool? lockIsActive;
  final bool? lightingIsActive;
  final double? temperatureValue;
  final bool? temperatureSensorIsInError;

  const TelemetryDataResponse({
    this.type,
    this.deviceIsActive,
    this.lockIsActive,
    this.lightingIsActive,
    this.temperatureValue,
    this.temperatureSensorIsInError,
  });

  @override
  List<Object?> get props => [type,deviceIsActive, lockIsActive, lightingIsActive, temperatureValue, temperatureSensorIsInError];

  TelemetryDataResponse copyWith({
    DataType? dataType,
    bool? deviceIsActive,
    bool? lockIsActive,
    bool? lightingIsActive,
    double? temperatureValue,
    bool? temperatureSensorIsInError,
  }) {
    return TelemetryDataResponse(
      type: dataType ?? this.type,
      deviceIsActive: deviceIsActive ?? this.deviceIsActive,
      lockIsActive: lockIsActive ?? this.lockIsActive,
      lightingIsActive: lightingIsActive ?? this.lightingIsActive,
      temperatureValue: temperatureValue ?? this.temperatureValue,
      temperatureSensorIsInError: temperatureSensorIsInError ?? this.temperatureSensorIsInError,
    );
  }
  factory TelemetryDataResponse.fromJson(Map<String, dynamic> json) {
    return _$TelemetryDataResponseFromJson(json);
  }
}
