import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:des/widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  // بيانات وهمية للإشعارات
  final List<Map<String, dynamic>> notifications = [
    {
      'icon': Icons.card_giftcard,
      'title': 'عرض خاص جديد!',
      'description': 'خصم 25% على جميع الفنادق في صنعاء لمدة محدودة',
      'time': 'منذ ساعتين',
      'isUnread': true,
    },
    {
      'icon': Icons.calendar_today,
      'title': 'تم تأكيد حجزك',
      'description': 'تم تأكيد حجزك في فندق تاج سبأ من 15 إلى 19 أكتوبر',
      'time': 'منذ يومين',
      'isUnread': false,
    },
    {
      'icon': Icons.star,
      'title': 'قم بتقييم إقامتك',
      'description': 'كيف كانت تجربتك في فندق شيراتون عدن؟ شاركنا برأيك',
      'time': 'منذ أسبوع',
      'isUnread': false,
    },
    {
      'icon': Icons.notifications,
      'title': 'ترقية الحساب',
      'description': 'أنت مؤهل الآن للحصول على خصومات حصرية كعضو متميز',
      'time': 'منذ أسبوعين',
      'isUnread': false,
    },
    {
      'icon': Icons.comment,
      'title': 'رد على تعليقك',
      'description': 'قام فندق تاج سبأ بالرد على تعليقك حول الخدمة',
      'time': 'منذ 3 أسابيع',
      'isUnread': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('الإشعارات'),
        backgroundColor: Color(0xFF1a365d),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: _showDeleteDialog,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationItem(
            notification: notifications[index],
          );
        },
      ),
    );
  }

  void _showDeleteDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('مسح الإشعارات'),
        content: Text('هل أنت متأكد من رغبتك في مسح جميع الإشعارات؟\nلا يمكن التراجع عن هذا الإجراء.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // إضافة منطق مسح الإشعارات هنا
            },
            child: Text('مسح الكل'),
          ),
        ],
      ),
    );
  }
}