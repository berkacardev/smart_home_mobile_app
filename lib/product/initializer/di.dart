import 'package:get_it/get_it.dart';
import 'package:smart_home_mobile_app/product/service/abstract/telemetry_data_service.dart';
import 'package:smart_home_mobile_app/product/service/abstract/web_socket_service.dart';
import 'package:smart_home_mobile_app/product/service/concrete/telemetry_data_service_impl.dart';
import 'package:smart_home_mobile_app/product/service/concrete/web_socket_service_impl.dart';

final kGetIt = GetIt.instance;

abstract class DependencyInjection {
  static void initializeDependencies() {
    kGetIt.registerSingleton<WebSocketService>(WebSocketServiceImpl(),signalsReady: true);
    kGetIt.registerSingleton<TelemetryDataService>(TelemetryDataServiceImpl(),signalsReady: true);
  }
}
