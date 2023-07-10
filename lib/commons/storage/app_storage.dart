import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static final AppStorage _instance = AppStorage._internal();
  static SharedPreferences? _preferences;

  factory AppStorage() {
    return _instance;
  }

  AppStorage._internal();

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences? get instance {
    return _preferences;
  }
}
