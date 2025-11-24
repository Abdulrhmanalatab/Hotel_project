import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/offer_card.dart';

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
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'العروض الخاصة',
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
            // بانر العروض
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [theme.primaryColor, theme.primaryColor.darken(0.1)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.card_giftcard, 
                        color: Colors.white,
                        size: theme.iconTheme.size,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'عروض يمنية حصرية',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'استفد من عروضنا الخاصة لفترة محدودة واحصل على خصومات تصل إلى 40%',
                    style: theme.textTheme.bodyMedium?.copyWith(
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

// Extension مساعد لتغميق الألوان
extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}