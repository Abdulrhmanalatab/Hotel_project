import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/custom_button.dart';
import 'package:des/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('إنشاء حساب جديد'),
        backgroundColor: Color(0xFF1a365d),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
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
                'إنشاء حساب جديد',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1a365d),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'انضم إلينا واستمتع بتجربة فريدة',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30),

              // نموذج التسجيل
              CustomTextField(
                controller: nameController,
                label: 'الاسم الكامل',
                hintText: 'أدخل اسمك الكامل',
                icon: Icons.person,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: emailController,
                label: 'البريد الإلكتروني',
                hintText: 'أدخل بريدك الإلكتروني',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: phoneController,
                label: 'رقم الهاتف',
                hintText: 'أدخل رقم هاتفك',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: passwordController,
                label: 'كلمة المرور',
                hintText: 'أنشئ كلمة مرور قوية',
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: confirmPasswordController,
                label: 'تأكيد كلمة المرور',
                hintText: 'أعد إدخال كلمة المرور',
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 15),

              // شروط الخدمة
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'أوافق على '),
                          TextSpan(
                            text: 'شروط الخدمة',
                            style: TextStyle(
                              color: Color(0xFF1a365d),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' و '),
                          TextSpan(
                            text: 'سياسة الخصوصية',
                            style: TextStyle(
                              color: Color(0xFF1a365d),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // زر إنشاء الحساب
              CustomButton(
                text: 'إنشاء حساب',
                onPressed: () {
                  Get.offAllNamed(AppRoutes.HOME);
                },
                backgroundColor: Color(0xFFd69e2e),
                textColor: Color(0xFF1a365d),
              ),
              SizedBox(height: 20),

              // رابط تسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('لديك حساب بالفعل؟'),
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
}