import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// A collapsible banner that displays a list of extraction warnings.
///
/// Renders nothing if the list is empty.
class WarningsBanner extends StatefulWidget {
  final List<String> warnings;

  const WarningsBanner({super.key, required this.warnings});

  @override
  State<WarningsBanner> createState() => _WarningsBannerState();
}

class _WarningsBannerState extends State<WarningsBanner> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.warnings.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColors.warning,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${widget.warnings.length} advertencia${widget.warnings.length > 1 ? 's' : ''} de extracción',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.warning,
                  size: 20,
                ),
              ],
            ),
          ),
          if (_expanded) ...[
            const SizedBox(height: 8),
            ...widget.warnings.map(
              (w) => Padding(
                padding: const EdgeInsets.only(left: 26, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: AppTypography.caption),
                    Expanded(
                      child: Text(
                        w,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
