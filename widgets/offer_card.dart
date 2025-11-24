import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OfferCard extends StatelessWidget {
  final Map<String, dynamic> offer;
  final VoidCallback onBook;
  final VoidCallback onFavorite;
  final ThemeData? theme;

  const OfferCard({
    Key? key,
    required this.offer,
    required this.onBook,
    required this.onFavorite,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = theme ?? Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: themeData.cardColor,
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
          // رأس البطاقة مع الصورة
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: offer['image'],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: isRTL ? 10 : null,
                left: isRTL ? null : 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFd69e2e),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'خصم ${offer['discount']}',
                    style: themeData.textTheme.labelSmall?.copyWith(
                      color: Color(0xFF1a365d),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // محتوى البطاقة
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer['title'],
                  style: themeData.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: themeData.primaryColor,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on, 
                      size: 14, 
                      color: themeData.primaryColor
                    ),
                    SizedBox(width: 4),
                    Text(
                      offer['location'],
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        color: themeData.hintColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today, 
                      size: 14, 
                      color: themeData.hintColor
                    ),
                    SizedBox(width: 4),
                    Text(
                      offer['validUntil'],
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        color: themeData.hintColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '${offer['originalPrice']} ريال',
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: themeData.hintColor,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${offer['discountedPrice']} ريال',
                      style: themeData.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeData.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // الأزرار
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFd69e2e),
                      foregroundColor: themeData.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'احجز هذا العرض',
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: 50,
                  child: OutlinedButton(
                    onPressed: onFavorite,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Color(0xFFd69e2e)),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xFFd69e2e),
                      size: themeData.iconTheme.size,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}