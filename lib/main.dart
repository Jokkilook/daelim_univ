import 'package:daelim_univ/common/helpers/locale_helper.dart';
import 'package:daelim_univ/common/helpers/storage_helper.dart';
import 'package:daelim_univ/localization/localization.dart';
import 'package:daelim_univ/provider/auth_controller.dart';
import 'package:daelim_univ/router/app_router.dart';
import 'package:daelim_univ/screens/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  Get.put(AuthController());
  await StorageHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      //Get 쓰면 아래 3개로 라우터 설정
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      //Get 쓰기 전에 쓰던 라우터  routerConfig: router,
      themeMode: StorageHelper.thememode,
      // debugBrightnessOverride == Brightness.dark
      //     ? ThemeMode.dark
      //     : ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      translations: Localization(),
      locale: StorageHelper.locale,
      fallbackLocale: LocaleHelper.english,
    );
  }
}
