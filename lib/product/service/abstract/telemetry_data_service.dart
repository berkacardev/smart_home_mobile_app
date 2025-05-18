import 'dart:ui';

import 'package:smart_home_mobile_app/product/models/telemetry_data/telemetry_data_response.dart';

abstract class TelemetryDataService {
  Future<void> startTelemetryService({
    VoidCallback? onConnected,
    VoidCallback? onConnectionLost,
  });
  Future<void> listenTelemetryData({
    required Function(TelemetryDataResponse incomingData) incomingData,
  });
  Future<void> sendMessage(String message);
  void dispose();
}
