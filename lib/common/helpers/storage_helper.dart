import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static late SharedPreferences prefs;
  static const String isDarkModeKey = "isDarkMode";

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future setDarkMode(bool isDarkMode) async {
    await prefs.setBool(isDarkModeKey, isDarkMode);
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  //static final bool? isDarkMode = prefs.getBool(isDarkModeKey);

  static bool get isDarkMode {
    bool? isDarkMode = prefs.getBool(isDarkModeKey);

    isDarkMode ??= isDarkMode = ThemeMode.system == ThemeMode.dark;

    return isDarkMode;
  }

  static ThemeMode thememode = isDarkMode == null
      ? ThemeMode.system
      : isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light;
}
