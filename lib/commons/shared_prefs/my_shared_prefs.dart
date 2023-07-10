import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPreferences;

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  String getString(String key) {
    return _sharedPreferences.getString(key) ?? "";
  }

  Future<bool> setBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  bool getBool(String key) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  Future<bool> setDouble(String key, double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  double getDouble(String key) {
    return _sharedPreferences.getDouble(key) ?? 0.0;
  }

  Future<bool> setInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  int getInt(String key) {
    return _sharedPreferences.getInt(key) ??-1;
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  List<String> getStringList(String key) {
    return _sharedPreferences.getStringList(key) ??[];
  }
}
