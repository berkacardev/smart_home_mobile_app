import 'dart:ui';

abstract class WebSocketService {
  Future<void> connect(String url);
  void send(dynamic message);
  void disconnect();
  Future<void> reconnect(String url);
  void checkConnection({VoidCallback? onConnected, VoidCallback? onConnectionLost});
  Stream get stream;
  bool get isConnected;
  Stream<bool> get connectionStatusStream;
}
