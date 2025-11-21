import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/core/app_controller.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('الإعدادات'),
        backgroundColor: Color(0xFF1a365d),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // الوضع الليلي
            SettingsItem(
              title: 'الوضع الليلي',
              description: 'تفعيل الوضع الليلي لتجربة تصفح مريحة',
              trailing: Switch(
                value: appController.isDarkMode.value,
                onChanged: (value) {
                  appController.toggleDarkMode();
                },
                activeColor: Color(0xFFd69e2e),
              ),
            ),
            SizedBox(height: 12),

            // الإشعارات
            SettingsItem(
              title: 'الإشعارات',
              description: 'استقبال إشعارات حول العروض والتحديثات',
              trailing: Switch(
                value: appController.notificationsEnabled.value,
                onChanged: (value) {
                  appController.toggleNotifications();
                },
                activeColor: Color(0xFFd69e2e),
              ),
            ),
            SizedBox(height: 12),

            // اللغة
            SettingsItem(
              title: 'اللغة',
              description: 'اختر لغة التطبيق المفضلة لديك',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLanguageOption('العربية', 'ar'),
                  SizedBox(width: 8),
                  _buildLanguageOption('English', 'en'),
                ],
              ),
            ),
            SizedBox(height: 12),

            // العملة
            SettingsItem(
              title: 'العملة',
              description: 'اختر العملة المعروضة في التطبيق',
              trailing: Text(
                'الريال اليمني',
                style: TextStyle(
                  color: Color(0xFF1a365d),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),

            // المظهر
            SettingsItem(
              title: 'المظهر',
              description: 'اختر المظهر المناسب لك',
            ),
            SizedBox(height: 12),

            // خيارات المظهر
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildThemeOption(
                      'فاتح',
                      Icons.light_mode,
                      'light',
                      isActive: true,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildThemeOption(
                      'داكن',
                      Icons.dark_mode,
                      'dark',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildThemeOption(
                      'تلقائي',
                      Icons.auto_mode,
                      'auto',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // سياسة الخصوصية
            SettingsItem(
              title: 'سياسة الخصوصية',
              description: 'اطلع على كيفية حماية بياناتك',
              onTap: () {
                _showComingSoon();
              },
              trailing: Icon(Icons.arrow_back_ios, size: 16),
            ),
            SizedBox(height: 12),

            // شروط الاستخدام
            SettingsItem(
              title: 'شروط الاستخدام',
              description: 'اطلع على شروط استخدام التطبيق',
              onTap: () {
                _showComingSoon();
              },
              trailing: Icon(Icons.arrow_back_ios, size: 16),
            ),
            SizedBox(height: 12),

            // عن التطبيق
            SettingsItem(
              title: 'عن التطبيق',
              description: 'إصدار 1.0.0 - YemenStay',
              onTap: () {
                _showComingSoon();
              },
              trailing: Icon(Icons.arrow_back_ios, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String text, String value) {
    return GestureDetector(
      onTap: () {
        appController.changeLanguage(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: appController.selectedLanguage.value == value
              ? Color(0xFF1a365d)
              : Colors.transparent,
          border: Border.all(
            color: appController.selectedLanguage.value == value
                ? Color(0xFF1a365d)
                : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: appController.selectedLanguage.value == value
                ? Colors.white
                : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(String title, IconData icon, String theme, {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        // تغيير المظهر
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.shade50 : Colors.white,
          border: Border.all(
            color: isActive ? Color(0xFF1a365d) : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _getThemeColors(theme),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: _getIconColor(theme)),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getThemeColors(String theme) {
    switch (theme) {
      case 'dark':
        return [Color(0xFF2d2d2d), Color(0xFF1a1a1a)];
      case 'auto':
        return [Colors.grey.shade100, Colors.grey.shade300];
      default:
        return [Colors.grey.shade50, Colors.grey.shade200];
    }
  }

  Color _getIconColor(String theme) {
    switch (theme) {
      case 'dark':
        return Colors.white;
      case 'auto':
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  void _showComingSoon() {
    Get.snackbar(
      'قريباً',
      'هذه الميزة قيد التطوير',
      backgroundColor: Color(0xFFd69e2e),
      colorText: Color(0xFF1a365d),
    );
  }
}