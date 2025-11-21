import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/booking_card.dart';

class BookingsScreen extends StatefulWidget {
  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> with SingleTickerProviderStateMixin {
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

  // بيانات وهمية للحجوزات
  final List<Map<String, dynamic>> currentBookings = [
    {
      'id': 'YM20231015',
      'hotelName': 'فندق تاج سبأ',
      'location': 'صنعاء القديمة',
      'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
      'dates': '15 أكتوبر - 19 أكتوبر 2023',
      'nights': '4 ليالي',
      'price': '75,000',
      'status': 'confirmed',
    },
    {
      'id': 'YM20231122',
      'hotelName': 'فندق شيراتون عدن',
      'location': 'خليج عدن',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
      'dates': '22 نوفمبر - 25 نوفمبر 2023',
      'nights': '3 ليالي',
      'price': '120,000',
      'status': 'pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('حجوزاتي'),
        backgroundColor: Color(0xFF1a365d),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'الحجوزات الحالية'),
            Tab(text: 'الحجوزات السابقة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // الحجوزات الحالية
          currentBookings.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: currentBookings.length,
                  itemBuilder: (context, index) {
                    return BookingCard(
                      booking: currentBookings[index],
                      onTap: () {
                        Get.toNamed(AppRoutes.BOOKING_DETAILS);
                      },
                    );
                  },
                ),

          // الحجوزات السابقة
          _buildEmptyState(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.SEARCH);
        },
        backgroundColor: Color(0xFFd69e2e),
        foregroundColor: Color(0xFF1a365d),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'لا توجد حجوزات سابقة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'لم تقم بأي حجوزات سابقة حتى الآن',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.HOME);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFd69e2e),
              foregroundColor: Color(0xFF1a365d),
            ),
            child: Text('استكشف الفنادق'),
          ),
        ],
      ),
    );
  }
}