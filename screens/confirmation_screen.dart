import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/routes/app_routes.dart';
import 'package:des/widgets/custom_button.dart';

class ConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> bookingDetails = {
    'bookingNumber': 'YM20231015',
    'hotelName': 'فندق تاج سبأ',
    'roomType': 'غرفة ديلوكس',
    'checkIn': '15 أكتوبر 2023',
    'checkOut': '19 أكتوبر 2023',
    'nights': '4',
    'guests': '2 بالغين',
    'totalAmount': '305,000',
    'paymentMethod': 'بطاقة ائتمان',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // شريط التقدم
              _buildProgressBar(),
              SizedBox(height: 40),

              // أيقونة النجاح
              _buildSuccessIcon(),
              SizedBox(height: 24),

              // رسالة التأكيد
              _buildConfirmationMessage(),
              SizedBox(height: 32),

              // تفاصيل الحجز
              _buildBookingDetails(),
              SizedBox(height: 32),

              // أزرار الإجراءات
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
        children: [
          _buildProgressStep(
            number: '1',
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
            isCompleted: true,
          ),
          Expanded(
            child: Divider(
              color: Colors.green,
              thickness: 2,
            ),
          ),
          _buildProgressStep(
            number: '3',
            label: 'التأكيد',
            isCompleted: true,
            isActive: true,
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
            color: isCompleted || isActive ? Colors.green : Colors.grey[300],
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
            color: isActive ? Colors.green : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 60,
      ),
    );
  }

  Widget _buildConfirmationMessage() {
    return Column(
      children: [
        Text(
          'تم تأكيد حجزك!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'سيتم إرسال تفاصيل الحجز إلى بريدك الإلكتروني ورقم هاتفك',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingDetails() {
    return Container(
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
        children: [
          _buildDetailRow('رقم الحجز:', bookingDetails['bookingNumber']),
          _buildDetailRow('الفندق:', bookingDetails['hotelName']),
          _buildDetailRow('نوع الغرفة:', bookingDetails['roomType']),
          _buildDetailRow('تاريخ الوصول:', bookingDetails['checkIn']),
          _buildDetailRow('تاريخ المغادرة:', bookingDetails['checkOut']),
          _buildDetailRow('مدة الإقامة:', '${bookingDetails['nights']} ليالي'),
          _buildDetailRow('عدد الضيوف:', bookingDetails['guests']),
          _buildDetailRow('طريقة الدفع:', bookingDetails['paymentMethod']),
          Divider(height: 24),
          _buildDetailRow(
            'المبلغ المدفوع:',
            '${bookingDetails['totalAmount']} ريال',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              color: Colors.grey[600],
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

  Widget _buildActionButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'عرض تفاصيل الحجز',
          onPressed: () {
            Get.toNamed(AppRoutes.BOOKING_DETAILS, arguments: bookingDetails);
          },
          backgroundColor: Color(0xFF1a365d),
          textColor: Colors.white,
        ),
        SizedBox(height: 12),
        CustomButton(
          text: 'العودة إلى الرئيسية',
          onPressed: () {
            Get.offAllNamed(AppRoutes.HOME);
          },
          backgroundColor: Colors.transparent,
          textColor: Color(0xFFd69e2e),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.share, color: Color(0xFF1a365d)),
              onPressed: _shareBooking,
            ),
            IconButton(
              icon: Icon(Icons.print, color: Color(0xFF1a365d)),
              onPressed: _printBooking,
            ),
            IconButton(
              icon: Icon(Icons.download, color: Color(0xFF1a365d)),
              onPressed: _downloadBooking,
            ),
          ],
        ),
      ],
    );
  }

  void _shareBooking() {
    Get.snackbar(
      'مشاركة الحجز',
      'تم نسخ رابط الحجز إلى الحافظة',
      backgroundColor: Color(0xFFd69e2e),
      colorText: Color(0xFF1a365d),
    );
  }

  void _printBooking() {
    Get.snackbar(
      'طباعة الحجز',
      'جاري تحضير الحجز للطباعة...',
      backgroundColor: Color(0xFFd69e2e),
      colorText: Color(0xFF1a365d),
    );
  }

  void _downloadBooking() {
    Get.snackbar(
      'تحميل الحجز',
      'تم بدء تحميل وثيقة الحجز',
      backgroundColor: Color(0xFFd69e2e),
      colorText: Color(0xFF1a365d),
    );
  }
}