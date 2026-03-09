import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/confidence_indicator.dart';
import '../bloc/invoice_bloc.dart';

class InvoiceDetailView extends StatelessWidget {
  const InvoiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Factura', style: AppTypography.headlineMedium),
      ),
      body: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (invoice) {
              final dateFormat = DateFormat('dd MMM, yyyy');
              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Image placeholder ──────────────────────
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.divider),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://via.placeholder.com/400x200?text=Invoice+Image',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // ── Merchant name ──────────────────────────
                    Text(
                      invoice.merchantName ?? 'Desconocido',
                      style: AppTypography.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      invoice.date != null
                          ? dateFormat.format(invoice.date!)
                          : 'Fecha no disponible',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    // ── OCR confidence chip ────────────────────
                    if (invoice.ocrConfidenceAvg != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          ConfidenceIndicator(
                            confidence: invoice.ocrConfidenceAvg,
                            label: 'Confianza OCR',
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: AppSpacing.lg),
                    const Divider(),
                    const SizedBox(height: AppSpacing.lg),

                    // ── RNC + NCF ──────────────────────────────
                    if (invoice.rnc != null)
                      _buildDetailRow(
                        'RNC',
                        invoice.rnc!,
                        trailing: invoice.rncValid == true
                            ? const Icon(
                                Icons.verified,
                                color: AppColors.secondary,
                                size: 16,
                              )
                            : invoice.rncValid == false
                            ? const Icon(
                                Icons.cancel,
                                color: AppColors.error,
                                size: 16,
                              )
                            : null,
                      ),
                    if (invoice.numeroComprobante != null)
                      _buildDetailRow('NCF', invoice.numeroComprobante!),

                    // ── Category & Status ──────────────────────
                    _buildDetailRow(
                      'Categoría',
                      invoice.category ?? 'N/A',
                      isChip: true,
                    ),
                    _buildDetailRow(
                      'Estado',
                      invoice.status,
                      valueColor: invoice.status == 'Processed'
                          ? AppColors.secondary
                          : AppColors.warning,
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // ── Amounts breakdown ──────────────────────
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          if (invoice.subtotal != null)
                            _buildAmountRow(
                              'Subtotal',
                              invoice.subtotal!,
                              confidence: invoice.confidenceFor('subtotal'),
                            ),
                          if (invoice.tax != null)
                            _buildAmountRow(
                              'ITBIS',
                              invoice.tax!,
                              confidence: invoice.confidenceFor('impuesto'),
                            ),
                          if (invoice.subtotal != null || invoice.tax != null)
                            const Divider(height: 24),
                          _buildAmountRow(
                            'Total',
                            invoice.total ?? invoice.amount ?? 0,
                            isTotal: true,
                            confidence: invoice.confidenceFor('total'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (msg, kind) => Center(child: Text('Error: $msg')),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    bool isChip = false,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.titleMedium),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isChip)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Text(value, style: AppTypography.labelMedium),
                )
              else
                Text(
                  value,
                  style: AppTypography.titleMedium.copyWith(color: valueColor),
                ),
              if (trailing != null) ...[const SizedBox(width: 6), trailing],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(
    String label,
    double amount, {
    bool isTotal = false,
    double? confidence,
  }) {
    final style = isTotal
        ? AppTypography.titleLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          )
        : AppTypography.bodyLarge;
    final labelStyle = isTotal
        ? AppTypography.titleLarge
        : AppTypography.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('RD\$ ${amount.toStringAsFixed(2)}', style: style),
              if (confidence != null) ...[
                const SizedBox(width: 8),
                ConfidenceIndicator(confidence: confidence, compact: true),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
