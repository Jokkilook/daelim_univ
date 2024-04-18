import 'dart:convert';

import 'package:daelim_univ/common/widgets/app_icon_text_button.dart';
import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:daelim_univ/screens/login/widgets/login_text_field.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:daelim_univ/common/app_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

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
                  onPressed: () async {
                    var email = emailController.text;
                    var pw = pwController.text;

                    //then 을 쓰면 에러가 나고 난 뒤에도 처리를 해 줘야함
                    var response = await http
                        .post(
                            Uri.parse(
                                "http://121.140.73.79:60080/functions/v1/auth/login"),
                            body: jsonEncode({
                              "email": email,
                              "password": pw,
                            }))
                        .timeout(
                          const Duration(seconds: 5),
                        )
                        .catchError((e, stackTrace) {
                      Log.red(stackTrace);
                      return http.Response("$e", 401);
                    });

                    var status = response.statusCode;

                    if (status != 200) {
                      //async 함수 내에서 일반 함수로 감쌈
                      Future.delayed(Duration.zero, () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("로그인 실패"),
                          duration: Duration(milliseconds: 1000),
                        ));
                      });
                      return Log.red(
                          "에러코드:${response.statusCode.toString()}, ${response.body}");
                    }

                    Log.blue(response.body);

                    context.pushReplacement('/main');
                  },
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
