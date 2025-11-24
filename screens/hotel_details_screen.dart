import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';

class HotelDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> hotel = Get.arguments ?? {
    'id': '1',
    'name': 'فندق تاج سبأ',
    'location': 'صنعاء القديمة، اليمن',
    'price': '75,000',
    'rating': 4.5,
    'reviews': 124,
    'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=400&q=80',
    'description': 'يقع فندق تاج سبأ في قلب صنعاء القديمة، ويوفر إطلالات رائعة على المدينة التاريخية. يتميز الفندق بتصميم يمني أصيل مع لمسات عصرية، ويوفر جميع وسائل الراحة الحديثة لضمان إقامة مريحة لا تُنسى.',
  };

  final List<String> _hotelImages = [
    'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=400&q=80',
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=400&q=80',
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=400&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    final List<Map<String, dynamic>> _amenities = [
      {'icon': Icons.wifi, 'name': 'واي فاي مجاني', 'size': 24.0},
      {'icon': Icons.restaurant, 'name': 'مطعم يمني', 'size': 24.0},
      {'icon': Icons.local_parking, 'name': 'موقف سيارات', 'size': 24.0},
      {'icon': Icons.pool, 'name': 'مسبح', 'size': 24.0},
      {'icon': Icons.spa, 'name': 'مركز سبا', 'size': 24.0},
      {'icon': Icons.fitness_center, 'name': 'نادي رياضي', 'size': 24.0},
      {'icon': Icons.ac_unit, 'name': 'تكييف', 'size': 24.0},
      {'icon': Icons.tv, 'name': 'تلفزيون', 'size': 24.0},
    ];

    final List<Map<String, dynamic>> _roomTypes = [
      {
        'name': 'غرفة ديلوكس',
        'price': '75,000',
        'description': 'غرفة فسيحة مع سرير كينغ وخدمة الواي فاي المجانية وحمام خاص.',
        'image': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80',
        'features': ['سرير كينغ', 'واي فاي مجاني', 'حمام خاص', 'تكييف'],
      },
      {
        'name': 'جناح رئاسي',
        'price': '120,000',
        'description': 'جناح فاخر مع غرفة معيشة منفصلة وإطلالة بانورامية على المدينة.',
        'image': 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80',
        'features': ['غرفة معيشة', 'إطلالة بانورامية', 'خدمة بتلر', 'جاكوزي'],
      },
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
                'تفاصيل الفندق',
                style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              background: _buildImageGallery(context, theme),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
              size: theme.iconTheme.size,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // معلومات الفندق
              _buildHotelInfo(theme),
              SizedBox(height: 16),

              // المرافق
              _buildAmenitiesSection(theme, _amenities),
              SizedBox(height: 16),

              // أنواع الغرف
              _buildRoomTypesSection(theme, _roomTypes, isRTL),
              SizedBox(height: 16),

              // التقييمات والمراجعات
              _buildReviewsSection(theme),
              SizedBox(height: 80),
            ]),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(theme),
    );
  }

  Widget _buildImageGallery(BuildContext context, ThemeData theme) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: _hotelImages.length,
          itemBuilder: (context, index) {
            return Image.network(
              _hotelImages[index],
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
                      Icons.hotel,
                      size: 60,
                      color: Colors.grey[400]
                  ),
                );
              },
            );
          },
        ),
        // مؤشر الصور
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_hotelImages.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.7),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildHotelInfo(ThemeData theme) {
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
            hotel['name'] ?? 'اسم الفندق',
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
                hotel['location'] ?? 'الموقع',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildRatingStars((hotel['rating'] as num?)?.toDouble() ?? 0.0, theme),
              SizedBox(width: 8),
              Text(
                '${(hotel['rating'] as num?)?.toString() ?? '0.0'} (${hotel['reviews']?.toString() ?? '0'} تقييم)',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            hotel['description'] ?? 'وصف الفندق',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesSection(ThemeData theme, List<Map<String, dynamic>> amenities) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.zero,
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
            'مرافق الفندق',
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
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: amenities.length,
            itemBuilder: (context, index) {
              final amenity = amenities[index];
              return Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      amenity['icon'],
                      color: theme.primaryColor,
                      size: amenity['size'],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    amenity['name'],
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.hintColor,
                    ),
                    maxLines: 2,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoomTypesSection(ThemeData theme, List<Map<String, dynamic>> roomTypes, bool isRTL) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أنواع الغرف',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 12),
          Column(
            children: roomTypes.map((room) {
              return _buildRoomCard(room, theme, isRTL);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room, ThemeData theme, bool isRTL) {
    // FIXED: Added null safety for all room data access
    final String roomName = room['name']?.toString() ?? 'اسم الغرفة';
    final String roomPrice = room['price']?.toString() ?? '0';
    final String roomDescription = room['description']?.toString() ?? 'وصف الغرفة';
    final String roomImage = room['image']?.toString() ?? '';
    final List<String> features = (room['features'] as List?)?.cast<String>() ?? [];

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
      child: Column(
        children: [
          // صورة الغرفة
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              roomImage,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.bed,
                    size: 50,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),
          // معلومات الغرفة
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      roomName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    Text(
                      '$roomPrice ريال',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFd69e2e),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  roomDescription,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: features.map<Widget>((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.dividerColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        feature,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                CustomButton(
                  text: 'اختر هذه الغرفة',
                  onPressed: () {
                    Get.toNamed(AppRoutes.ROOM_DETAILS, arguments: room);
                  },
                  backgroundColor: Color(0xFFd69e2e),
                  textColor: theme.primaryColor,
                  iconSize: theme.iconTheme.size,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(ThemeData theme) {
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
            'التقييمات والمراجعات',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 16),
          _buildReviewItem(
            name: 'محمد أحمد',
            rating: 5.0,
            date: '15 أكتوبر 2023',
            comment: 'فندق رائع وخدمة ممتازة. الموقع ممتاز والغرف نظيفة ومريحة.',
            theme: theme,
          ),
          SizedBox(height: 12),
          _buildReviewItem(
            name: 'فاطمة علي',
            rating: 4.5,
            date: '10 أكتوبر 2023',
            comment: 'تجربة جميلة، الطعام لذيذ والطاقم ودود. أنصح به بشدة.',
            theme: theme,
          ),
          SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: () {
                // عرض المزيد من التقييمات
              },
              child: Text(
                'عرض جميع التقييمات',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Color(0xFFd69e2e),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem({
    required String name,
    required double rating,
    required String date,
    required String comment,
    required ThemeData theme,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.dividerColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              Text(
                date,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          _buildRatingStars(rating, theme),
          SizedBox(height: 8),
          Text(
            comment,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ابتداءً من',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
                Text(
                  '${hotel['price'] ?? '0'} ريال',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                Text(
                  'لليلة الواحدة',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: CustomButton(
              text: 'احجز الآن',
              onPressed: () {
                Get.toNamed(AppRoutes.BOOKING, arguments: hotel);
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

  Widget _buildRatingStars(double rating, ThemeData theme) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) > 0;

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(
          Icons.star,
          size: 16,
          color: Color(0xFFd69e2e)
      ));
    }
    if (hasHalfStar) {
      stars.add(Icon(
          Icons.star_half,
          size: 16,
          color: Color(0xFFd69e2e)
      ));
    }
    for (int i = stars.length; i < 5; i++) {
      stars.add(Icon(
          Icons.star_border,
          size: 16,
          color: Color(0xFFd69e2e)
      ));
    }

    return Row(children: stars);
  }
}