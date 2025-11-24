import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
                  color: theme.primaryColor,
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
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'سجل دخولك للاستفادة من جميع المزايا',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              SizedBox(height: 30),

              // تسجيل الدخول الاجتماعي
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.g_mobiledata, 
                        color: Colors.red,
                        size: theme.iconTheme.size,
                      ),
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
                      icon: Icon(
                        Icons.facebook, 
                        color: Colors.blue,
                        size: theme.iconTheme.size,
                      ),
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
                    child: Text(
                      'أو',
                      style: theme.textTheme.bodyMedium,
                    ),
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
                iconSize: theme.iconTheme.size,
                theme: theme,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: passwordController,
                label: 'كلمة المرور',
                hintText: 'أدخل كلمة المرور',
                icon: Icons.lock,
                isPassword: true,
                iconSize: theme.iconTheme.size,
                theme: theme,
              ),
              SizedBox(height: 15),

              // تذكرني ونسيت كلمة المرور
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      Text(
                        'تذكرني',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.FORGOT_PASSWORD);
                    },
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColor,
                      ),
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
                textColor: theme.primaryColor,
                iconSize: theme.iconTheme.size,
              ),
              SizedBox(height: 20),

              // رابط إنشاء حساب
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ليس لديك حساب؟',
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.REGISTER);
                    },
                    child: Text(
                      'إنشاء حساب جديد',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColor,
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