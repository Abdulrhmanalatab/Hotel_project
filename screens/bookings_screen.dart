import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';

class BookingsScreen extends StatelessWidget {
  // بيانات وهمية للحجوزات
  final List<Map<String, dynamic>> bookings = [
    {
      'id': 'YM2024001',
      'hotelName': 'فندق تاج سبأ',
      'location': 'صنعاء القديمة',
      'checkIn': '2024-01-15',
      'checkOut': '2024-01-18',
      'guests': '2 بالغين',
      'rooms': '1 غرفة',
      'totalPrice': '225,000',
      'status': 'confirmed',
      'statusText': 'مؤكد',
      'statusColor': Colors.green,
      'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
    },
    {
      'id': 'YM2024002',
      'hotelName': 'فندق شيراتون عدن',
      'location': 'خليج عدن',
      'checkIn': '2024-02-20',
      'checkOut': '2024-02-25',
      'guests': '4 بالغين، 2 أطفال',
      'rooms': '2 غرفة',
      'totalPrice': '600,000',
      'status': 'pending',
      'statusText': 'قيد المراجعة',
      'statusColor': Colors.orange,
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
    },
    {
      'id': 'YM2024003',
      'hotelName': 'منتجع تعز الجبلي',
      'location': 'تعز',
      'checkIn': '2024-03-10',
      'checkOut': '2024-03-12',
      'guests': '1 بالغ',
      'rooms': '1 غرفة',
      'totalPrice': '150,000',
      'status': 'cancelled',
      'statusText': 'ملغية',
      'statusColor': Colors.red,
      'image': 'https://images.unsplash.com/photo-1589820296156-6a1f4c6a53e3?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          'حجوزاتي',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            isRTL ? Icons.arrow_forward : Icons.arrow_back,
            color: Colors.white,
            size: theme.iconTheme.size,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: theme.iconTheme.size,
        ),
      ),
      body: bookings.isEmpty ? _buildEmptyState(theme) : _buildBookingsList(theme, isRTL),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 80,
            color: theme.hintColor.withOpacity(0.5),
          ),
          SizedBox(height: 20),
          Text(
            'لا توجد حجوزات',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'احجز أول رحلة لك واستمتع بتجربة فريدة',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
          SizedBox(height: 20),
          CustomButton(
            text: 'استكشاف الفنادق',
            onPressed: () {
              Get.offAllNamed(AppRoutes.HOME);
            },
            backgroundColor: Color(0xFFd69e2e),
            textColor: Colors.white,
            icon: Icons.search,
            iconSize: theme.iconTheme.size,
            isFullWidth: false,
            theme: theme, // Add this line
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(ThemeData theme, bool isRTL) {
    return Column(
      children: [
        // فلاتر الحجوزات
        Container(
          padding: EdgeInsets.all(16),
          color: theme.cardColor,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.primaryColor,
                    side: BorderSide(color: theme.primaryColor),
                  ),
                  child: Text('الكل'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: BorderSide(color: Colors.green),
                  ),
                  child: Text('مؤكدة'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: BorderSide(color: Colors.orange),
                  ),
                  child: Text('قيد المراجعة'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        // قائمة الحجوزات
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return _buildBookingCard(booking, theme, isRTL);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking, ThemeData theme, bool isRTL) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
          // رأس البطاقة
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // صورة الفندق
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(booking['image'] as String),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['hotelName'] as String,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: theme.hintColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            booking['location'] as String,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (booking['statusColor'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: booking['statusColor'] as Color),
                  ),
                  child: Text(
                    booking['statusText'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: booking['statusColor'] as Color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // تفاصيل الحجز
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: theme.dividerColor.withOpacity(0.1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('رقم الحجز:', style: theme.textTheme.bodySmall),
                    Text(booking['id'] as String, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('تاريخ الوصول:', style: theme.textTheme.bodySmall),
                    Text(booking['checkIn'] as String, style: theme.textTheme.bodyMedium),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('تاريخ المغادرة:', style: theme.textTheme.bodySmall),
                    Text(booking['checkOut'] as String, style: theme.textTheme.bodyMedium),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('الضيوف:', style: theme.textTheme.bodySmall),
                    Text(booking['guests'] as String, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
          // السعر والأزرار
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الإجمالي',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                    Text(
                      '${booking['totalPrice']} ريال',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.BOOKING_DETAILS);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.primaryColor,
                        side: BorderSide(color: theme.primaryColor),
                      ),
                      child: Text('تفاصيل'),
                    ),
                    SizedBox(width: 8),
                    if (booking['status'] == 'confirmed')
                      ElevatedButton(
                        onPressed: () {
                          _showCancelDialog(theme);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('إلغاء'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(ThemeData theme) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'تأكيد الإلغاء',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
          content: Text(
            'هل أنت متأكد من أنك تريد إلغاء هذه الحجز؟ قد تطبق رسوم إلغاء حسب سياسة الفندق.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'تراجع',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                // إلغاء الحجز
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('تأكيد الإلغاء'),
            ),
          ],
        );
      },
    );
  }
}