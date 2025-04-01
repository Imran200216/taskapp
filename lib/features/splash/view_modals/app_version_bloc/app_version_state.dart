part of 'app_version_bloc.dart';

sealed class AppVersionState extends Equatable {
  const AppVersionState();
}

final class AppVersionInitial extends AppVersionState {
  @override
  List<Object> get props => [];
}

class AppVersionLoaded extends AppVersionState {
  final String version;

  const AppVersionLoaded(this.version);

  @override
  List<Object> get props => [version];
}

class AppVersionError extends AppVersionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}