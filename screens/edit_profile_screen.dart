import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController(text: 'أحمد اليماني');
  final TextEditingController emailController = TextEditingController(text: 'ahmed@yemenstay.com');
  final TextEditingController phoneController = TextEditingController(text: '+967 712 345 678');
  final TextEditingController birthdateController = TextEditingController(text: '1990-05-15');
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'تعديل الملف الشخصي',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: theme.iconTheme.size,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // صورة المستخدم
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&h=200&q=60'),
                  ),
                  SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      _showImagePicker(theme, isRTL);
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      size: theme.iconTheme.size,
                    ),
                    label: Text('تغيير الصورة'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xFFd69e2e),
                      side: BorderSide(color: Color(0xFFd69e2e)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // نموذج التعديل
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    label: 'الاسم الكامل',
                    hintText: 'أدخل اسمك الكامل',
                    icon: Icons.person,
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: emailController,
                    label: 'البريد الإلكتروني',
                    hintText: 'أدخل بريدك الإلكتروني',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: phoneController,
                    label: 'رقم الهاتف',
                    hintText: 'أدخل رقم هاتفك',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: birthdateController,
                    label: 'تاريخ الميلاد',
                    hintText: 'اختر تاريخ الميلاد',
                    icon: Icons.calendar_today,
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'البلد',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.hintColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: 'اليمن',
                        items: [
                          'اليمن',
                          'السعودية',
                          'الإمارات',
                          'عُمان',
                          'قطر',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: theme.textTheme.bodyMedium,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(
                            Icons.flag,
                            size: theme.iconTheme.size,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: passwordController,
                    label: 'كلمة المرور الجديدة',
                    hintText: 'أدخل كلمة مرور جديدة',
                    icon: Icons.lock,
                    isPassword: true,
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: confirmPasswordController,
                    label: 'تأكيد كلمة المرور',
                    hintText: 'أعد إدخال كلمة المرور',
                    icon: Icons.lock,
                    isPassword: true,
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'حفظ التغييرات',
                    onPressed: () {
                      _showSuccessDialog(theme);
                    },
                    backgroundColor: Color(0xFFd69e2e),
                    textColor: theme.primaryColor,
                    iconSize: theme.iconTheme.size,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePicker(ThemeData theme, bool isRTL) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.photo_library,
                size: theme.iconTheme.size,
              ),
              title: Text(
                'اختر من المعرض',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                Get.back();
                // اختيار من المعرض
              },
            ),
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                size: theme.iconTheme.size,
              ),
              title: Text(
                'التقاط صورة',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                Get.back();
                // التقاط صورة
              },
            ),
            ListTile(
              leading: Icon(
                Icons.cancel,
                size: theme.iconTheme.size,
              ),
              title: Text(
                'إلغاء',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(ThemeData theme) {
    Get.dialog(
      AlertDialog(
        backgroundColor: theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.check_circle, 
              color: Colors.green,
              size: theme.iconTheme.size,
            ),
            SizedBox(width: 8),
            Text(
              'تم التحديث',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        content: Text(
          'تم تحديث معلومات ملفك الشخصي بنجاح.',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text(
              'موافق',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}