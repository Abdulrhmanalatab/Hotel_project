import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/contact_method.dart';
import '../widgets/menu_item.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'المساعدة والدعم',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: theme.iconTheme.size,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // شريط البحث
            Container(
              padding: EdgeInsets.all(16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ابحث في المساعدة',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.hintColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'اكتب سؤالك هنا...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: theme.iconTheme.size,
                      ),
                    ),
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // قائمة المساعدة
            Container(
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
                  MenuItem(
                    icon: Icons.help,
                    title: 'كيفية الحجز',
                    onTap: () {
                      _showHelpDetails('كيفية الحجز', theme, isRTL);
                    },
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  MenuItem(
                    icon: Icons.credit_card,
                    title: 'طرق الدفع المتاحة',
                    onTap: () {
                      _showHelpDetails('طرق الدفع المتاحة', theme, isRTL);
                    },
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  MenuItem(
                    icon: Icons.swap_horiz,
                    title: 'إلغاء أو تعديل الحجز',
                    onTap: () {
                      _showHelpDetails('إلغاء أو تعديل الحجز', theme, isRTL);
                    },
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  MenuItem(
                    icon: Icons.star,
                    title: 'كيفية التقييم',
                    onTap: () {
                      _showHelpDetails('كيفية التقييم', theme, isRTL);
                    },
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  MenuItem(
                    icon: Icons.person_add,
                    title: 'إنشاء حساب جديد',
                    onTap: () {
                      _showHelpDetails('إنشاء حساب جديد', theme, isRTL);
                    },
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  MenuItem(
                    icon: Icons.lock,
                    title: 'استعادة كلمة المرور',
                    onTap: () {
                      _showHelpDetails('استعادة كلمة المرور', theme, isRTL);
                    },
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // اتصل بنا
            Container(
              padding: EdgeInsets.all(16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اتصل بنا',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  ContactMethod(
                    icon: Icons.phone,
                    title: 'الهاتف',
                    info: '+967 1 234 567',
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  SizedBox(height: 12),
                  ContactMethod(
                    icon: Icons.email,
                    title: 'البريد الإلكتروني',
                    info: 'support@yemenstay.com',
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                  SizedBox(height: 12),
                  ContactMethod(
                    icon: Icons.chat,
                    title: 'الدردشة الحية',
                    info: 'متاحة 24/7',
                    iconSize: theme.iconTheme.size,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDetails(String title, ThemeData theme, bool isRTL) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: theme.iconTheme.size,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _getHelpContent(title),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: theme.hintColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getHelpContent(String title) {
    switch (title) {
      case 'كيفية الحجز':
        return '''
لحجز فندق في YemenStay، اتبع الخطوات التالية:

1. ابحث عن الفندق المناسب باستخدام شريط البحث في الصفحة الرئيسية
2. اختر تاريخ الوصول والمغادرة
3. حدد عدد الغرف والضيوف
4. اضغط على "احجز الآن"
5. املأ معلومات الحجز
6. اختر طريقة الدفع المناسبة
7. تأكيد الحجز

سيصلك تأكيد الحجز على بريدك الإلكتروني ورقم هاتفك.''';

      case 'طرق الدفع المتاحة':
        return '''
نوفر عدة طرق دفع مريحة وآمنة:

• البطاقات الائتمانية (فيزا، ماستركارد)
• المحافظ الإلكترونية (STC Pay، شبكة)
• التحويل البنكي المباشر
• الدفع عند الوصول (في بعض الفنادق)

جميع عمليات الدفع مشفرة وآمنة بنسبة 100%.''';

      case 'إلغاء أو تعديل الحجز':
        return '''
لإلغاء أو تعديل الحجز:

1. انتقل إلى قسم "حجوزاتي"
2. اختر الحجز الذي تريد تعديله
3. اضغط على "تعديل الحجز" أو "إلغاء الحجز"
4. اتبع التعليمات الظاهرة

ملاحظات مهمة:
• يمكن الإلغاء مجاناً قبل 24 ساعة من الوصول
• بعد هذا الوقت قد تطبق رسوم إلغاء
• بعض العروض غير قابلة للإلغاء أو التعديل''';

      case 'كيفية التقييم':
        return '''
لتقييم تجربتك في الفندق:

1. بعد انتهاء إقامتك، ستتلقى رسالة طلب التقييم
2. اضغط على الرابط في الرسالة
3. قيم الفندق من 1 إلى 5 نجوم
4. اكتب تعليقاً عن تجربتك (اختياري)
5. اضغط على "إرسال التقييم"

تقييماتك تساعد المسافرين الآخرين في اختيار الفنادق المناسبة.''';

      case 'إنشاء حساب جديد':
        return '''
لإنشاء حساب جديد في YemenStay:

1. اضغط على "إنشاء حساب جديد" من صفحة تسجيل الدخول
2. املأ المعلومات المطلوبة (الاسم، البريد الإلكتروني، كلمة المرور)
3. اضغط على "إنشاء حساب"
4. تحقق من بريدك الإلكتروني لتفعيل الحساب
5. يمكنك الآن تسجيل الدخول والاستفادة من جميع المزايا

مزايا الحساب:
• حفظ معلومات الحجز
• الوصول إلى العروض الحصرية
• إدارة الحجوزات بسهولة''';

      case 'استعادة كلمة المرور':
        return '''
إذا نسيت كلمة المرور:

1. اضغط على "نسيت كلمة المرور" في صفحة تسجيل الدخول
2. أدخل بريدك الإلكتروني المسجل
3. اضغط على "إرسال رابط الاستعادة"
4. تحقق من بريدك الإلكتروني واضغط على الرابط المرسل
5. أدخل كلمة المرور الجديدة
6. تأكيد كلمة المرور الجديدة

يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة.''';

      default:
        return 'محتويات المساعدة ستظهر هنا...';
    }
  }
}