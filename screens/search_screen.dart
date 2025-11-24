import 'package:des/widgets/search_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/hotel_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCity = 'جميع المدن';
  double _priceRange = 150000;
  int _selectedRating = 0;
  List<String> _selectedAmenities = ['واي فاي'];

  // بيانات التواريخ والضيوف
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _rooms = 1;
  int _adults = 2;
  int _children = 0;
  bool _hasPets = false;

  // بيانات وهمية للبحث
  final List<Map<String, dynamic>> _searchResults = [
    {
      'id': '3',
      'name': 'فندق مأرب',
      'location': 'صنعاء، اليمن',
      'price': '65,000',
      'rating': 4.3,
      'reviews': 76,
      'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
      'features': ['واي فاي مجاني', 'مطعم يمني', 'مقهى تراثي'],
    },
    {
      'id': '4',
      'name': 'فندق قصر الوطن',
      'location': 'تعز، اليمن',
      'price': '95,000',
      'rating': 5.0,
      'reviews': 42,
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
      'features': ['مسبح داخلي', 'مركز سبا', 'نادي رياضي'],
    },
    {
      'id': '5',
      'name': 'فندق السعادة',
      'location': 'عدن، اليمن',
      'price': '85,000',
      'rating': 4.7,
      'reviews': 53,
      'image': 'https://images.unsplash.com/photo-1578660479946-6ae6cd6d60e7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80',
      'features': ['شاطئ خاص', 'مطعم بحري', 'واي فاي مجاني'],
    },
  ];

  final List<String> _cities = [
    'جميع المدن',
    'صنعاء',
    'عدن',
    'تعز',
    'حضرموت',
    'إب',
    'الحديدة',
    'مأرب'
  ];

  final List<String> _amenities = [
    'واي فاي',
    'مطعم',
    'مسبح',
    'موقف سيارات',
    'سبا',
    'نادي رياضي',
    'شاطئ خاص',
    'تكييف'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('البحث المتقدم'),
        backgroundColor: Color(0xFF1a365d),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // بطاقة البحث الأساسي
            SearchCard(),
            SizedBox(height: 16),

            // فلاتر البحث
            _buildFiltersCard(),
            SizedBox(height: 20),

            // نتائج البحث
            _buildResultsSection(),
          ],
        ),
      ),
    );
  }


  Widget _buildFiltersCard() {
    return Container(
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
        children: [
          // فلتر المدينة
          _buildCityFilter(),
          SizedBox(height: 16),

          // فلتر السعر
          _buildPriceFilter(),
          SizedBox(height: 16),

          // فلتر التقييم
          _buildRatingFilter(),
          SizedBox(height: 16),

          // فلتر المرافق
          _buildAmenitiesFilter(),
        ],
      ),
    );
  }

  Widget _buildCityFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المدينة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _cities.map((city) {
            final isSelected = city == _selectedCity;
            return FilterChip(
              label: Text(city),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCity = selected ? city : 'جميع المدن';
                });
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Color(0xFF1a365d),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'السعر (ريال يمني/ليلة)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Slider(
          value: _priceRange,
          min: 50000,
          max: 500000,
          divisions: 9,
          onChanged: (value) {
            setState(() {
              _priceRange = value;
            });
          },
          activeColor: Color(0xFFd69e2e),
          inactiveColor: Colors.grey[300],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '50,000 ريال',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              '500,000 ريال',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'السعر المحدد: ${_priceRange.toInt().toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (
              Match m) => '${m[1]},')} ريال',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1a365d),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التقييم',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: List.generate(5, (index) {
            final rating = 5 - index;
            final isSelected = _selectedRating == rating;
            return FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$rating نجوم'),
                  SizedBox(width: 4),
                  Icon(Icons.star, size: 16, color: Colors.orange),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedRating = selected ? rating : 0;
                });
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Color(0xFF1a365d),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildAmenitiesFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المرافق',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _amenities.map((amenity) {
            final isSelected = _selectedAmenities.contains(amenity);
            return FilterChip(
              label: Text(amenity),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAmenities.add(amenity);
                  } else {
                    _selectedAmenities.remove(amenity);
                  }
                });
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Color(0xFF1a365d),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'نتائج البحث',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1a365d),
              ),
            ),
            Text(
              '${_searchResults.length} نتيجة',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // نتائج البحث
        Column(
          children: _searchResults.map((hotel) {
            return HotelCard(
              hotel: hotel,
              onDetails: () {
                Get.toNamed(AppRoutes.HOTEL_DETAILS, arguments: hotel);
              },
              onBook: () {
                Get.toNamed(AppRoutes.BOOKING, arguments: hotel);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

}