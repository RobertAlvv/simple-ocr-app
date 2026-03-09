import 'package:flutter/material.dart';

import '../../features/invoice/presentation/bloc/invoice_bloc.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// A full-screen error view that shows contextualized icons, messages,
/// and an optional retry button depending on the [ErrorKind].
class ErrorView extends StatelessWidget {
  final String message;
  final ErrorKind kind;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;

  const ErrorView({
    super.key,
    required this.message,
    this.kind = ErrorKind.unknown,
    this.onRetry,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final config = _configFor(kind);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: config.bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(config.icon, size: 48, color: config.iconColor),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Title
            Text(
              config.title,
              style: AppTypography.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),

            // Message
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Retry button
            if (onRetry != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              ),

            if (onRetry != null) const SizedBox(height: AppSpacing.md),

            // Back button
            if (onBack != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onBack,
                  child: const Text('Volver'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _ErrorConfig _configFor(ErrorKind kind) => switch (kind) {
    ErrorKind.network => const _ErrorConfig(
      icon: Icons.wifi_off_rounded,
      iconColor: AppColors.error,
      bgColor: AppColors.errorLight,
      title: 'Sin Conexión',
    ),
    ErrorKind.timeout => const _ErrorConfig(
      icon: Icons.access_time_rounded,
      iconColor: AppColors.warning,
      bgColor: AppColors.warningLight,
      title: 'Tiempo Agotado',
    ),
    ErrorKind.server => const _ErrorConfig(
      icon: Icons.cloud_off_rounded,
      iconColor: AppColors.error,
      bgColor: AppColors.errorLight,
      title: 'Error del Servidor',
    ),
    ErrorKind.ocr => const _ErrorConfig(
      icon: Icons.document_scanner_outlined,
      iconColor: AppColors.warning,
      bgColor: AppColors.warningLight,
      title: 'Error de Procesamiento',
    ),
    ErrorKind.unknown => const _ErrorConfig(
      icon: Icons.error_outline_rounded,
      iconColor: AppColors.error,
      bgColor: AppColors.errorLight,
      title: 'Error Inesperado',
    ),
  };
}

class _ErrorConfig {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;

  const _ErrorConfig({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
  });
}
