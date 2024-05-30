import 'package:daelim_univ/localization/app_string.dart';
import 'package:daelim_univ/models/user_data.dart';
import 'package:daelim_univ/provider/auth_controller.dart';
import 'package:daelim_univ/router/app_router.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  List<dynamic> get _tilesData => [
        {
          "icon": Icons.home,
          "title": AppString.home.tr,
          "path": AppScreen.main,
        },
        {
          "icon": Icons.photo_library,
          "title": AppString.gallery.tr,
          "path": AppScreen.gallery,
        },
        {
          "icon": Icons.cyclone,
          "title": AppString.lifecycle.tr,
          "path": AppScreen.lifecycle,
        }
      ];

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
              children: _tilesData.mapIndexed((index, e) {
                return _listTile(context,
                        path: e["path"], icon: e["icon"], title: e["title"])
                    .animate()
                    .slideX(delay: (index * 300).toMillisecond);
              }).toList(),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            onTap: () => context.push(AppScreen.setting),
            title: Text(AppString.appSetting.tr),
            trailing: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
