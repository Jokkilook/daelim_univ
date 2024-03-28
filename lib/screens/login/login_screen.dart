import 'package:daelim_univ/common/widgets/app_icon_text_button.dart';
import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:daelim_univ/screens/login/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:daelim_univ/common/app_assets.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController pwController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    pwController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      //resizeToAvoidBottomInset: true, //fale면 자판이 올라와도 화면이 안올라감
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
                AppIconTextButton(
                  text: "로그인",
                  icon: Icons.login,
                  onPressed: () {
                    var email = emailController.text;
                    var pw = pwController.text;
                    //if (email != "aaa" && pw != "1234") return;

                    context.go('/main');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
