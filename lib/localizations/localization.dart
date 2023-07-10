import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';

class Localization {
  static Map<String, dynamic>? _localizedStrings;
  static Locale? _locale;

  static Future<void> loadJson(Locale locale) async {
    String jsonString =
        await rootBundle.loadString('assets/locales/${locale.languageCode}.json');
    _localizedStrings = json.decode(jsonString);
    _locale = locale;
  }

  static String translate(String key) {
    return _localizedStrings?[key] ?? '';
  }

  static Locale? get locale => _locale;
}
