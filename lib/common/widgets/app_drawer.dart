import 'package:daelim_univ/router/app_router.dart';
import 'package:flutter/material.dart';
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
    return Drawer(
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
    );
  }
}
