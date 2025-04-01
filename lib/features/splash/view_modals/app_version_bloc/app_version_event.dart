part of 'app_version_bloc.dart';

sealed class AppVersionEvent extends Equatable {
  const AppVersionEvent();
}



class FetchAppVersion extends AppVersionEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}