import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveStorageService {
  late Box userLanguagePreferenceBox;
  late Box userOnBoardingStatusBox;
  late Box userAuthStatusBox;

  /// Initialize Hive & Open Boxes
  Future<void> init() async {
    try {
      await Hive.initFlutter();
      userLanguagePreferenceBox = await Hive.openBox('userLanguagePreferenceBox');
      userOnBoardingStatusBox = await Hive.openBox('userOnBoardingStatusBox');
      userAuthStatusBox = await Hive.openBox('userAuthStatusBox');
    } catch (e) {
      print("Hive initialization error: $e");
    }
  }

  /// Getters to access Hive Boxes
  Box get languageBox => userLanguagePreferenceBox;
  Box get onBoardingBox => userOnBoardingStatusBox;
  Box get authBox => userAuthStatusBox;

  /// Close Hive Boxes (Call this when app closes)
  Future<void> closeHive() async {
    await Hive.close();
  }
}
