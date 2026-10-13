import 'package:flutter/material.dart';
import '../app_theme.dart';

class ProgressStatBar extends StatelessWidget {
  final double current;
  final double target;
  final String? label;
  final String labelCurrent;
  final String labelTarget;
  final Color progressColor;
  final double height;

  const ProgressStatBar({
    super.key,
    required this.current,
    required this.target,
    this.label,
    this.labelCurrent = 'Recaudado',
    this.labelTarget = 'Meta',
    this.progressColor = AppTheme.pineGreen,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    final progress = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
    final pct = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textMuted,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13),
                children: [
                  TextSpan(
                    text: '\$${current.toStringAsFixed(0)} ',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  TextSpan(
                    text: 'de \$${target.toStringAsFixed(0)}',
                    style: const TextStyle(color: AppTheme.textMuted),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: progressColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$pct%',
                style: TextStyle(
                  color: progressColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: Stack(
            children: [
              Container(
                height: height,
                width: double.infinity,
                color: AppTheme.borderLight,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                    height: height,
                    width: constraints.maxWidth * progress,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          progressColor.withValues(alpha: 0.8),
                          progressColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(height / 2),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
