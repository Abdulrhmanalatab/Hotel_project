import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'استعادة كلمة المرور',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: theme.iconTheme.size,
        ),
      ),
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
                  Icons.lock,
                  color: Color(0xFFd69e2e),
                  size: 40,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'استعادة كلمة المرور',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'أدخل بريدك الإلكتروني لإرسال رابط الاستعادة',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              // نموذج الاستعادة
              CustomTextField(
                controller: emailController,
                label: 'البريد الإلكتروني',
                hintText: 'أدخل بريدك الإلكتروني',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                iconSize: theme.iconTheme.size,
                theme: theme,
              ),
              SizedBox(height: 30),

              // زر الإرسال
              CustomButton(
                text: 'إرسال رابط الاستعادة',
                onPressed: () {
                  _sendResetLink();
                },
                backgroundColor: Color(0xFFd69e2e),
                textColor: theme.primaryColor,
                iconSize: theme.iconTheme.size,
              ),
              SizedBox(height: 20),

              // رابط العودة لتسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تذكرت كلمة المرور؟',
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'تسجيل الدخول',
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

  void _sendResetLink() {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى إدخال البريد الإلكتروني',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('تم الإرسال'),
          ],
        ),
        content: Text('تم إرسال رابط استعادة كلمة المرور إلى بريدك الإلكتروني.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text('موافق'),
          ),
        ],
      ),
    );
  }
}