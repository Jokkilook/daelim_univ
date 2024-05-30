import 'package:daelim_univ/common/helpers/locale_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static late SharedPreferences prefs;
  static const String isDarkModeKey = "isDarkMode";
  static const String localeKey = "locale";

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

  static final ThemeMode thememode = isDarkMode //
      ? ThemeMode.dark
      : ThemeMode.light;

  ///국제화 코드 설정
  static Future<void> setLocale(Locale locale) async {
    await prefs.setString(localeKey, locale.languageCode);
    Get.updateLocale(locale);
  }

  static Future<bool> removeLocale() {
    return prefs.remove(localeKey);
  }

  static Locale get locale {
    final languageTag = prefs.getString(localeKey);

    if (languageTag == null) {
      return Get.deviceLocale ?? LocaleHelper.english;
    }

    //if 문
    // if (languageTag == LocaleHelper.korean.languageCode) {
    //   return LocaleHelper.korean;
    // } else {
    //   return LocaleHelper.english;
    // }

    //if lamda
    // return languageTag == LocaleHelper.korean.languageCode
    //     ? LocaleHelper.korean
    //     : LocaleHelper.english;

    //switch
    // switch (languageTag) {
    //   case "ko":
    //     return LocaleHelper.korean;
    //   default:
    //     return LocaleHelper.english;
    // }

    //switch reject
    return switch (languageTag) {
      "ko" => LocaleHelper.korean,
      _ => LocaleHelper.english
    };
  }
}
