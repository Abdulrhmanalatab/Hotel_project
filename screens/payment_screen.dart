import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/custom_button.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'credit_card';
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('إتمام الدفع'),
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

            // ملخص الدفع
            _buildPaymentSummary(),
            SizedBox(height: 24),

            // طرق الدفع
            _buildPaymentMethods(),
            SizedBox(height: 24),

            // نموذج الدفع
            if (_selectedPaymentMethod == 'credit_card') _buildPaymentForm(),

            // زر الدفع
            _buildPaymentButton(),
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
            number: '✓',
            label: 'المعلومات',
            isCompleted: true,
          ),
          Expanded(
            child: Divider(
              color: Colors.green,
              thickness: 2,
            ),
          ),
          _buildProgressStep(
            number: '2',
            label: 'الدفع',
            isActive: true,
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[300]!,
              thickness: 2,
            ),
          ),
          _buildProgressStep(
            number: '3',
            label: 'التأكيد',
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep({
    required String number,
    required String label,
    bool isCompleted = false,
    bool isActive = false,
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
                    number,
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

  Widget _buildPaymentSummary() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ملخص الدفع',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 16),
          _buildSummaryItem('سعر الغرفة (4 ليالي)', '300,000 ريال'),
          _buildSummaryItem('الضرائب والرسوم', '20,000 ريال'),
          _buildSummaryItem('خصم خاص', '-15,000 ريال'),
          Divider(height: 24),
          _buildSummaryItem('المبلغ الإجمالي', '305,000 ريال', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? Color(0xFF1a365d) : Colors.grey[600],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.bold,
              color: isTotal ? Color(0xFF1a365d) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اختر طريقة الدفع',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 16),
          _buildPaymentOption(
            value: 'credit_card',
            title: 'بطاقة ائتمان / مدى',
            description: 'ادخل تفاصيل بطاقتك الائتمانية',
            icon: Icons.credit_card,
            isSelected: _selectedPaymentMethod == 'credit_card',
          ),
          SizedBox(height: 12),
          _buildPaymentOption(
            value: 'wallet',
            title: 'المحفظة الإلكترونية',
            description: 'ادفع عبر STC Pay أو شبكة',
            icon: Icons.wallet,
            isSelected: _selectedPaymentMethod == 'wallet',
          ),
          SizedBox(height: 12),
          _buildPaymentOption(
            value: 'bank',
            title: 'التحويل البنكي',
            description: 'ادفع عبر التحويل البنكي المباشر',
            icon: Icons.account_balance,
            isSelected: _selectedPaymentMethod == 'bank',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String value,
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1a365d).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xFF1a365d) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF1a365d) : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Color(0xFF1a365d),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Color(0xFF1a365d) : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Color(0xFFd69e2e),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentForm() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات البطاقة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _cardNumberController,
            decoration: InputDecoration(
              labelText: 'رقم البطاقة',
              hintText: '1234 5678 9012 3456',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.credit_card),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _expiryDateController,
                  decoration: InputDecoration(
                    labelText: 'تاريخ الانتهاء',
                    hintText: 'MM/YY',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _cvvController,
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    hintText: '123',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          TextField(
            controller: _cardNameController,
            decoration: InputDecoration(
              labelText: 'اسم حامل البطاقة',
              hintText: 'كما هو مدون على البطاقة',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: CustomButton(
        text: 'ادفع الآن',
        onPressed: () {
          _processPayment();
        },
        backgroundColor: Color(0xFFd69e2e),
        textColor: Color(0xFF1a365d),
      ),
    );
  }

  void _processPayment() {
    // محاكاة عملية الدفع
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color(0xFFd69e2e),
            ),
            SizedBox(height: 16),
            Text('جاري معالجة الدفع...'),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    // محاكاة الانتظار ثم الانتقال إلى صفحة التأكيد
    Future.delayed(Duration(seconds: 2), () {
      Get.back();
      Get.toNamed(AppRoutes.CONFIRMATION);
    });
  }
}