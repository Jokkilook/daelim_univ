import 'package:flutter/material.dart';
import 'package:daelim_univ/common/app_assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController? emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController?.dispose();
    emailController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppAssets.logoFlutter,
                  width: 250,
                ), //앱 로고
                const SizedBox(height: 100),
                TextField(
                  controller: emailController,
                  style: const TextStyle(fontSize: 30),
                  decoration: const InputDecoration(
                    labelText: "이메일",
                    border: OutlineInputBorder(),
                  ),
                ), //아이디 입력
                const SizedBox(height: 50),
                const TextField(
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                      labelText: "비밀번호",
                      border: OutlineInputBorder(),
                    )), //패스워드 입력
                const SizedBox(height: 50),
                MaterialButton(
                  onPressed: () {
                    var email = emailController?.text;
                    debugPrint("email: $email");
                  },
                  color: Colors.blue[700],
                  child: const Text(
                    "로그인",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
