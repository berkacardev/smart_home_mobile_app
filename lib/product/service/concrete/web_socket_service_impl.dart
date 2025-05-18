import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:smart_home_mobile_app/product/models/ping_data/ping_data_request.dart';
import 'package:smart_home_mobile_app/product/models/ping_data/ping_data_response.dart';
import 'package:smart_home_mobile_app/product/service/abstract/web_socket_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketServiceImpl implements WebSocketService {
  String? _connectionUrl;

  static final WebSocketServiceImpl _instance = WebSocketServiceImpl._internal();

  factory WebSocketServiceImpl() => _instance;

  WebSocketServiceImpl._internal();

  late WebSocketChannel _channel;

  bool _isConnected = false;

  final StreamController<bool> _connectionStatusController = StreamController<bool>.broadcast();

  @override
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  Stream _broadcastStream = const Stream.empty();

  @override
  Stream get stream => _broadcastStream;

  @override
  bool get isConnected => _isConnected;

  void _updateConnectionStatus(bool status) {
    if (_isConnected != status) {
      _isConnected = status;
      _connectionStatusController.add(status);
    }
  }

  @override
  Future<void> connect(String url) async {
    _connectionUrl = url;
    if (_isConnected) return;
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _broadcastStream = _channel.stream.asBroadcastStream();
    checkConnection(
      onConnectionLost: () => _updateConnectionStatus(false),
      onConnected: () => _updateConnectionStatus(true),
    );
  }

  @override
  void send(dynamic message) {
    if (message is Map<String, dynamic>) {
      _channel.sink.add(jsonEncode(message));
    } else {
      _channel.sink.add(message.toString());
    }
  }

  BigInt _lastPongTime = BigInt.from(0);
  int _loopNumber = 0;
  Timer? _connectionCheckTimer;

  @override
  void checkConnection({VoidCallback? onConnected, VoidCallback? onConnectionLost}) {
    if (_connectionUrl == null) {
      _updateConnectionStatus(false);
      return;
    }
    int checkTimeAsSecond = 10;
    stream.listen((event) {
      try {
        Map<String, dynamic> jsonResponse = jsonDecode(event) as Map<String, dynamic>;

        if (jsonResponse.containsValue("pong")) {
          PingDataResponse pingDataResponse = PingDataResponse.fromJson(jsonResponse);
          _lastPongTime = pingDataResponse.timestamp ?? BigInt.from(-1);
          _updateConnectionStatus(true);
          onConnected?.call();
        } else if (jsonResponse.containsValue("status")) {
          _updateConnectionStatus(true);
          onConnected?.call();
        }
      } catch (_) {}
    });

    _loopNumber = 0;
    _connectionCheckTimer?.cancel();
    _connectionCheckTimer = Timer.periodic(Duration(seconds: 8), (timer) {
      PingDataRequest pingDataRequest = PingDataRequest.instance();
      send(pingDataRequest.toJson());

      final now = BigInt.from(DateTime.now().millisecondsSinceEpoch);
      final diff = now - _lastPongTime;

      if (diff >= BigInt.from(checkTimeAsSecond * 1000)) {
        if (_loopNumber > 6) {
          _updateConnectionStatus(false);
          onConnectionLost?.call();
        }
      } else {
        _updateConnectionStatus(true);
        onConnected?.call();
      }
      _loopNumber++;
    });
  }

  @override
  Future<void> disconnect() async {
    if (_isConnected) {
      await _channel.sink.close();
    }
    _connectionCheckTimer?.cancel();
    _broadcastStream = const Stream.empty();
    _updateConnectionStatus(false);
  }

  @override
  Future<void> reconnect(String url) async {
    await disconnect();
    await connect(url);
  }

  void dispose() {
    _connectionCheckTimer?.cancel();
    _connectionStatusController.close();
  }
}
