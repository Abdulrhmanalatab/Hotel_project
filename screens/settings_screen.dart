import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/app_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'الإعدادات',
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
              theme: theme,
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
              theme: theme,
            ),
            SizedBox(height: 12),

            // اللغة
            SettingsItem(
              title: 'اللغة',
              description: 'اختر لغة التطبيق المفضلة لديك',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLanguageOption('العربية', 'ar', theme),
                  SizedBox(width: 8),
                  _buildLanguageOption('English', 'en', theme),
                ],
              ),
              theme: theme,
            ),
            SizedBox(height: 12),

            // العملة
            SettingsItem(
              title: 'العملة',
              description: 'اختر العملة المعروضة في التطبيق',
              trailing: Text(
                'الريال اليمني',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              theme: theme,
            ),
            SizedBox(height: 12),

            // المظهر
            SettingsItem(
              title: 'المظهر',
              description: 'اختر المظهر المناسب لك',
              theme: theme,
            ),
            SizedBox(height: 12),

            // خيارات المظهر
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
              child: Row(
                children: [
                  Expanded(
                    child: _buildThemeOption(
                      'فاتح',
                      Icons.light_mode,
                      'light',
                      theme,
                      isActive: true,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildThemeOption(
                      'داكن',
                      Icons.dark_mode,
                      'dark',
                      theme,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildThemeOption(
                      'تلقائي',
                      Icons.auto_mode,
                      'auto',
                      theme,
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
              trailing: Icon(
                isRTL ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                size: 16,
                color: theme.hintColor,
              ),
              theme: theme,
            ),
            SizedBox(height: 12),

            // شروط الاستخدام
            SettingsItem(
              title: 'شروط الاستخدام',
              description: 'اطلع على شروط استخدام التطبيق',
              onTap: () {
                _showComingSoon();
              },
              trailing: Icon(
                isRTL ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                size: 16,
                color: theme.hintColor,
              ),
              theme: theme,
            ),
            SizedBox(height: 12),

            // عن التطبيق
            SettingsItem(
              title: 'عن التطبيق',
              description: 'إصدار 1.0.0 - YemenStay',
              onTap: () {
                _showComingSoon();
              },
              trailing: Icon(
                isRTL ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                size: 16,
                color: theme.hintColor,
              ),
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String text, String value, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        appController.changeLanguage(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: appController.selectedLanguage.value == value
              ? theme.primaryColor
              : Colors.transparent,
          border: Border.all(
            color: appController.selectedLanguage.value == value
                ? theme.primaryColor
                : theme.dividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            color: appController.selectedLanguage.value == value
                ? Colors.white
                : theme.hintColor,
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(String title, IconData icon, String themeType, ThemeData theme, {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        // تغيير المظهر
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? theme.primaryColor.withOpacity(0.1) : theme.cardColor,
          border: Border.all(
            color: isActive ? theme.primaryColor : theme.dividerColor,
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
                  colors: _getThemeColors(themeType, theme),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon, 
                color: _getIconColor(themeType, theme),
                size: theme.iconTheme.size,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: theme.hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getThemeColors(String themeType, ThemeData theme) {
    switch (themeType) {
      case 'dark':
        return [Color(0xFF2d2d2d), Color(0xFF1a1a1a)];
      case 'auto':
        return [theme.dividerColor.withOpacity(0.1), theme.dividerColor.withOpacity(0.3)];
      default:
        return [theme.dividerColor.withOpacity(0.05), theme.dividerColor.withOpacity(0.2)];
    }
  }

  Color _getIconColor(String themeType, ThemeData theme) {
    switch (themeType) {
      case 'dark':
        return Colors.white;
      case 'auto':
        return theme.hintColor;
      default:
        return theme.hintColor;
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