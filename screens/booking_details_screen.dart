import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/widgets/custom_button.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> bookingDetails = Get.arguments ??
      {
        'bookingNumber': 'YM20231015',
        'status': 'confirmed',
        'bookingDate': '10 أكتوبر 2023',
        'hotelName': 'فندق تاج سبأ',
        'location': 'صنعاء القديمة، اليمن',
        'phone': '+967 1 234 567',
        'checkIn': '15 أكتوبر 2023',
        'checkOut': '19 أكتوبر 2023',
        'nights': '4',
        'guests': '2 بالغين',
        'roomType': 'غرفة ديلوكس',
        'roomPrice': '300,000',
        'taxes': '20,000',
        'discount': '15,000',
        'totalAmount': '305,000',
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('تفاصيل الحجز'),
        backgroundColor: Color(0xFF1a365d),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // معلومات الحجز
            _buildBookingInfoCard(),
            SizedBox(height: 16),

            // معلومات الفندق
            _buildHotelInfoCard(),
            SizedBox(height: 16),

            // تفاصيل الدفع
            _buildPaymentDetailsCard(),
            SizedBox(height: 24),

            // أزرار الإجراءات
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingInfoCard() {
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
          _buildDetailRow('رقم الحجز:', bookingDetails['bookingNumber']),
          _buildDetailRowWithWidget('حالة الحجز:', _buildStatusBadge()),
          _buildDetailRow('تاريخ الحجز:', bookingDetails['bookingDate']),
        ],
      ),
    );
  }

  Widget _buildHotelInfoCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات الفندق',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 16),
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
                    'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&h=200&q=80',
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
                      bookingDetails['hotelName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1a365d),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 14, color: Color(0xFF1a365d)),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            bookingDetails['location'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 14, color: Color(0xFF1a365d)),
                        SizedBox(width: 4),
                        Text(
                          bookingDetails['phone'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildDetailRow('تاريخ الوصول:', bookingDetails['checkIn']),
          _buildDetailRow('تاريخ المغادرة:', bookingDetails['checkOut']),
          _buildDetailRow('مدة الإقامة:', bookingDetails['nights']),
          _buildDetailRow('عدد الضيوف:', bookingDetails['guests']),
          _buildDetailRow('نوع الغرفة:', bookingDetails['roomType']),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تفاصيل الدفع',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a365d),
            ),
          ),
          SizedBox(height: 16),
          _buildPaymentRow(
              'سعر الغرفة:', '${bookingDetails['roomPrice']} ريال'),
          _buildPaymentRow(
              'الضرائب والرسوم:', '${bookingDetails['taxes']} ريال'),
          _buildPaymentRow('الخصم:', '-${bookingDetails['discount']} ريال'),
          Divider(height: 24),
          _buildPaymentRow(
            'المبلغ الإجمالي:',
            '${bookingDetails['totalAmount']} ريال',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _showCancelDialog,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(color: Colors.red),
            ),
            child: Text(
              'إلغاء الحجز',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            text: 'تعديل الحجز',
            onPressed: () {
              Get.snackbar(
                'قريباً',
                'ميزة تعديل الحجز قيد التطوير',
                backgroundColor: Color(0xFFd69e2e),
                colorText: Color(0xFF1a365d),
              );
            },
            backgroundColor: Color(0xFFd69e2e),
            textColor: Color(0xFF1a365d),
          ),
        ),
      ],
    );
  }

  // FIXED: Single method for string values
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // NEW: Separate method for widget values
  Widget _buildDetailRowWithWidget(String label, Widget value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          value,
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isTotal = false}) {
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

  Widget _buildStatusBadge() {
    Color statusColor;
    String statusText;

    switch (bookingDetails['status']) {
      case 'confirmed':
        statusColor = Colors.green;
        statusText = 'مؤكدة';
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusText = 'قيد المراجعة';
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusText = 'ملغاة';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'غير معروف';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showCancelDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 8),
            Text('إلغاء الحجز'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'هل أنت متأكد من رغبتك في إلغاء حجزك في ${bookingDetails['hotelName']}؟',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'سيتم خصم 10% من المبلغ المدفوع كرسوم إلغاء.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _cancelBooking();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('تأكيد الإلغاء'),
          ),
        ],
      ),
    );
  }

  void _cancelBooking() {
    Get.snackbar(
      'تم الإلغاء',
      'تم إلغاء الحجز بنجاح',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // العودة للخلف بعد ثانيتين
    Future.delayed(Duration(seconds: 2), () {
      Get.back();
    });
  }
}