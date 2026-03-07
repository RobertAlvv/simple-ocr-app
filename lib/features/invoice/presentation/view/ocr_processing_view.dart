import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../bloc/invoice_bloc.dart';

class OcrProcessingView extends StatelessWidget {
  const OcrProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (invoice) {
              context.router.replace(
                ExtractedDataReviewRoute(invoiceId: invoice.id),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.error,
                ),
              );
              context.router.pop();
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: AppColors.primary),
                const SizedBox(height: 32),
                Text('Analizando factura...', style: AppTypography.titleLarge),
                const SizedBox(height: 16),
                Text(
                  'Extrayendo datos usando IA\nPor favor espera un momento.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
