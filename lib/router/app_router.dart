import 'package:daelim_univ/screens/gallery/gallery_screen.dart';
import 'package:daelim_univ/screens/login/login_screen.dart';
import 'package:daelim_univ/screens/main/main_screen.dart';
import 'package:daelim_univ/screens/signup/sign_up_screen.dart';
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
      path: AppScreen.main,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppScreen.gallery,
      builder: (context, state) => const GalleryScreen(),
    ),
    GoRoute(
      path: AppScreen.signUp,
      builder: (context, state) => const SignUpScreen(),
    )
  ],
);

class AppScreen {
  static String login = '/login';
  static String main = '/main';
  static String gallery = '/gallery';
  static String signUp = '/signUp';
}
