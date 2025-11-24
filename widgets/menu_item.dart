import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final bool showTrailingArrow;
  final bool showDivider;
  final VoidCallback? onTap;
  final String? routeName;
  final Object? arguments;
  final double? iconSize;
  final ThemeData? theme;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.textColor,
    this.backgroundColor,
    this.showTrailingArrow = true,
    this.showDivider = true,
    this.onTap,
    this.routeName,
    this.arguments,
    this.iconSize,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = theme ?? Theme.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final double size = iconSize ?? themeData.iconTheme.size ?? 24.0;
    final Color effectiveIconColor = iconColor ?? themeData.primaryColor;
    final Color effectiveTextColor = textColor ?? themeData.primaryColor;
    final Color effectiveBackgroundColor = backgroundColor ?? themeData.cardColor;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap ?? () {
                if (routeName != null) {
                  if (arguments != null) {
                    Get.toNamed(routeName!, arguments: arguments);
                  } else {
                    Get.toNamed(routeName!);
                  }
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    // أيقونة
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: effectiveIconColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: effectiveIconColor,
                        size: size * 0.8,
                      ),
                    ),
                    SizedBox(width: 12),
                    
                    // النص
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: themeData.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: effectiveTextColor,
                            ),
                          ),
                          if (subtitle != null) ...[
                            SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: themeData.textTheme.bodySmall?.copyWith(
                                color: themeData.hintColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    
                    // سهم التنقل (اختياري)
                    if (showTrailingArrow) ...[
                      Icon(
                        isRTL ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                        size: 16,
                        color: themeData.hintColor,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // خط فاصل (اختياري)
        if (showDivider) ...[
          const SizedBox(height: 8),
          Divider(
            height: 1,
            color: themeData.dividerColor.withOpacity(0.3),
          ),
          SizedBox(height: 8),
        ] else 
         SizedBox(height: 8),
        ],
      
    );
  }
}

// نسخة معدلة من MenuItem للاستخدام في الشبكات (Grid)
class MenuItemGrid extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final String? routeName;
  final Object? arguments;
  final double? iconSize;
  final ThemeData? theme;

  const MenuItemGrid({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.textColor,
    this.backgroundColor,
    this.onTap,
    this.routeName,
    this.arguments,
    this.iconSize,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = theme ?? Theme.of(context);
    final double size = iconSize ?? themeData.iconTheme.size ?? 24.0;
    final Color effectiveIconColor = iconColor ?? themeData.primaryColor;
    final Color effectiveTextColor = textColor ?? themeData.primaryColor;
    final Color effectiveBackgroundColor = backgroundColor ?? themeData.cardColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () {
          if (routeName != null) {
            if (arguments != null) {
              Get.toNamed(routeName!, arguments: arguments);
            } else {
              Get.toNamed(routeName!);
            }
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: effectiveIconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: effectiveIconColor,
                  size: size * 0.8,
                ),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: themeData.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: effectiveTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: themeData.textTheme.bodySmall?.copyWith(
                    color: themeData.hintColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}