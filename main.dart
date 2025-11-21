import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/core/app_controller.dart';
import 'package:des/routes/app_pages.dart';
import 'package:des/routes/app_routes.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // تسجيل الـ Controller بشكل دائم
    Get.put(AppController());
    
    return GetMaterialApp(
      title: 'BookEase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Tajawal',
      ),
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      locale: Locale('ar', 'SA'),
    //  directionality: TextDirection.rtl,
    );
  }
}