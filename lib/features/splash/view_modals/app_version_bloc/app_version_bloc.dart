import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_version_event.dart';

part 'app_version_state.dart';

class AppVersionBloc extends Bloc<AppVersionEvent, AppVersionState> {
  AppVersionBloc() : super(AppVersionInitial()) {
    on<FetchAppVersion>((event, emit) async {
      try {
        print("Fetching app version..."); // Debug print

        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String version = packageInfo.version;

        print("App Version Fetched: $version"); // Debug print

        emit(AppVersionLoaded(version));
      } catch (e) {
        print("Error fetching app version: $e"); // Debug print
        emit(AppVersionError());
      }
    });
  }
}
