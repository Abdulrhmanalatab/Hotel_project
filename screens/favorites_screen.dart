import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/hotel_card.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // بيانات وهمية للفنادق المفضلة
  final List<Map<String, dynamic>> favoriteHotels = [
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
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'المفضلة',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: theme.iconTheme.size,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'الفنادق',
              icon: Icon(
                Icons.hotel,
                size: theme.iconTheme.size,
              ),
            ),
            Tab(
              text: 'العروض',
              icon: Icon(
                Icons.card_giftcard,
                size: theme.iconTheme.size,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // الفنادق المفضلة
          favoriteHotels.isEmpty
              ? _buildEmptyFavorites(theme, isRTL)
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: favoriteHotels.length,
                  itemBuilder: (context, index) {
                    return HotelCard(
                      hotel: favoriteHotels[index],
                      onDetails: () {
                        Get.toNamed('/hotel-details');
                      },
                      onBook: () {
                        Get.toNamed('/booking');
                      },
                    );
                  },
                ),

          // العروض المفضلة
          _buildEmptyOffers(theme, isRTL),
        ],
      ),
    );
  }

  Widget _buildEmptyFavorites(ThemeData theme, bool isRTL) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hotel, 
            size: 80, 
            color: theme.dividerColor
          ),
          SizedBox(height: 16),
          Text(
            'لا توجد فنادق مفضلة',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.hintColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'يمكنك إضافة الفنادق إلى المفضلة بالنقر على أيقونة القلب',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/home');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFd69e2e),
              foregroundColor: theme.primaryColor,
            ),
            child: Text('استكشف الفنادق'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyOffers(ThemeData theme, bool isRTL) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.card_giftcard, 
            size: 80, 
            color: theme.dividerColor
          ),
          SizedBox(height: 16),
          Text(
            'لا توجد عروض مفضلة',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.hintColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'يمكنك إضافة العروض إلى المفضلة بالنقر على أيقونة القلب',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/special-offers');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFd69e2e),
              foregroundColor: theme.primaryColor,
            ),
            child: Text('استكشف العروض'),
          ),
        ],
      ),
    );
  }
}