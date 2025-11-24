import 'package:flutter/material.dart';

class ContactMethod extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;
  final double? iconSize;
  final ThemeData? theme;

  const ContactMethod({
    Key? key,
    required this.icon,
    required this.title,
    required this.info,
    this.iconSize,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = theme ?? Theme.of(context);
    final double size = iconSize ?? themeData.iconTheme.size ?? 24.0;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: themeData.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon, 
            color: themeData.primaryColor,
            size: size,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: themeData.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: themeData.hintColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                info,
                style: themeData.textTheme.bodySmall?.copyWith(
                  color: themeData.hintColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}