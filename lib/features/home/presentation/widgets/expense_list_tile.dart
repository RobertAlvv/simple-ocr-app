import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entity/expense_entity.dart';

class ExpenseListTile extends StatelessWidget {
  final ExpenseEntity expense;

  const ExpenseListTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy');
    final isPending = expense.status?.toLowerCase() == 'pending';

    return InkWell(
      onTap: () {
        context.router.push(InvoiceDetailRoute(invoiceId: expense.id));
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFF1F5F9)), // slate-100
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(expense.merchantName),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                _getCategoryIcon(expense.merchantName),
                color: _getIconColor(expense.merchantName),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.merchantName,
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dateFormat.format(expense.date),
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  isPending ? 'Pendiente' : 'Aprobado',
                  style: AppTypography.caption.copyWith(
                    color: isPending
                        ? const Color(0xFFD97706)
                        : const Color(0xFF16A34A), // amber-600 / green-600
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String merchant) {
    if (merchant.toLowerCase().contains('office')) return Icons.storefront;
    if (merchant.toLowerCase().contains('tech')) return Icons.computer;
    if (merchant.toLowerCase().contains('cafe') ||
        merchant.toLowerCase().contains('coffee')) {
      return Icons.local_cafe;
    }
    if (merchant.toLowerCase().contains('airline') ||
        merchant.toLowerCase().contains('flight')) {
      return Icons.flight;
    }
    return Icons.receipt_long;
  }

  Color _getIconBackgroundColor(String merchant) {
    if (merchant.toLowerCase().contains('office')) {
      return const Color(0xFFDBEAFE); // blue-100
    }
    if (merchant.toLowerCase().contains('tech')) {
      return const Color(0xFFF3E8FF); // purple-100
    }
    if (merchant.toLowerCase().contains('cafe') ||
        merchant.toLowerCase().contains('coffee')) {
      return const Color(0xFFFFEDD5); // orange-100
    }
    if (merchant.toLowerCase().contains('airline') ||
        merchant.toLowerCase().contains('flight')) {
      return const Color(0xFFD1FAE5); // emerald-100
    }
    return AppColors.primaryLight;
  }

  Color _getIconColor(String merchant) {
    if (merchant.toLowerCase().contains('office')) {
      return const Color(0xFF2563EB); // blue-600
    }
    if (merchant.toLowerCase().contains('tech')) {
      return const Color(0xFF9333EA); // purple-600
    }
    if (merchant.toLowerCase().contains('cafe') ||
        merchant.toLowerCase().contains('coffee')) {
      return const Color(0xFFEA580C); // orange-600
    }
    if (merchant.toLowerCase().contains('airline') ||
        merchant.toLowerCase().contains('flight')) {
      return const Color(0xFF059669); // emerald-600
    }
    return AppColors.primary;
  }
}
