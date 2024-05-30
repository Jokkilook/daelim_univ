import 'package:daelim_univ/common/helpers/storage_helper.dart';
import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:daelim_univ/localization/app_string.dart';
import 'package:daelim_univ/provider/settring_controller.dart';
import 'package:daelim_univ/router/app_router.dart';
import 'package:day_night_themed_switch/day_night_themed_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  //setState 가 없다는 건 화면을 변경하지 않는다는 뜻.

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    final RxBool rxIsDarkMode = (StorageHelper.isDarkMode ?? false).obs;

    return AppScaffold(
      enableDrawer: false,
      appBar: AppBar(
        title: Text(AppString.appSetting.tr),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Column(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      onTap: () => context.pushNamed(AppScreen.settingTheme),
                      leading: const Icon(Icons.brightness_6),
                      title: const Text("다크 모드"),
                      trailing: Obx(
                        //Switch.adaptive : 구동되는 OS의 기본 디자인을 사용하는 스위치
                        () => SizedBox(
                          width: 80,
                          height: 40,
                          child: DayNightSwitch(
                            value: controller.rxIsDarkMode.value,
                            onChanged: (value) =>
                                controller.changeThemeMode(value),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => context.pushNamed(AppScreen.settingLocale),
                      leading: const Icon(Icons.language),
                      title: const Text("언어"),
                    )
                  ],
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
