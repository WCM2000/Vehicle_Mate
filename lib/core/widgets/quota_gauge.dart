import 'package:flutter/material.dart';

import '../app_theme.dart';

/// Circular fuel-quota gauge matching the Fuel IQ Dark design: a dark
/// track with a glowing neon-green arc and a centered litres readout.
class QuotaGauge extends StatelessWidget {
  const QuotaGauge({
    super.key,
    required this.remaining,
    required this.weekly,
    this.size = 112,
    this.strokeWidth = 10,
  });

  final double remaining;
  final double weekly;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final fraction = weekly <= 0 ? 0.0 : (remaining / weekly).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonGreen.withValues(alpha: 0.35),
                    blurRadius: 14,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: CircularProgressIndicator(
                value: fraction,
                strokeWidth: strokeWidth,
                strokeCap: StrokeCap.round,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                remaining.toStringAsFixed(1),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'LITRES',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.neonGreen,
                      letterSpacing: 1,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
