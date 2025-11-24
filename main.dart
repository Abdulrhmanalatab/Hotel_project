import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './routes/app_pages.dart';
import './routes/app_routes.dart';
import './core/app_controller.dart';


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
        primaryColor: Color(0xFF1a365d),
        scaffoldBackgroundColor: Colors.grey[50],
        cardColor: Colors.white,
        iconTheme: IconThemeData(size: 24.0),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16.0),
          bodySmall: TextStyle(fontSize: 14.0),
        ),
        fontFamily: 'Tajawal',
      ),
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      locale: Locale('ar', 'SA'),
     // directionality: TextDirection.rtl,
    );
  }
}