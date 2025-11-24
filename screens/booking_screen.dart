import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/custom_button.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _currentStep = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _specialRequestsController = TextEditingController();

  final List<Step> _steps = [
    Step(
      title: Text('المعلومات'),
      content: _Step1Content(),
      isActive: true,
    ),
    Step(
      title: Text('الدفع'),
      content: _Step2Content(),
      isActive: false,
    ),
    Step(
      title: Text('التأكيد'),
      content: _Step3Content(),
      isActive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('عملية الحجز'),
        backgroundColor: Color(0xFF1a365d),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // شريط التقدم
            _buildProgressSteps(),
            SizedBox(height: 24),

            // محتوى الخطوة الحالية
            _buildCurrentStepContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSteps() {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProgressStep(
            number: 1,
            label: 'المعلومات',
            isActive: _currentStep >= 0,
            isCompleted: _currentStep > 0,
          ),
          Expanded(
            child: Divider(
              color: _currentStep > 0 ? Colors.green : Colors.grey[300],
              thickness: 2,
            ),
          ),
          _buildProgressStep(
            number: 2,
            label: 'الدفع',
            isActive: _currentStep >= 1,
            isCompleted: _currentStep > 1,
          ),
          Expanded(
            child: Divider(
              color: _currentStep > 1 ? Colors.green : Colors.grey[300],
              thickness: 2,
            ),
          ),
          _buildProgressStep(
            number: 3,
            label: 'التأكيد',
            isActive: _currentStep >= 2,
            isCompleted: _currentStep > 2,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep({
    required int number,
    required String label,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green
                : isActive
                    ? Color(0xFF1a365d)
                    : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    number.toString(),
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Color(0xFF1a365d) : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      default:
        return _buildStep1();
    }
  }

  Widget _buildStep1() {
    return Container(
      padding: EdgeInsets.all(20),
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
          // ملخص الحجز
          _buildBookingSummary(),
          SizedBox(height: 24),

          // معلومات الحجز
          _buildBookingForm(),
          SizedBox(height: 24),

          // أزرار التنقل
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&h=200&q=80',
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
                      'غرفة ديلوكس - فندق تاج سبأ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1a365d),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '15 أكتوبر - 19 أكتوبر 2023 (4 ليالي)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الإجمالي:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '320,000 ريال',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF1a365d),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'معلومات الحجز',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1a365d),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'الاسم الكامل',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'البريد الإلكتروني',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'رقم الهاتف',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        SizedBox(height: 16),
        _buildGuestDetails(),
        SizedBox(height: 16),
        TextField(
          controller: _specialRequestsController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'طلبات خاصة (اختياري)',
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }

  Widget _buildGuestDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تفاصيل الضيوف',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عدد البالغين',
                      style: TextStyle(fontSize: 14),
                    ),
                    DropdownButtonFormField<String>(
                      value: '2 بالغين',
                      items: ['1 بالغ', '2 بالغين', '3 بالغين', '4 بالغين']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عدد الأطفال',
                      style: TextStyle(fontSize: 14),
                    ),
                    DropdownButtonFormField<String>(
                      value: 'لا يوجد أطفال',
                      items: [
                        'لا يوجد أطفال',
                        '1 طفل',
                        '2 أطفال',
                        '3 أطفال'
                      ].map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Get.back();
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('رجوع'),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            text: 'التالي إلى الدفع',
            onPressed: () {
              setState(() {
                _currentStep = 1;
              });
            },
            backgroundColor: Color(0xFFd69e2e),
            textColor: Color(0xFF1a365d),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Container(
      padding: EdgeInsets.all(20),
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
          Text(
            'خطوة الدفع - قيد التطوير',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 100),
          Icon(
            Icons.credit_card,
            size: 80,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16),
          Text(
            'سيتم إضافة خيارات الدفع قريباً',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 24),
          _buildStep2NavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildStep2NavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                _currentStep = 0;
              });
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('رجوع'),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            text: 'تخطي إلى التأكيد',
            onPressed: () {
              Get.toNamed(AppRoutes.CONFIRMATION);
            },
            backgroundColor: Color(0xFFd69e2e),
            textColor: Color(0xFF1a365d),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Container(
      padding: EdgeInsets.all(20),
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
          Text(
            'خطوة التأكيد - قيد التطوير',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 100),
          Icon(
            Icons.check_circle_outline,
            size: 80,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16),
          Text(
            'سيتم إضافة تأكيد الحجز قريباً',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// محتوى الخطوات (مؤقت)
class _Step1Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _Step2Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _Step3Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}