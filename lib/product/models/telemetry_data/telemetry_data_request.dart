import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_home_mobile_app/product/enums/data_type.dart';

part 'telemetry_data_request.g.dart';

@immutable
@JsonSerializable()
class TelemetryDataRequest extends Equatable {
  final DataType? type;
  final bool? deviceIsActive;
  final bool? lockIsActive;
  final bool? lightingIsActive;

  const TelemetryDataRequest({this.type, this.deviceIsActive, this.lockIsActive, this.lightingIsActive});

  @override
  List<Object?> get props => [type, deviceIsActive, lockIsActive, lightingIsActive];

  TelemetryDataRequest copyWith({
    DataType? type,
    bool? deviceIsActive,
    bool? lockIsActive,
    bool? lightingIsActive,
  }) {
    return TelemetryDataRequest(
      type: type ?? this.type,
      deviceIsActive: deviceIsActive ?? this.deviceIsActive,
      lockIsActive: lockIsActive ?? this.lockIsActive,
      lightingIsActive: lightingIsActive ?? this.lightingIsActive,
    );
  }

  Map<String, dynamic> toJson() {
    return _$TelemetryDataRequestToJson(this);
  }
}
