import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  NetworkService._internal();

  final StreamController<bool> _connectionStreamController =
      StreamController<bool>.broadcast();

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  Stream<bool> get connectionStream => _connectionStreamController.stream;

  void startMonitoring() {
    _subscription?.cancel();

    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      // Handle the list of results
      final hasConnection =
          results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);
      _connectionStreamController.add(hasConnection);
    });
  }

  void stopMonitoring() {
    _subscription?.cancel();
    _connectionStreamController.close();
  }
}
