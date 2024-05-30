import 'package:daelim_univ/common/helpers/locale_helper.dart';
import 'package:daelim_univ/common/helpers/storage_helper.dart';
import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:daelim_univ/localization/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SettingLocaleScreen extends StatelessWidget {
  const SettingLocaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      enableDrawer: false,
      appBar: AppBar(
        title: Text(AppString.language.tr),
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
                      onTap: () {},
                      leading: const Text(
                        "한국어",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      trailing: Checkbox(
                        value: StorageHelper.locale == LocaleHelper.korean,
                        onChanged: (value) {
                          value ??= false;

                          if (value) {
                            Get.updateLocale(LocaleHelper.korean);
                            StorageHelper.setLocale(LocaleHelper.korean);
                          }
                        },
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Text(
                        "English",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      trailing: Checkbox(
                        value: StorageHelper.locale == LocaleHelper.english,
                        onChanged: (value) {
                          value ??= false;

                          if (value) {
                            Get.updateLocale(LocaleHelper.english);
                            StorageHelper.setLocale(LocaleHelper.english);
                          }
                        },
                      ),
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
