import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';

class OfferDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> offer = Get.arguments ?? {
    'id': '1',
    'title': 'عطلة نهاية الأسبوع في صنعاء القديمة',
    'location': 'فندق تاج سبأ، صنعاء',
    'originalPrice': '210,000',
    'discountedPrice': '147,000',
    'discount': '30%',
    'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=400&q=80',
    'description': 'استمتع بعطلة نهاية أسبوع لا تُنسى في قلب صنعاء القديمة. يشمل العرض إقامة لمدة ليلتين في فندق تاج سبأ مع وجبة إفطار مجانية وتذاكر دخول للمواقع التاريخية القريبة.',
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    final List<Map<String, dynamic>> _offerFeatures = [
      {'icon': Icons.calendar_today, 'text': '2 ليلة / 3 أيام', 'size': 20.0},
      {'icon': Icons.person, 'text': 'لغاية 2 شخص', 'size': 20.0},
      {'icon': Icons.restaurant, 'text': 'وجبة إفطار مجانية', 'size': 20.0},
      {'icon': Icons.map, 'text': 'جولة سياحية مجانية', 'size': 20.0},
      {'icon': Icons.local_offer, 'text': 'خصم 30%', 'size': 20.0},
      {'icon': Icons.wifi, 'text': 'واي فاي مجاني', 'size': 20.0},
    ];

    final List<Map<String, dynamic>> _terms = [
      {'text': 'العرض ساري حتى 30 ديسمبر 2023'},
      {'text': 'الحجز المسبق قبل 7 أيام على الأقل'},
      {'text': 'لا يمكن استرداد المبلغ بعد الحجز'},
      {'text': 'يشمل العرض وجبة إفطار فقط'},
      {'text': 'غير شامل تذاكر الطيران'},
      {'text': 'يشمل نقل من وإلى المطار'},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.primaryColor,
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'تفاصيل العرض',
                style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              background: _buildOfferImage(theme),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
              size: theme.iconTheme.size,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // محتوى العرض
              _buildOfferContent(theme),
              SizedBox(height: 16),

              // ميزات العرض
              _buildFeaturesSection(theme, _offerFeatures),
              SizedBox(height: 16),

              // شروط العرض
              _buildTermsSection(theme, _terms),
              SizedBox(height: 16),

              // فنادق مشابهة
              _buildSimilarOffers(theme, isRTL),
              SizedBox(height: 80),
            ]),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(theme),
    );
  }

  Widget _buildOfferImage(ThemeData theme) {
    return Stack(
      children: [
        Image.network(
          offer['image'],
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey[200],
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFd69e2e),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: Icon(
                Icons.card_giftcard, 
                size: 60, 
                color: Colors.grey[400]
              ),
            );
          },
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFFd69e2e),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'خصم ${offer['discount']}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOfferContent(ThemeData theme) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer['title'],
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on, 
                size: 16, 
                color: theme.primaryColor
              ),
              SizedBox(width: 4),
              Text(
                offer['location'],
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            offer['description'],
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
              height: 1.6,
            ),
          ),
          SizedBox(height: 20),
          _buildPriceSection(theme),
        ],
      ),
    );
  }

  Widget _buildPriceSection(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.dividerColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'السعر الأصلي',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
          Text(
            '${offer['originalPrice']} ريال',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.hintColor,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'السعر بعد الخصم',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${offer['discountedPrice']} ريال',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFd69e2e),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'وفر ${offer['discount']}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(ThemeData theme, List<Map<String, dynamic>> features) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مميزات العرض',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return Container(
                decoration: BoxDecoration(
                  color: theme.dividerColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(
                      feature['icon'],
                      color: Color(0xFFd69e2e),
                      size: feature['size'],
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature['text'],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection(ThemeData theme, List<Map<String, dynamic>> terms) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'شروط العرض',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: terms.map((term) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFFd69e2e),
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        term['text'],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarOffers(ThemeData theme, bool isRTL) {
    final List<Map<String, dynamic>> similarOffers = [
      {
        'title': 'عطلة شتوية دافئة في عدن',
        'location': 'فندق شيراتون عدن',
        'price': '270,000',
        'discount': '25%',
        'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80',
      },
      {
        'title': 'رحلة استكشافية إلى حضرموت',
        'location': 'فندق قصر حضرموت',
        'price': '180,000',
        'discount': '20%',
        'image': 'https://images.unsplash.com/photo-1589820296156-6a1f4c6a53e3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80',
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'عروض مشابهة',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 12),
          Column(
            children: similarOffers.map((offer) {
              return _buildSimilarOfferCard(offer, theme, isRTL);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarOfferCard(Map<String, dynamic> offer, ThemeData theme, bool isRTL) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
          // صورة العرض
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: isRTL ? Radius.circular(12) : Radius.zero,
                bottomRight: isRTL ? Radius.circular(12) : Radius.zero,
                topLeft: !isRTL ? Radius.circular(12) : Radius.zero,
                bottomLeft: !isRTL ? Radius.circular(12) : Radius.zero,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: isRTL ? Radius.circular(12) : Radius.zero,
                bottomRight: isRTL ? Radius.circular(12) : Radius.zero,
                topLeft: !isRTL ? Radius.circular(12) : Radius.zero,
                bottomLeft: !isRTL ? Radius.circular(12) : Radius.zero,
              ),
              child: Image.network(
                offer['image'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12),
          // معلومات العرض
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer['title'],
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    offer['location'],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(0xFFd69e2e),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'خصم ${offer['discount']}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${offer['price']} ريال',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // زر المفضلة
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: theme.dividerColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(
                Icons.favorite_border, 
                color: Color(0xFFd69e2e),
                size: theme.iconTheme.size,
              ),
              onPressed: () {
                Get.snackbar(
                  'تمت الإضافة',
                  'تمت إضافة العرض إلى المفضلة',
                  backgroundColor: Color(0xFFd69e2e),
                  colorText: theme.primaryColor,
                );
              },
            ),
          ),
          SizedBox(width: 12),
          // زر الحجز
          Expanded(
            child: CustomButton(
              text: 'احجز هذا العرض',
              onPressed: () {
                Get.toNamed(AppRoutes.BOOKING, arguments: offer);
              },
              backgroundColor: Color(0xFFd69e2e),
              textColor: theme.primaryColor,
              iconSize: theme.iconTheme.size,
            ),
          ),
        ],
      ),
    );
  }
}