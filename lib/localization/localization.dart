import 'package:daelim_univ/localization/app_string.dart';
import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          AppString.email: "email",
          AppString.password: "password",
          AppString.login: "login",
          AppString.signUp: "signUp",
          AppString.home: "HOME",
          AppString.lifecycle: "LIFECYCLE",
          AppString.gallery: "GALLERY",
          AppString.appSetting: "APP SETTING",
          AppString.language: "Language",
        },
        'ko_KR': {
          AppString.email: "이메일",
          AppString.password: "패스워드",
          AppString.login: "로그인",
          AppString.signUp: "회원가입",
          AppString.home: "홈",
          AppString.lifecycle: "라이프사이클",
          AppString.gallery: "갤러리",
          AppString.appSetting: "앱 설정",
          AppString.language: "언어",
        },
      };
}
