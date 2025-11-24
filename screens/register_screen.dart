import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            isRTL ? Icons.arrow_forward : Icons.arrow_back,
            color: theme.primaryColor,
            size: theme.iconTheme.size,
          ),
          onPressed: () {
            Get.back();
          },
        ),
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
                'إنشاء حساب جديد',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'انضم إلى مجتمعنا واستمتع بتجربة فريدة',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              SizedBox(height: 30),

              // نموذج التسجيل
              CustomTextField(
                controller: fullNameController,
                label: 'الاسم الكامل',
                hintText: 'أدخل اسمك الكامل',
                icon: Icons.person,
                iconSize: theme.iconTheme.size,
                theme: theme,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: emailController,
                label: 'البريد الإلكتروني',
                hintText: 'أدخل بريدك الإلكتروني',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                iconSize: theme.iconTheme.size,
                theme: theme,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: phoneController,
                label: 'رقم الهاتف',
                hintText: 'أدخل رقم هاتفك',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                iconSize: theme.iconTheme.size,
                theme: theme,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: passwordController,
                label: 'كلمة المرور',
                hintText: 'أنشئ كلمة مرور قوية',
                icon: Icons.lock,
                isPassword: true,
                iconSize: theme.iconTheme.size,
                theme: theme,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: confirmPasswordController,
                label: 'تأكيد كلمة المرور',
                hintText: 'أعد إدخال كلمة المرور',
                icon: Icons.lock_outline,
                isPassword: true,
                iconSize: theme.iconTheme.size,
                theme: theme,
              ),
              SizedBox(height: 20),

              // شروط الخدمة
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'أوافق على ',
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: 'شروط الخدمة',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' و ',
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: 'سياسة الخصوصية',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              // زر إنشاء الحساب
              CustomButton(
                text: 'إنشاء حساب',
                onPressed: () {
                  Get.offAllNamed(AppRoutes.HOME);
                },
                backgroundColor: Color(0xFFd69e2e),
                textColor: theme.primaryColor,
                iconSize: theme.iconTheme.size,
              ),
              SizedBox(height: 20),

              // رابط تسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لديك حساب بالفعل؟',
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.LOGIN);
                    },
                    child: Text(
                      'سجل الدخول',
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