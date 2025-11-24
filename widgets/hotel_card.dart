import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final VoidCallback onDetails;
  final VoidCallback onBook;
  final ThemeData? theme;

  const HotelCard({
    Key? key,
    required this.hotel,
    required this.onDetails,
    required this.onBook,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = theme ?? Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
          // رأس البطاقة
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة الفندق
                Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.only(
                      left: isRTL ? 12 : 0,
                      right: isRTL ? 0 : 12
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: hotel['image'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.hotel,
                          size: themeData.iconTheme.size,
                        ),
                      ),
                    ),
                  ),
                ),

                // معلومات الفندق
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel['name'],
                        style: themeData.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: themeData.primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                              Icons.location_on,
                              size: 14,
                              color: themeData.primaryColor
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              hotel['location'],
                              style: themeData.textTheme.bodyMedium?.copyWith(
                                color: themeData.hintColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          _buildRatingStars(hotel['rating'], themeData),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${hotel['rating']} (${hotel['reviews']} تقييم)',
                              style: themeData.textTheme.bodySmall?.copyWith(
                                color: themeData.hintColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // السعر
                Container(
                  constraints: BoxConstraints(
                    minWidth: 70, // الحد الأدنى للعرض
                    maxWidth: 100, // الحد الأقصى للعرض
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${hotel['price']} ريال',
                        style: themeData.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: themeData.primaryColor,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'لليلة الواحدة',
                        style: themeData.textTheme.bodySmall?.copyWith(
                          color: themeData.hintColor,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // الميزات
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: themeData.dividerColor.withOpacity(0.1),
            child: Wrap(
              spacing: 12, // تقليل المسافة بين العناصر
              runSpacing: 8,
              children: hotel['features'].map<Widget>((feature) {
                return Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.4, // تحديد أقصى عرض
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                          Icons.check_circle,
                          size: 14,
                          color: themeData.primaryColor
                      ),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          feature,
                          style: themeData.textTheme.bodySmall?.copyWith(
                            color: themeData.hintColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // الأزرار
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDetails,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Color(0xFFd69e2e)),
                    ),
                    child: Text(
                      'عرض التفاصيل',
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        color: Color(0xFFd69e2e),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
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
                      'احجز الآن',
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildRatingStars(double rating, ThemeData theme) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) > 0;

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(
          Icons.star,
          size: 14,
          color: Color(0xFFd69e2e)
      ));
    }
    if (hasHalfStar) {
      stars.add(Icon(
          Icons.star_half,
          size: 14,
          color: Color(0xFFd69e2e)
      ));
    }
    for (int i = stars.length; i < 5; i++) {
      stars.add(Icon(
          Icons.star_border,
          size: 14,
          color: Color(0xFFd69e2e)
      ));
    }

    return Row(children: stars);
  }
}