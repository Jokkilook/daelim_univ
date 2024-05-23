import 'package:daelim_univ/common/helpers/storage_helper.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final RxBool rxIsDarkMode = StorageHelper.isDarkMode.obs;
  void changeThemeMode(bool isDarkMode) {
    rxIsDarkMode.value = isDarkMode;

    StorageHelper.setDarkMode(isDarkMode);
  }
}
