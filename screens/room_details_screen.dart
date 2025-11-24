import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/custom_button.dart';

class RoomDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> room = Get.arguments ?? {
    'name': 'غرفة ديلوكس',
    'price': '75,000',
    'description': 'تقدم غرفة الديلوكس مساحة فسيحة وتصميمًا أنيقًا يجمع بين الأصالة اليمنية والراحة الحديثة. تحتوي الغرفة على سرير كينغ حجم كبير، منطقة جلوس منفصلة، وحمام فاخر مع أدوات استحمام فاخرة.',
    'image': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=400&q=80',
  };

  final List<String> _roomImages = [
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=400&q=80',
    'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=400&q=80',
    'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&h=400&q=80',
  ];

  final List<Map<String, dynamic>> _amenities = [
    {'icon': Icons.king_bed, 'name': 'سرير كينغ'},
    {'icon': Icons.tv, 'name': 'تلفزيون بشاشة مسطحة'},
    {'icon': Icons.ac_unit, 'name': 'تكييف'},
    {'icon': Icons.wifi, 'name': 'واي فاي مجاني'},
    {'icon': Icons.coffee, 'name': 'ماكينة قهوة'},
    {'icon': Icons.shower, 'name': 'حمام خاص'},
    {'icon': Icons.phone, 'name': 'هاتف'},
    {'icon': Icons.iron, 'name': 'مكواة'},
  ];

  final List<Map<String, dynamic>> _pricing = [
    {'label': 'السعر الأساسي', 'value': '75,000 ريال'},
    {'label': 'الضرائب', 'value': '5,000 ريال'},
    {'label': 'رسوم الخدمة', 'value': '2,000 ريال'},
    {'label': 'الإجمالي', 'value': '82,000 ريال'},
  ];

  final List<Map<String, dynamic>> _policies = [
    {'icon': Icons.access_time, 'text': 'موعد التسجيل: 2:00 مساءً'},
    {'icon': Icons.access_time, 'text': 'موعد المغادرة: 12:00 ظهراً'},
    {'icon': Icons.pets, 'text': 'لا يسمح بالحيوانات الأليفة'},
    {'icon': Icons.smoke_free, 'text': 'تدخين غير مسموح في الغرفة'},
    {'icon': Icons.child_care, 'text': 'الأطفال تحت 12 سنة مجاناً'},
    {'icon': Icons.credit_card, 'text': 'يتطلب بطاقة ائتمان للضمان'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xFF1a365d),
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'تفاصيل الغرفة',
                style: TextStyle(fontSize: 16.0),
              ),
              background: _buildImageGallery(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // معلومات الغرفة
              _buildRoomInfo(),
              SizedBox(height: 16),

              // مرافق الغرفة
              _buildRoomAmenities(),
              SizedBox(height: 16),

              // التسعير
              _buildPricingSection(),
              SizedBox(height: 16),

              // سياسات الغرفة
              _buildPoliciesSection(),
              SizedBox(height: 80),
            ]),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(),
    );
  }

  Widget _buildImageGallery() {
    return Stack(
      children: [
        PageView.builder(
          itemCount: _roomImages.length,
          itemBuilder: (context, index) {
            return Image.network(
              _roomImages[index],
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
                  child: Icon(Icons.bed, size: 60, color: Colors.grey[400]),
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
            children: List.generate(_roomImages.length, (index) {
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

  Widget _buildRoomInfo() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            room['name'],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 12),
          Text(
            room['description'],
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomAmenities() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.zero,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مرافق الغرفة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
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
            itemCount: _amenities.length,
            itemBuilder: (context, index) {
              final amenity = _amenities[index];
              return Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF1a365d).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      amenity['icon'],
                      color: Color(0xFF1a365d),
                      size: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    amenity['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
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

  Widget _buildPricingSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تفاصيل التسعير',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: _pricing.map((item) {
              final isTotal = item['label'] == 'الإجمالي';
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isTotal ? Color(0xFFd69e2e).withOpacity(0.1) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: isTotal ? Border.all(color: Color(0xFFd69e2e)) : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['label'],
                      style: TextStyle(
                        fontSize: isTotal ? 16 : 14,
                        fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                        color: isTotal ? Color(0xFF1a365d) : Colors.grey[700],
                      ),
                    ),
                    Text(
                      item['value'],
                      style: TextStyle(
                        fontSize: isTotal ? 18 : 16,
                        fontWeight: FontWeight.bold,
                        color: isTotal ? Color(0xFF1a365d) : Colors.black87,
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

  Widget _buildPoliciesSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'سياسات الغرفة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: _policies.map((policy) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      policy['icon'],
                      color: Color(0xFFd69e2e),
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        policy['text'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
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

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
                  'السعر الإجمالي',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '82,000 ريال',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a365d),
                  ),
                ),
                Text(
                  'شامل الضرائب والرسوم',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              text: 'احجز الآن',
              onPressed: () {
                Get.toNamed(AppRoutes.BOOKING, arguments: room);
              },
              backgroundColor: Color(0xFFd69e2e),
              textColor: Color(0xFF1a365d),
            ),
          ),
        ],
      ),
    );
  }
}