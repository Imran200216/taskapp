import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  NetworkService._internal();

  final StreamController<bool> _connectionStreamController =
  StreamController<bool>.broadcast();
  StreamSubscription? _subscription;

  Stream<bool> get connectionStream => _connectionStreamController.stream;

  void startMonitoring() {
    _subscription?.cancel();

    _subscription = Stream.periodic(const Duration(seconds: 1))
        .asyncMap((_) => Connectivity().checkConnectivity())
        .listen((connectivityResult) {
      final isConnected =
          connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile;
      _connectionStreamController.add(isConnected);
    });
  }

  void stopMonitoring() {
    _subscription?.cancel();
    _connectionStreamController.close();
  }
}
