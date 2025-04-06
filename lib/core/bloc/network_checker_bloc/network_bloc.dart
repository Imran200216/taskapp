import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskapp/core/service/network/network_service.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  late final StreamSubscription<bool> _networkSubscription;

  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  void _observe(NetworkObserve event, Emitter<NetworkState> emit) {
    // Guard to ensure we don't reinitialize
    if (_isSubscribed) return;

    _networkSubscription = NetworkService().connectionStream.listen((isConnected) {
      add(NetworkNotify(isConnected: isConnected));
    });

    _isSubscribed = true;
  }

  void _notifyStatus(NetworkNotify event, Emitter<NetworkState> emit) {
    emit(event.isConnected ? NetworkSuccess() : NetworkFailure());
  }

  bool _isSubscribed = false;

  @override
  Future<void> close() {
    _networkSubscription.cancel();
    return super.close();
  }
}
