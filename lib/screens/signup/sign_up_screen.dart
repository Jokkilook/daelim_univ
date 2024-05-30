import 'package:daelim_univ/common/widgets/app_icon_text_button.dart';
import 'package:daelim_univ/localization/app_string.dart';
import 'package:daelim_univ/router/app_router.dart';
import 'package:daelim_univ/screens/login/widgets/login_text_field.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pwKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pwConfirmKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _stnKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _pwController;
  late TextEditingController _pwConfirmController;
  late TextEditingController _nameController;
  late TextEditingController _stnController;
  bool isLoading = false;
  //레코드 방식 (간단한 것들은 데이터 클래스 안만들고 이런식으로 만든다.)
  List<(GlobalKey<FormState>, TextEditingController, String)> get _buttons => [
        (_emailKey, _emailController, "이메일"),
        (_pwKey, _pwController, "비밀번호"),
        (_pwConfirmKey, _pwConfirmController, "비밀번호 확인"),
        (_nameKey, _nameController, "이름"),
        (_stnKey, _stnController, "학번")
      ];

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _pwConfirmController = TextEditingController();
    _nameController = TextEditingController();
    _stnController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _pwConfirmController.dispose();
    _nameController.dispose();
    _stnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pushReplacement(AppScreen.login);
          },
        ),
        title: Text(AppString.signUp.tr),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => 10.heightBox,
                itemCount: _buttons.length,
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  return LoginTextField(
                    formKey: _buttons[index].$1,
                    controller: _buttons[index].$2,
                    labelText: _buttons[index].$3,
                    obscureText: _buttons[index].$3.contains("비밀번호"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "값을 입력해주세요.";
                      }

                      if (_buttons[index].$3 == "이름") {
                        if (value.length != 3) {
                          return "3글자 이름";
                        }
                      }

                      if (_buttons[index].$3 == "비밀번호 확인") {
                        if (value != _pwController.text) {
                          return "비밀번호가 일치하지 않습니다.";
                        }
                      }

                      return null;
                    },
                  );
                },
              ),
            ),
            AppIconTextButton(
              text: AppString.signUp,
              icon: Icons.person,
              onPressed: () async {
                var emailCheck = _emailKey.currentState?.validate() ?? false;
                var pwCheck = _pwKey.currentState?.validate() ?? false;
                var pwConfirmCheck =
                    _pwConfirmKey.currentState?.validate() ?? false;
                var nameCheck = _nameKey.currentState?.validate() ?? false;
                var stnCheck = _stnKey.currentState?.validate() ?? false;

                if (!(emailCheck &&
                    pwCheck &&
                    pwConfirmCheck &&
                    nameCheck &&
                    stnCheck)) {
                  return;
                }

                final email = _emailController.text;
                final pw = _pwController.text;
                final pwConfirm = _pwConfirmController.text;
                final name = _nameController.text;
                final stn = _stnController.text;

                Log.green("$email, $pw, $pwConfirm, $name, $stn");

                //플러터에서 {}은 맵이니까 jsonEncode를 해서 JSON 형식으로 변환해줘야 한다.
                var response = await http.post(
                    Uri.parse(
                        "http://121.140.73.79:60080/functions/v1/auth/signup"),
                    body: jsonEncode({
                      "email": email,
                      "password": pw,
                      "name": name,
                      "student_number": stn
                    }));

                var status = response.statusCode;

                Log.green(status);

                if (status != 200) {
                  return debugPrint(
                      "에러코드:${response.statusCode.toString()}, ${response.body}");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
