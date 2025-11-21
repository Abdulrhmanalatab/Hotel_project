import 'package:get/get.dart';

class AppController extends GetxController {
  var isDarkMode = false.obs;
  var selectedLanguage = 'ar'.obs;
  var notificationsEnabled = true.obs;
  var currentPageIndex = 0.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
  }

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
  }

  void changePage(int index) {
    currentPageIndex.value = index;
  }
}