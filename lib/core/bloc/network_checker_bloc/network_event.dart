part of 'network_bloc.dart';

sealed class NetworkEvent extends Equatable {
  const NetworkEvent();
}

class NetworkObserve extends NetworkEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NetworkNotify extends NetworkEvent {
  final bool isConnected;

  const NetworkNotify({this.isConnected = false});

  @override
  // TODO: implement props
  List<Object?> get props => [isConnected];
}
