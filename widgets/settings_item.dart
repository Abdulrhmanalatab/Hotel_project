import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget? trailing;
  final VoidCallback? onTap;
  final ThemeData? theme;

  const SettingsItem({
    Key? key,
    required this.title,
    required this.description,
    this.trailing,
    this.onTap,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = theme ?? Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: themeData.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeData.hintColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      color: themeData.hintColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}