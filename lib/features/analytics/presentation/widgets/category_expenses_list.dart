import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entity/analytics_entity.dart';

class CategoryExpensesList extends StatelessWidget {
  final List<CategoryExpense> categories;

  const CategoryExpensesList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      children: categories.map((cat) {
        final index = categories.indexOf(cat);
        final colors = [
          AppColors.primary,
          const Color(0xFF009688), // Teal from Stitch
          const Color(0xFF5C6BC0), // Indigo-ish from Stitch
        ];
        final color = colors[index % colors.length];

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    cat.category,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Text(
                '${(cat.percentage * 100).toStringAsFixed(0)}%',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
