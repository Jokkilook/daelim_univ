import 'dart:convert';

import 'package:daelim_univ/models/user_data.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  UserData? _userData;
  UserData? get userData => _userData;

  //로그인
  Future<(bool success, String? error)> signIn(
      {required String email, required String pw}) async {
    var response = await http
        .post(Uri.parse("http://121.140.73.79:60080/functions/v1/auth/login"),
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
    var body = response.body;

    if (status != 200) {
      return (false, body);
    }
    var bodyJson = jsonDecode(utf8.decode(response.bodyBytes));

    Log.green(bodyJson);

    _userData = UserData.fromMap(bodyJson);

    Log.green(userData);

    return (true, null);
  }
}
