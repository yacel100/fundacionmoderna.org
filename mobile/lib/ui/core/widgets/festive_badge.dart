import 'package:flutter/material.dart';

class FestiveBadge extends StatelessWidget {
  final String text;
  final Color? color;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const FestiveBadge({
    super.key,
    required this.text,
    this.color,
    this.backgroundColor = const Color(0xFFF0FDF4),
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bg = color ?? backgroundColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
