import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entity/analytics_entity.dart';

class TopMerchantsList extends StatelessWidget {
  final List<TopMerchant> merchants;

  const TopMerchantsList({super.key, required this.merchants});

  @override
  Widget build(BuildContext context) {
    if (merchants.isEmpty) {
      return Center(
        child: Text(
          'No hay proveedores para mostrar',
          style: AppTypography.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: merchants.length,
      itemBuilder: (context, index) {
        final merchant = merchants[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryLight,
            child: Text(
              merchant.name.substring(0, 1).toUpperCase(),
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          title: Text(merchant.name, style: AppTypography.titleMedium),
          subtitle: Text(
            '${merchant.category} • ${merchant.invoiceCount} facturas',
            style: AppTypography.labelMedium,
          ),
          trailing: Text(
            '\$${merchant.amount.toStringAsFixed(2)}',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        );
      },
    );
  }
}
