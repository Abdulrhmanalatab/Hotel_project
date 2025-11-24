import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/app_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  final AppController appController = Get.find<AppController>();

  // بيانات وهمية للمستخدم
  final Map<String, dynamic> userData = {
    'name': 'Abdulrhman',
    'email': 'abood@yemenstay.com',
    'phone': '+967 712 345 678',
    'image': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&h=200&q=60',
    'memberSince': 'منذ 2022',
    'verified': true,
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    // إحصائيات المستخدم
    final List<Map<String, dynamic>> stats = [
      {
        'value': '5',
        'label': 'حجوزات',
        'icon': Icons.bookmark,
        'color': theme.primaryColor,
        'size': 24.0,
      },
      {
        'value': '12',
        'label': 'ليلة',
        'icon': Icons.hotel,
        'color': theme.primaryColor,
        'size': 24.0,
      },
      {
        'value': '4.8',
        'label': 'تقييم',
        'icon': Icons.star,
        'color': theme.primaryColor,
        'size': 24.0,
      },
    ];

    // قائمة الخيارات
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.edit,
        'title': 'تعديل الملف الشخصي',
        'route': AppRoutes.EDIT_PROFILE,
        'color': theme.primaryColor,
        'iconSize': 20.0,
      },
      {
        'icon': Icons.favorite,
        'title': 'المفضلة',
        'route': AppRoutes.FAVORITES,
        'color': Colors.red,
        'iconSize': 20.0,
      },
      {
        'icon': Icons.card_giftcard,
        'title': 'العروض الخاصة',
        'route': AppRoutes.SPECIAL_OFFERS,
        'color': Color(0xFFd69e2e),
        'iconSize': 20.0,
      },
      {
        'icon': Icons.notifications,
        'title': 'الإشعارات',
        'route': AppRoutes.NOTIFICATIONS,
        'color': Colors.blue,
        'iconSize': 20.0,
        'badge': '3',
      },
      {
        'icon': Icons.settings,
        'title': 'الإعدادات',
        'route': AppRoutes.SETTINGS,
        'color': Colors.grey[700]!,
        'iconSize': 20.0,
      },
      {
        'icon': Icons.help,
        'title': 'المساعدة والدعم',
        'route': AppRoutes.HELP,
        'color': Colors.green,
        'iconSize': 20.0,
      },
      {
        'icon': Icons.info,
        'title': 'عن التطبيق',
        'route': '/about',
        'color': Colors.grey[600]!,
        'iconSize': 20.0,
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            // AppBar مخصص
            SliverAppBar(
              backgroundColor: theme.primaryColor,
              expandedHeight: 350.0, // زيادة الارتفاع قليلاً
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'حسابي',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: _buildProfileHeader(context, theme),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: theme.iconTheme.size,
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.SETTINGS);
                  },
                ),
              ],
            ),

            // محتوى الصفحة
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0), // إضافة padding سفلي إضافي
                child: Column(
                  children: [
                    // بطاقة الإحصائيات
                    _buildStatsCard(context, theme, stats),
                    SizedBox(height: 16),

                    // بطاقة معلومات العضوية
                    _buildMembershipCard(context, theme),
                    SizedBox(height: 16),

                    // قائمة الخيارات
                    _buildMenuList(context, theme, menuItems, isRTL),
                    SizedBox(height: 16),

                    // زر تسجيل الخروج
                    _buildLogoutButton(context, theme),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.primaryColor, theme.primaryColor.darken(0.1)],
        ),
      ),
      child: Stack(
        children: [
          // خلفية زخرفية
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFd69e2e).withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFd69e2e).withOpacity(0.1),
              ),
            ),
          ),

          // محتوى الرأس
          Padding(
            padding: EdgeInsets.only(top: 70, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // صورة المستخدم
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFFd69e2e),
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          userData['image'],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFd69e2e),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // شارة التحقق
                    if (userData['verified'])
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16),

                // اسم المستخدم
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    userData['name'],
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4),

                // البريد الإلكتروني
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    userData['email'],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),

                // معلومات العضوية
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFd69e2e).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFFd69e2e).withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    'عضو ${userData['memberSince']}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Color(0xFFd69e2e),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, ThemeData theme, List<Map<String, dynamic>> stats) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats.map((stat) {
          return _buildStatItem(
            icon: stat['icon'],
            value: stat['value'],
            label: stat['label'],
            color: stat['color'],
            size: stat['size'],
            theme: theme,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required double size,
    required ThemeData theme,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.darken(0.1)],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: size,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard(BuildContext context, ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFd69e2e), Color(0xFFb5821f)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFd69e2e).withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // الأيقونة
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: 16),

          // المحتوى
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عضو متميز',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'أنت مؤهل للحصول على خصومات حصرية وعروض خاصة',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // الزر
          GestureDetector(
            onTap: _showComingSoon,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'تطوير',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFd69e2e),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context, ThemeData theme, List<Map<String, dynamic>> menuItems, bool isRTL) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return _buildMenuItem(
            icon: item['icon'],
            title: item['title'],
            color: item['color'],
            iconSize: item['iconSize'],
            badge: item['badge'],
            theme: theme,
            isRTL: isRTL,
            onTap: () {
              if (item['route'] != null) {
                Get.toNamed(item['route']);
              } else {
                _showComingSoon();
              }
            },
          );
        },
        separatorBuilder: (context, index) => Divider(height: 1, indent: 60),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color color,
    required double iconSize,
    required ThemeData theme,
    required bool isRTL,
    String? badge,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: color,
          size: iconSize,
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (badge != null) ...[
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: theme.dividerColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isRTL ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios,
          size: 14,
          color: theme.hintColor,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomButton(
        text: 'تسجيل الخروج',
        onPressed: _showLogoutDialog,
        backgroundColor: Colors.transparent,
        textColor: Colors.red,
        isFullWidth: true,
        icon: Icons.logout,
        iconSize: 20,
       // borderColor: Colors.red,
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // الأيقونة
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              SizedBox(height: 16),

              // العنوان
              Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8),

              // الرسالة
              Text(
                'هل أنت متأكد من رغبتك في تسجيل الخروج من حسابك؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24),

              // الأزرار
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'إلغاء',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        _performLogout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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

  void _performLogout() {
    // إظهار رسالة نجاح
    Get.snackbar(
      'تم تسجيل الخروج',
      'تم تسجيل خروجك بنجاح',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );

    // الانتقال إلى شاشة تسجيل الدخول بعد ثانيتين
    Future.delayed(Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.LOGIN);
    });
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

// Extension مساعد لتغميق الألوان
extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}