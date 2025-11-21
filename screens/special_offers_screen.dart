import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/offer_card.dart';

class SpecialOffersScreen extends StatelessWidget {
  // بيانات وهمية للعروض
  final List<Map<String, dynamic>> offers = [
    {
      'id': '1',
      'title': 'عطلة نهاية الأسبوع في صنعاء',
      'location': 'فندق تاج سبأ، صنعاء',
      'originalPrice': '210,000',
      'discountedPrice': '147,000',
      'discount': '30%',
      'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
      'validUntil': 'صالح حتى 30 ديسمبر 2023',
    },
    {
      'id': '2',
      'title': 'عطلة شتوية دافئة في عدن',
      'location': 'فندق شيراتون عدن، عدن',
      'originalPrice': '360,000',
      'discountedPrice': '270,000',
      'discount': '25%',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
      'validUntil': 'صالح حتى 15 يناير 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('العروض الخاصة'),
        backgroundColor: Color(0xFF1a365d),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // بانر العروض
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
                ],
              ),
            ),
            SizedBox(height: 20),

            // قائمة العروض
            Column(
              children: offers.map((offer) {
                return OfferCard(
                  offer: offer,
                  onBook: () {
                    Get.toNamed(AppRoutes.BOOKING);
                  },
                  onFavorite: () {
                    _toggleFavorite(offer['id']);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite(String offerId) {
    Get.snackbar(
      'تمت الإضافة',
      'تمت إضافة العرض إلى المفضلة',
      backgroundColor: Color(0xFFd69e2e),
      colorText: Color(0xFF1a365d),
    );
  }
}