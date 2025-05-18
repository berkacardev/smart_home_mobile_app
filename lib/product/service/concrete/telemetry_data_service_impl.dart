import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:smart_home_mobile_app/product/constants/global_constants.dart';
import 'package:smart_home_mobile_app/product/initializer/di.dart';
import 'package:smart_home_mobile_app/product/models/telemetry_data/telemetry_data_response.dart';
import 'package:smart_home_mobile_app/product/service/abstract/telemetry_data_service.dart';
import 'package:smart_home_mobile_app/product/service/abstract/web_socket_service.dart';

class TelemetryDataServiceImpl implements TelemetryDataService{
  final WebSocketService webSocketService = kGetIt.get<WebSocketService>();
  StreamSubscription? _webSocketDataSubscription;
  StreamSubscription? _connectionStatusSubscription;

  Future<void> startTelemetryService({VoidCallback? onConnected, VoidCallback? onConnectionLost}) async {
    const String url = GlobalConstants.WEB_SOCKET_URL;
    await webSocketService.connect(url);

    void setupConnectionCheck() {
      webSocketService.checkConnection(
        onConnected: () {
          onConnected?.call();
        },
        onConnectionLost: () async {
          await webSocketService.reconnect(url);
          setupConnectionCheck();
          onConnectionLost?.call();
        },
      );
    }
    setupConnectionCheck();
  }

  Future<void> listenTelemetryData({
    required Function(TelemetryDataResponse incomingData) incomingData,
  }) async {
    await _webSocketDataSubscription?.cancel();
    await _connectionStatusSubscription?.cancel();

    _connectionStatusSubscription = webSocketService.connectionStatusStream.listen((isConnected) {
      if (isConnected) {
        _webSocketDataSubscription = webSocketService.stream.listen((event) {
          try {
            Map<String, dynamic> jsonResponse = jsonDecode(event) as Map<String, dynamic>;
            if (jsonResponse.containsValue("status")) {
              TelemetryDataResponse telemetryDataResponse = TelemetryDataResponse.fromJson(jsonResponse);
              print(telemetryDataResponse);
              incomingData(telemetryDataResponse);
            }
          } catch (_) {}
        });
      } else {
        _webSocketDataSubscription?.cancel();
        _webSocketDataSubscription = null;
      }
    });
  }

  Future<void> sendMessage(String message) async {
    if (webSocketService.isConnected) {
      webSocketService.send(message);
    }
  }

  void dispose() {
    _webSocketDataSubscription?.cancel();
    _connectionStatusSubscription?.cancel();
  }
}
