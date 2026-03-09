import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Displays a small coloured chip indicating the confidence level of an
/// extracted field.
///
/// - >= 0.80 → green (high confidence)
/// - >= 0.50 → amber (medium confidence)
/// - <  0.50 → red   (low confidence)
/// - null     → grey  (no confidence data)
class ConfidenceIndicator extends StatelessWidget {
  final double? confidence;
  final String? label;

  /// When true the chip is rendered in a compact inline size (no label text).
  final bool compact;

  const ConfidenceIndicator({
    super.key,
    required this.confidence,
    this.label,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final conf = confidence;

    final (Color bg, Color fg, IconData icon) = conf == null
        ? (AppColors.divider, AppColors.textTertiary, Icons.help_outline)
        : conf >= 0.80
        ? (AppColors.secondaryLight, AppColors.secondary, Icons.check_circle)
        : conf >= 0.50
        ? (
            AppColors.warningLight,
            AppColors.warning,
            Icons.warning_amber_rounded,
          )
        : (AppColors.errorLight, AppColors.error, Icons.error_outline);

    final pctText = conf != null ? '${(conf * 100).round()}%' : '–';

    if (compact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 3),
            Text(
              pctText,
              style: AppTypography.caption.copyWith(
                color: fg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          if (label != null) ...[
            Text(label!, style: AppTypography.caption.copyWith(color: fg)),
            const SizedBox(width: 4),
          ],
          Text(
            pctText,
            style: AppTypography.caption.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
