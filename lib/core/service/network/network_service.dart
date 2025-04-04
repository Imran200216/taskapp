import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:taskapp/core/bloc/network_checker_bloc/network_bloc.dart';

class NetworkService {
  static StreamSubscription? _subscription;

  static void observeNetwork(NetworkBloc networkBloc) {
    // Cancel previous subscription if any
    _subscription?.cancel();

    _subscription = Connectivity().onConnectivityChanged.listen(
          (List<ConnectivityResult> results) {
        // Check if any connection is available
        bool isConnected = results.any(
              (result) =>
          result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile ||
              result == ConnectivityResult.ethernet,
        );

        // Add event only if the bloc is still open
        if (!networkBloc.isClosed) {
          networkBloc.add(NetworkNotify(isConnected: isConnected));
        }
      },
    );
  }

  static void dispose() {
    _subscription?.cancel();
  }
}
