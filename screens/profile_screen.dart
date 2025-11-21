import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/core/app_controller.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  final AppController appController = Get.find<AppController>();

  // بيانات وهمية للمستخدم
  final Map<String, dynamic> userData = {
    'name': 'أحمد اليماني',
    'email': 'ahmed@yemenstay.com',
    'phone': '+967 712 345 678',
    'image': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&h=200&q=60',
    'memberSince': 'منذ 2022',
    'verified': true,
  };

  // إحصائيات المستخدم
  final List<Map<String, dynamic>> stats = [
    {'value': '5', 'label': 'حجوزات', 'icon': Icons.bookmark},
    {'value': '12', 'label': 'ليلة', 'icon': Icons.hotel},
    {'value': '4.8', 'label': 'تقييم', 'icon': Icons.star},
  ];

  // قائمة الخيارات
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.edit,
      'title': 'تعديل الملف الشخصي',
      'route': AppRoutes.EDIT_PROFILE,
      'color': Color(0xFF1a365d),
    },
    {
      'icon': Icons.favorite,
      'title': 'المفضلة',
      'route': AppRoutes.FAVORITES,
      'color': Color(0xFFe53e3e),
    },
    {
      'icon': Icons.card_giftcard,
      'title': 'العروض الخاصة',
      'route': AppRoutes.SPECIAL_OFFERS,
      'color': Color(0xFFd69e2e),
    },
    {
      'icon': Icons.notifications,
      'title': 'الإشعارات',
      'route': AppRoutes.NOTIFICATIONS,
      'color': Color(0xFF3182ce),
      'badge': '3',
    },
    {
      'icon': Icons.settings,
      'title': 'الإعدادات',
      'route': AppRoutes.SETTINGS,
      'color': Color(0xFF2d3748),
    },
    {
      'icon': Icons.help,
      'title': 'المساعدة والدعم',
      'route': AppRoutes.HELP,
      'color': Color(0xFF38a169),
    },
    {
      'icon': Icons.info,
      'title': 'عن التطبيق',
      'route': '/about',
      'color': Color(0xFF718096),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // AppBar مخصص
          SliverAppBar(
            backgroundColor: Color(0xFF1a365d),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'حسابي',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: _buildProfileHeader(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Get.toNamed(AppRoutes.SETTINGS);
                },
              ),
            ],
          ),

          // محتوى الصفحة
          SliverList(
            delegate: SliverChildListDelegate([
              // بطاقة الإحصائيات
              _buildStatsCard(),
              SizedBox(height: 16),

              // بطاقة معلومات العضوية
              _buildMembershipCard(),
              SizedBox(height: 16),

              // قائمة الخيارات
              _buildMenuList(),
              SizedBox(height: 16),

              // زر تسجيل الخروج
              _buildLogoutButton(),
              SizedBox(height: 20),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1a365d), Color(0xFF0f2040)],
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
                Text(
                  userData['name'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),

                // البريد الإلكتروني
                Text(
                  userData['email'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
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
                    style: TextStyle(
                      fontSize: 12,
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

  Widget _buildStatsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatItem({required IconData icon, required String value, required String label}) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1a365d), Color(0xFF2a4a7f)],
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1a365d),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMembershipCard() {
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'أنت مؤهل للحصول على خصومات حصرية وعروض خاصة',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // الزر
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'تطوير',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFd69e2e),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == menuItems.length - 1;

          return Column(
            children: [
              _buildMenuItem(
                icon: item['icon'],
                title: item['title'],
                color: item['color'],
                badge: item['badge'],
                onTap: () {
                  if (item['route'] != null) {
                    Get.toNamed(item['route']);
                  } else {
                    _showComingSoon();
                  }
                },
              ),
              if (!isLast) Divider(height: 1, indent: 60),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color color,
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
          size: 20,
        ),
      ),
      title: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
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
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 14,
          color: Colors.grey[600],
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomButton(
        text: 'تسجيل الخروج',
        onPressed: _showLogoutDialog,
        backgroundColor: Colors.transparent,
        textColor: Colors.red,
        isFullWidth: true,
        icon: Icons.logout,
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