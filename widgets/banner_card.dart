import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final double? iconSize;
  final ThemeData? theme;

  const BannerCard({
    Key? key,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    this.iconSize,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = theme ?? Theme.of(context);
    final double size = iconSize ?? themeData.iconTheme.size ?? 24.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [backgroundColor.withOpacity(0.9), backgroundColor],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, 
            color: textColor,
            size: size,
          ),
          SizedBox(width: 8),
          Text(
            message,
            style: themeData.textTheme.bodyLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}