import 'package:daelim_univ/screens/gallery/gallery_detail_screen.dart';
import 'package:daelim_univ/screens/gallery/gallery_screen.dart';
import 'package:daelim_univ/screens/lifecycle/lifecycle_screen.dart';
import 'package:daelim_univ/screens/login/login_screen.dart';
import 'package:daelim_univ/screens/main/main_screen.dart';
import 'package:daelim_univ/screens/setting/setting_screen.dart';
import 'package:daelim_univ/screens/setting/subscreens/setting_locale_screen.dart';
import 'package:daelim_univ/screens/setting/subscreens/setting_theme_screen.dart';
import 'package:daelim_univ/screens/signup/sign_up_screen.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: AppScreen.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppScreen.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppScreen.main,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppScreen.lifecycle,
      builder: (context, state) => const LifecycleScreen(),
    ),
    GoRoute(
      path: AppScreen.gallery,
      builder: (context, state) => const GalleryScreen(),
      routes: [
        //갤러리 상세페이지
        GoRoute(
          name: AppScreen.galleryDetail,
          path: "${AppScreen.galleryDetail}/id=:id",
          builder: (context, state) {
            final id = state.pathParameters["id"] ?? "-1";
            return GalleryDetailScreen(id: id.toInt());
          },
        ),
      ],
    ),
    GoRoute(
        path: AppScreen.setting,
        builder: (context, state) => const SettingScreen(),
        routes: [
          //세팅 상세페이지
          GoRoute(
            name: AppScreen.settingTheme,
            path: AppScreen.settingTheme,
            builder: (context, state) => const SettingThemeScreen(),
          ),
          GoRoute(
            name: AppScreen.settingLocale,
            path: AppScreen.settingLocale,
            builder: (context, state) => const SettingLocaleScreen(),
          )
        ])
  ],
);

class AppScreen {
  static String login = '/login';
  static String signUp = '/signUp';
  static String main = '/main';
  static String lifecycle = '/lifecycle';
  static String gallery = '/gallery';
  static String galleryDetail = 'detail';
  static String setting = '/setting';
  static String settingTheme = 'theme';
  static String settingLocale = 'locale';
}
