import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences sharedPreferences;

  static Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }

  String getString(String key) {
    return sharedPreferences.getString(key) ?? "";
  }

  Future<bool> setBool(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  bool getBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  Future<bool> setDouble(String key, double value) {
    return sharedPreferences.setDouble(key, value);
  }

  double getDouble(String key) {
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  Future<bool> setInt(String key, int value) {
    return sharedPreferences.setInt(key, value);
  }

  int getInt(String key) {
    return sharedPreferences.getInt(key) ??-1;
  }

  Future<bool> setStringList(String key, List<String> value) {
    return sharedPreferences.setStringList(key, value);
  }

  List<String> getStringList(String key) {
    return sharedPreferences.getStringList(key) ??[];
  }
}
