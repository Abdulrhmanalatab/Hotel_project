import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/custom_button.dart';
import 'package:des/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),
              // الشعار
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF1a365d),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.landscape,
                  color: Color(0xFFd69e2e),
                  size: 40,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1a365d),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'سجل دخولك للاستفادة من جميع المزايا',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30),

              // تسجيل الدخول الاجتماعي
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.g_mobiledata, color: Colors.red),
                      label: Text('جوجل'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.facebook, color: Colors.blue),
                      label: Text('فيسبوك'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // فاصل
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('أو'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20),

              // نموذج تسجيل الدخول
              CustomTextField(
                controller: emailController,
                label: 'البريد الإلكتروني',
                hintText: 'أدخل بريدك الإلكتروني',
                icon: Icons.email,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: passwordController,
                label: 'كلمة المرور',
                hintText: 'أدخل كلمة المرور',
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 15),

              // تذكرني ونسيت كلمة المرور
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      Text('تذكرني'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.FORGOT_PASSWORD);
                    },
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(color: Color(0xFF1a365d)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // زر تسجيل الدخول
              CustomButton(
                text: 'تسجيل الدخول',
                onPressed: () {
                  Get.offAllNamed(AppRoutes.HOME);
                },
                backgroundColor: Color(0xFFd69e2e),
                textColor: Color(0xFF1a365d),
              ),
              SizedBox(height: 20),

              // رابط إنشاء حساب
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ليس لديك حساب؟'),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.REGISTER);
                    },
                    child: Text(
                      'إنشاء حساب جديد',
                      style: TextStyle(
                        color: Color(0xFF1a365d),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}