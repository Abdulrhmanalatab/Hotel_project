import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  // بيانات وهمية للإشعارات
  final List<Map<String, dynamic>> notifications = [
    {
      'id': '1',
      'title': 'حجز جديد',
      'message': 'تم تأكيد حجزك في فندق تاج سبأ',
      'time': 'قبل 5 دقائق',
      'icon': Icons.check_circle,
      'iconColor': Colors.green,
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'عرض خاص',
      'message': 'خصم 20% على جميع الفنادق في صنعاء هذا الأسبوع',
      'time': 'قبل ساعة',
      'icon': Icons.local_offer,
      'iconColor': Colors.orange,
      'isRead': true,
    },
    {
      'id': '3',
      'title': 'تذكير',
      'message': 'حجزك في فندق شيراتون عدن يبدأ بعد 3 أيام',
      'time': 'قبل 3 ساعات',
      'icon': Icons.calendar_today,
      'iconColor': Colors.blue,
      'isRead': true,
    },
    {
      'id': '4',
      'title': 'ترقية',
      'message': 'تهانينا! لقد وصلت إلى المستوى الذهبي',
      'time': 'قبل يوم',
      'icon': Icons.workspace_premium,
      'iconColor': Colors.amber,
      'isRead': true,
    },
    {
      'id': '5',
      'title': 'تقييم',
      'message': 'كيف كانت تجربتك في فندق تعز الجبلي؟',
      'time': 'قبل يومين',
      'icon': Icons.star,
      'iconColor': Colors.purple,
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          'الإشعارات',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            isRTL ? Icons.arrow_forward : Icons.arrow_back,
            color: Colors.white,
            size: theme.iconTheme.size,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _markAllAsRead();
            },
            child: Text(
              'تعليم الكل كمقروء',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.white,
          size: theme.iconTheme.size,
        ),
      ),
      body: notifications.isEmpty ? _buildEmptyState(theme) : _buildNotificationsList(theme),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 80,
            color: theme.hintColor.withOpacity(0.5),
          ),
          SizedBox(height: 20),
          Text(
            'لا توجد إشعارات',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'سيظهر هنا جميع الإشعارات الخاصة بحسابك',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(ThemeData theme) {
    return Column(
      children: [
        // إحصائيات سريعة
        Container(
          padding: EdgeInsets.all(16),
          color: theme.cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNotificationStat('غير مقروء', '2', theme),
              _buildNotificationStat('الإجمالي', '5', theme),
              _buildNotificationStat('هذا الشهر', '8', theme),
            ],
          ),
        ),
        SizedBox(height: 8),
        // قائمة الإشعارات
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return _buildNotificationItem(notification, theme);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationStat(String title, String value, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.hintColor,
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification, ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification['isRead'] ? theme.cardColor : theme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification['isRead'] ? Colors.transparent : theme.primaryColor.withOpacity(0.1),
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: notification['iconColor'].withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification['icon'],
            color: notification['iconColor'],
            size: theme.iconTheme.size != null ? theme.iconTheme.size! * 0.8 : 20,
          ),
        ),
        title: Text(
          notification['title'],
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: notification['isRead'] ? theme.primaryColor : theme.primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification['message'],
              style: theme.textTheme.bodySmall?.copyWith(
                color: notification['isRead'] ? theme.hintColor : theme.primaryColor.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 4),
            Text(
              notification['time'],
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: !notification['isRead']
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () {
          _markAsRead(notification['id']);
        },
      ),
    );
  }

  void _markAsRead(String id) {
    // تحديث حالة الإشعار كمقروء
  }

  void _markAllAsRead() {
    // تعليم جميع الإشعارات كمقروءة
  }
}