import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/custom_button.dart';
import 'package:des/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('استعادة كلمة المرور'),
        backgroundColor: Color(0xFF1a365d),
        foregroundColor: Colors.white,
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
                  color: Color(0xFF1a365d),
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1a365d),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'أدخل بريدك الإلكتروني لإرسال رابط الاستعادة',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
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
              ),
              SizedBox(height: 30),

              // زر الإرسال
              CustomButton(
                text: 'إرسال رابط الاستعادة',
                onPressed: () {
                  _sendResetLink();
                },
                backgroundColor: Color(0xFFd69e2e),
                textColor: Color(0xFF1a365d),
              ),
              SizedBox(height: 20),

              // رابط العودة لتسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('تذكرت كلمة المرور؟'),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'تسجيل الدخول',
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