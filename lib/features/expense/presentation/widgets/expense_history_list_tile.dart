import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entity/expense_entity.dart';

class ExpenseHistoryListTile extends StatelessWidget {
  final ExpenseEntity expense;

  const ExpenseHistoryListTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy');
    final isPending = expense.status?.toLowerCase() == 'pending';

    return InkWell(
      onTap: () {
        context.router.push(InvoiceDetailRoute(invoiceId: expense.id));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: Color(0xFFF1F5F9)), // slate-100
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(expense.merchantName),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                _getCategoryIcon(expense.merchantName),
                color: _getIconColor(expense.merchantName),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    expense.merchantName,
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateFormat.format(expense.date),
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isPending
                        ? const Color(0xFFFEF3C7)
                        : const Color(0xFFD1FAE5), // amber-100 : emerald-100
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isPending ? 'Pendiente' : 'Procesado',
                    style: AppTypography.caption.copyWith(
                      color: isPending
                          ? const Color(0xFFD97706)
                          : const Color(0xFF059669), // amber-600 : emerald-600
                      fontWeight: FontWeight.w500,
                    ),
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
    if (merchant.toLowerCase().contains('tech') ||
        merchant.toLowerCase().contains('apple')) {
      return Icons.computer;
    }
    if (merchant.toLowerCase().contains('cafe') ||
        merchant.toLowerCase().contains('coffee')) {
      return Icons.local_cafe;
    }
    if (merchant.toLowerCase().contains('airline') ||
        merchant.toLowerCase().contains('hotel')) {
      return Icons.flight;
    }
    return Icons.receipt_long;
  }

  Color _getIconBackgroundColor(String merchant) {
    return const Color(0xFFE2E8F0); // slate-200, matching HTML default icon box
  }

  Color _getIconColor(String merchant) {
    return const Color(0xFF94A3B8); // slate-400
  }
}
