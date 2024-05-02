import 'package:daelim_univ/models/user_data.dart';
import 'package:daelim_univ/provider/auth_controller.dart';
import 'package:daelim_univ/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _listTile(BuildContext context,
      {required String path, required IconData icon, required String title}) {
    return ListTile(
      onTap: () => context.go(path),
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final UserData? userData = controller.userData;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: ListTile(
            title: Text(
              userData == null
                  ? "로그인 상태가 아닙니다."
                  : "${controller.userData?.name} (${controller.userData?.stdNumber})",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(userData?.email ?? ""),
          )),
          Expanded(
            child: ListView(
              children: [
                _listTile(context,
                    icon: Icons.home, title: "HOME", path: AppScreen.main),
                _listTile(context,
                    icon: Icons.photo_library,
                    title: "GALLERY",
                    path: AppScreen.gallery),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
