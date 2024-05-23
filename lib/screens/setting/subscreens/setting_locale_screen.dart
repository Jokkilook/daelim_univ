import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class SettingLocaleScreen extends StatelessWidget {
  const SettingLocaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        enableDrawer: false,
        appBar: AppBar(
          title: const Text("언어"),
        ),
        child: const Placeholder());
  }
}
