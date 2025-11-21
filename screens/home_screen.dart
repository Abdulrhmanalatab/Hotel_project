import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/core/app_controller.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/banner_card.dart';
import 'package:des/widgets/city_card.dart';
import 'package:des/widgets/hotel_card.dart';
import 'package:des/widgets/search_card.dart';

class HomeScreen extends StatelessWidget {
  final AppController appController = Get.find<AppController>();

  // بيانات وهمية للمدن
  final List<Map<String, dynamic>> cities = [
    {
      'name': 'صنعاء',
      'description': 'العاصمة اليمنية',
      'image': 'https://images.unsplash.com/photo-1586300912110-6c43b1fe16a9?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
    },
    {
      'name': 'عدن',
      'description': 'العاصمة الاقتصادية',
      'image': 'https://images.unsplash.com/photo-1578660479946-6ae6cd6d60e7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
    },
    {
      'name': 'تعز',
      'description': 'مدينة الثقافة والتاريخ',
      'image': 'https://images.unsplash.com/photo-1589820296156-6a1f4c6a53e3?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
    },
    {
      'name': 'حضرموت',
      'description': 'أرض البخور واللبان',
      'image': 'https://images.unsplash.com/photo-1589820296156-6a1f4c6a53e3?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
    },
  ];

  // بيانات وهمية للفنادق
  final List<Map<String, dynamic>> hotels = [
    {
      'id': '1',
      'name': 'فندق تاج سبأ',
      'location': 'صنعاء القديمة، اليمن',
      'price': '75,000',
      'rating': 4.5,
      'reviews': 124,
      'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
      'features': ['واي فاي مجاني', 'مطعم يمني أصيل', 'موقف سيارات'],
    },
    {
      'id': '2',
      'name': 'فندق شيراتون عدن',
      'location': 'خليج عدن، اليمن',
      'price': '120,000',
      'rating': 5.0,
      'reviews': 89,
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
      'features': ['مسبح', 'مركز سبا', 'شاطئ خاص'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF1a365d),
        title: Row(
          children: [
            Icon(Icons.landscape, color: Color(0xFFd69e2e)),
            SizedBox(width: 8),
            Text(
              'BookEase',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications, color: Colors.white),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.NOTIFICATIONS);
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Get.toNamed(AppRoutes.SEARCH);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // رسالة ترحيب
            BannerCard(
              message: 'أهلاً بك في BookEase اكتشف جمال اليمن',
              backgroundColor: Color(0xFFd69e2e),
              textColor: Color(0xFF1a365d),
              icon: Icons.coffee,
            ),
            SizedBox(height: 16),

            // بطاقة البحث
            SearchCard(),
            SizedBox(height: 24),

            // قسم المدن
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المدن اليمنية',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a365d),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // التنقل لصفحة المدن
                  },
                  child: Row(
                    children: [
                      Text(
                        'عرض الكل',
                        style: TextStyle(color: Color(0xFFd69e2e)),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_back_ios, size: 14, color: Color(0xFFd69e2e)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // شبكة المدن
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return CityCard(
                  city: cities[index],
                  onTap: () {
                    Get.toNamed(AppRoutes.HOTEL_DETAILS);
                  },
                );
              },
            ),
            SizedBox(height: 24),

            // قسم العروض الخاصة
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1a365d), Color(0xFF0f2040)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.card_giftcard, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'عروض يمنية حصرية',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'استفد من عروضنا الخاصة لفترة محدودة واحصل على خصومات تصل إلى 40%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.SPECIAL_OFFERS);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFd69e2e),
                        foregroundColor: Color(0xFF1a365d),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_fire_department),
                          SizedBox(width: 8),
                          Text(
                            'استعرض العروض',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // قسم الفنادق المميزة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'فنادق مميزة في اليمن',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a365d),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.SEARCH);
                  },
                  child: Row(
                    children: [
                      Text(
                        'عرض الكل',
                        style: TextStyle(color: Color(0xFFd69e2e)),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_back_ios, size: 14, color: Color(0xFFd69e2e)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // قائمة الفنادق
            Column(
              children: hotels.map((hotel) {
                return HotelCard(
                  hotel: hotel,
                  onDetails: () {
                    Get.toNamed(AppRoutes.HOTEL_DETAILS);
                  },
                  onBook: () {
                    Get.toNamed(AppRoutes.BOOKING);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // قسم التراث اليمني
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.landscape, color: Color(0xFF1a365d)),
                      SizedBox(width: 8),
                      Text(
                        'اكتشف التراث اليمني',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1a365d),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'اليمن موطن لأقدم الحضارات العربية وتتميز بتراث غني وعريق. استمتع بتجربة فريدة تجمع بين الأصالة والحداثة.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 15),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.5,
                    children: [
                      _buildHeritageItem(Icons.restaurant, 'المطبخ اليمني الأصيل'),
                      _buildHeritageItem(Icons.mosque, 'المساجد التاريخية'),
                      _buildHeritageItem(Icons.landscape, 'القرى الجبلية'),
                      _buildHeritageItem(Icons.history, 'المواقع الأثرية'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 80), // مساحة للتنقل السفلي
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeritageItem(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Color(0xFFd69e2e), size: 24),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: appController.currentPageIndex.value,
        onTap: (index) {
          appController.changePage(index);
          switch (index) {
            case 0:
              Get.offAllNamed(AppRoutes.HOME);
              break;
            case 1:
              Get.toNamed(AppRoutes.SEARCH);
              break;
            case 2:
              Get.toNamed(AppRoutes.BOOKINGS);
              break;
            case 3:
              Get.toNamed(AppRoutes.PROFILE);
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFd69e2e),
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'البحث',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'حجوزاتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}