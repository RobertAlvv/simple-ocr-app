import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
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
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                    const SizedBox(height: 32),
                    Text(
                      invoice.merchantName ?? 'Desconocido',
                      style: AppTypography.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      invoice.date != null
                          ? dateFormat.format(invoice.date!)
                          : 'Fecha no disponible',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categoría', style: AppTypography.titleMedium),
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
                          child: Text(
                            invoice.category ?? 'N/A',
                            style: AppTypography.labelMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estado', style: AppTypography.titleMedium),
                        Text(
                          invoice.status,
                          style: AppTypography.titleMedium.copyWith(
                            color: invoice.status == 'Processed'
                                ? AppColors.secondary
                                : AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: AppTypography.titleLarge),
                          Text(
                            '\$${invoice.amount?.toStringAsFixed(2) ?? '0.00'}',
                            style: AppTypography.displayLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (msg) => Center(child: Text('Error: $msg')),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
