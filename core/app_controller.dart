import 'package:get/get.dart';
import 'package:flutter/material.dart';

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
    // تغيير اتجاه النص بناءً على اللغة
    if (language == 'ar') {
      Get.updateLocale(Locale('ar', 'SA'));
    } else {
      Get.updateLocale(Locale('en', 'US'));
    }
  }

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
  }

  void changePage(int index) {
    currentPageIndex.value = index;
  }

  // دالة للحصول على اتجاه النص الحالي
  bool get isRTL => selectedLanguage.value == 'ar';
}