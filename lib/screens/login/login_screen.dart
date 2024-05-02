import 'package:daelim_univ/common/widgets/app_icon_text_button.dart';
import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:daelim_univ/provider/auth_controller.dart';
import 'package:daelim_univ/screens/login/widgets/login_text_field.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:daelim_univ/common/app_assets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //클래스로 Get 찾기
  final _controller = Get.find<AuthController>();
  late TextEditingController emailController;
  late TextEditingController pwController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    pwController = TextEditingController();
    emailController.value =
        const TextEditingValue(text: "202030330@daelim.ac.kr");
    pwController.value = const TextEditingValue(text: "abc123");
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();

    super.dispose();
  }

  void _signIn() async {
    var email = emailController.text;
    var pw = pwController.text;

    var result = await _controller.signIn(email: email, pw: pw);

    if (!result.$1) {
      //async 함수 내에서 일반 함수로 감쌈
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("로그인 실패\n${result.$2}"),
          duration: const Duration(milliseconds: 1000),
        ));
      });
      return Log.red("에러: ${result.$2}");
    }

    Log.blue(result.$2);

    context.pushReplacement('/main');
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      //resizeToAvoidBottomInset: true, //false면 자판이 올라와도 화면이 안올라감
      child: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppAssets.logoFlutter,
                  width: 250,
                ), //앱 로고
                const SizedBox(height: 100),
                LoginTextField(
                  labelText: "이메일",
                  controller: emailController,
                ), //아이디 입력
                const SizedBox(height: 50),
                LoginTextField(
                  labelText: "비밀번호",
                  controller: pwController,
                  obscureText: true,
                ), //패스워드 입력
                const SizedBox(height: 30),
                //로그인 버튼
                AppIconTextButton(
                  text: "로그인",
                  icon: Icons.login,
                  onPressed: _signIn,
                ),
                //회원가입 버튼
                TextButton(
                    onPressed: () => context.go("/signUp"),
                    child: const Text("회원가입")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
