import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_mobile_app/product/enums/data_type.dart';
import 'package:smart_home_mobile_app/product/enums/model_enums/basic_model_status.dart';
import 'package:smart_home_mobile_app/product/models/telemetry_data/telemetry_data_request.dart';
import 'package:smart_home_mobile_app/product/models/telemetry_data/telemetry_data_response.dart';
import 'package:smart_home_mobile_app/product/service/concrete/telemetry_data_service_impl.dart';

final kTelemetryDataProvider = StateNotifierProvider<TelemetryDataNotifier, TelemetryDataState>((ref) => TelemetryDataNotifier());

class TelemetryDataNotifier extends StateNotifier<TelemetryDataState> {
  TelemetryDataNotifier()
      : super(TelemetryDataState(
          basicModelStatus: BasicModelStatus.INITIAL,
          deviceConnectionStatus: false,
          devicePowerStatus: false,
          smartLightingStatus: false,
          smartLockStatus: false,
          temperatureValue: 0,
          temperatureSensorErrorStatus: false,
          isInConnecting: false,
        ));

  TelemetryDataServiceImpl serviceImpl = TelemetryDataServiceImpl();

  Future<void> listenConnectionState() async {
    serviceImpl.startTelemetryService(
      onConnected: () {
        if (!state.deviceConnectionStatus) {
          state = state.copyWith(deviceConnectionStatus: true);
        }
      },
      onConnectionLost: () {
        if (state.deviceConnectionStatus) {
          state = state.copyWith(deviceConnectionStatus: false);
        }
      },
    );
  }

  Future<void> listenTelemetryState() async {
    await serviceImpl.listenTelemetryData(incomingData: (incomingData) {
      TelemetryDataResponse response = incomingData;
      state = state.copyWith(
          smartLightingStatus: response.lightingIsActive,
          smartLockStatus: response.lockIsActive,
          devicePowerStatus: response.deviceIsActive,
          temperatureValue: response.temperatureValue);
    });
  }

  Future<void> sendTelemetryData({bool? devicePowerStatus, bool? smartLightingStatus, bool? smartLockStatus}) async {
    bool devicePowerState = devicePowerStatus ?? state.devicePowerStatus;
    bool smartLightingState = smartLightingStatus ?? state.smartLightingStatus;
    bool smartLockState = smartLockStatus ?? state.smartLockStatus;
    TelemetryDataRequest request =
        TelemetryDataRequest(type: DataType.control, deviceIsActive: devicePowerState, lightingIsActive: smartLightingState, lockIsActive: smartLockState);
    await serviceImpl.sendMessage(jsonEncode(request.toJson()));
  }
}

class TelemetryDataState extends Equatable {
  final BasicModelStatus basicModelStatus;
  final Exception? exception;
  final bool deviceConnectionStatus;
  final bool devicePowerStatus;
  final bool smartLightingStatus;
  final bool smartLockStatus;
  final double temperatureValue;
  final bool temperatureSensorErrorStatus;
  final bool isInConnecting;

  const TelemetryDataState(
      {required this.basicModelStatus,
      this.exception,
      required this.deviceConnectionStatus,
      required this.devicePowerStatus,
      required this.smartLightingStatus,
      required this.smartLockStatus,
      required this.temperatureValue,
      required this.temperatureSensorErrorStatus,
      required this.isInConnecting});

  @override
  List<Object?> get props => [
        basicModelStatus,
        exception,
        deviceConnectionStatus,
        devicePowerStatus,
        smartLightingStatus,
        smartLockStatus,
        temperatureValue,
        temperatureSensorErrorStatus
      ];

  TelemetryDataState copyWith({
    BasicModelStatus? basicModelStatus,
    Exception? exception,
    bool? deviceConnectionStatus,
    bool? devicePowerStatus,
    bool? smartLightingStatus,
    bool? smartLockStatus,
    double? temperatureValue,
    bool? temperatureSensorErrorStatus,
    bool? isInConnecting,
  }) {
    return TelemetryDataState(
      basicModelStatus: basicModelStatus ?? this.basicModelStatus,
      exception: exception ?? this.exception,
      deviceConnectionStatus: deviceConnectionStatus ?? this.deviceConnectionStatus,
      devicePowerStatus: devicePowerStatus ?? this.devicePowerStatus,
      smartLightingStatus: smartLightingStatus ?? this.smartLightingStatus,
      smartLockStatus: smartLockStatus ?? this.smartLockStatus,
      temperatureValue: temperatureValue ?? this.temperatureValue,
      temperatureSensorErrorStatus: temperatureSensorErrorStatus ?? this.temperatureSensorErrorStatus,
      isInConnecting: isInConnecting ?? this.isInConnecting,
    );
  }
}
