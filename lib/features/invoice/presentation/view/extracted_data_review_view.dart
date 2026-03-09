import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/confidence_indicator.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/warnings_banner.dart';
import '../../domain/entity/invoice_entity.dart';
import '../bloc/invoice_bloc.dart';

class ExtractedDataReviewView extends StatefulWidget {
  const ExtractedDataReviewView({super.key});

  @override
  State<ExtractedDataReviewView> createState() =>
      _ExtractedDataReviewViewState();
}

class _ExtractedDataReviewViewState extends State<ExtractedDataReviewView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _merchantController;
  late TextEditingController _rncController;
  late TextEditingController _ncfController;
  late TextEditingController _dateController;
  late TextEditingController _subtotalController;
  late TextEditingController _taxController;
  late TextEditingController _totalController;

  String _category = 'Otras';
  InvoiceEntity? _currentInvoice;

  @override
  void initState() {
    super.initState();
    _merchantController = TextEditingController();
    _rncController = TextEditingController();
    _ncfController = TextEditingController();
    _dateController = TextEditingController();
    _subtotalController = TextEditingController();
    _taxController = TextEditingController();
    _totalController = TextEditingController();
  }

  @override
  void dispose() {
    _merchantController.dispose();
    _rncController.dispose();
    _ncfController.dispose();
    _dateController.dispose();
    _subtotalController.dispose();
    _taxController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  void _populateForm(InvoiceEntity invoice) {
    if (_currentInvoice?.id != invoice.id) {
      _currentInvoice = invoice;
      _merchantController.text = invoice.merchantName ?? '';
      _rncController.text = invoice.rnc ?? '';
      _ncfController.text = invoice.numeroComprobante ?? '';
      _dateController.text = invoice.date != null
          ? DateFormat('yyyy-MM-dd').format(invoice.date!)
          : '';
      _subtotalController.text = invoice.subtotal?.toStringAsFixed(2) ?? '';
      _taxController.text = invoice.tax?.toStringAsFixed(2) ?? '';
      _totalController.text = invoice.total?.toStringAsFixed(2) ?? '';
      final validCategories = ['Alimentos', 'Transporte', 'Salud', 'Otras'];
      _category = validCategories.contains(invoice.category)
          ? invoice.category!
          : 'Otras';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceBloc, InvoiceState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message ?? 'Guardado con éxito')),
            );
            context.router.replace(const ShellRoute());
          },
          error: (message, kind) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.error,
              ),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Revisar Datos', style: AppTypography.headlineMedium),
          ),
          body: state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (invoice) {
              _populateForm(invoice);
              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Header: OCR confidence + processing time ──
                      _buildHeaderBanner(invoice),
                      const SizedBox(height: AppSpacing.md),

                      // ── Extraction warnings ───────────────────────
                      WarningsBanner(
                        warnings: invoice.extractionWarnings ?? [],
                      ),
                      if (invoice.extractionWarnings?.isNotEmpty ?? false)
                        const SizedBox(height: AppSpacing.md),

                      // ── Sección: Proveedor ────────────────────────
                      _buildSectionTitle('Proveedor'),
                      const SizedBox(height: AppSpacing.sm),
                      _buildFieldWithConfidence(
                        controller: _merchantController,
                        label: 'Establecimiento',
                        icon: Icons.store,
                        confidence: invoice.confidenceFor('proveedor'),
                        validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildRncField(invoice),
                      const SizedBox(height: AppSpacing.lg),

                      // ── Sección: Comprobante ──────────────────────
                      _buildSectionTitle('Comprobante'),
                      const SizedBox(height: AppSpacing.sm),
                      _buildFieldWithConfidence(
                        controller: _ncfController,
                        label: 'NCF / Número',
                        icon: Icons.receipt_long,
                        confidence: invoice.confidenceFor('numero_comprobante'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildFieldWithConfidence(
                        controller: _dateController,
                        label: 'Fecha',
                        icon: Icons.calendar_today,
                        confidence: invoice.confidenceFor('fecha'),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // ── Sección: Montos ───────────────────────────
                      _buildSectionTitle('Montos'),
                      const SizedBox(height: AppSpacing.sm),
                      _buildFieldWithConfidence(
                        controller: _subtotalController,
                        label: 'Subtotal',
                        icon: Icons.receipt,
                        confidence: invoice.confidenceFor('subtotal'),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildFieldWithConfidence(
                        controller: _taxController,
                        label: 'ITBIS (Impuesto)',
                        icon: Icons.percent,
                        confidence: invoice.confidenceFor('impuesto'),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildTotalField(invoice),
                      const SizedBox(height: AppSpacing.lg),

                      // ── Categoría ─────────────────────────────────
                      DropdownButtonFormField<String>(
                        initialValue: _category,
                        decoration: const InputDecoration(
                          labelText: 'Categoría',
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: ['Alimentos', 'Transporte', 'Salud', 'Otras']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _category = val);
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // ── Guardar ───────────────────────────────────
                      ElevatedButton(
                        onPressed: _onSave,
                        child: const Text('Confirmar y Guardar'),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (msg, kind) {
              return ErrorView(
                message: msg,
                kind: kind,
                onRetry: () {
                  final route = context.router.current;
                  try {
                    final id =
                        (route.args as ExtractedDataReviewRouteArgs).invoiceId;
                    context.read<InvoiceBloc>().add(
                      InvoiceEvent.getInvoiceDetail(id),
                    );
                  } catch (_) {}
                },
                onBack: () => context.router.pop(),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Private builders
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Widget _buildHeaderBanner(InvoiceEntity invoice) {
    final ocrPct = invoice.ocrConfidenceAvg != null
        ? '${(invoice.ocrConfidenceAvg! * 100).round()}%'
        : '–';
    final timeStr = invoice.processingTimeMs != null
        ? '${(invoice.processingTimeMs! / 1000).toStringAsFixed(1)}s'
        : '';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.secondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Datos extraídos correctamente',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Confianza OCR: $ocrPct${timeStr.isNotEmpty ? '  •  Procesado en $timeStr' : ''}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (invoice.ocrConfidenceAvg != null)
            ConfidenceIndicator(
              confidence: invoice.ocrConfidenceAvg,
              compact: true,
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTypography.titleMedium);
  }

  Widget _buildFieldWithConfidence({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    double? confidence,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  prefixIcon: Icon(icon),
                ),
                keyboardType: keyboardType,
                validator: validator,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            ConfidenceIndicator(confidence: confidence, compact: true),
          ],
        ),
      ],
    );
  }

  Widget _buildRncField(InvoiceEntity invoice) {
    final valid = invoice.rncValid;
    final validIcon = valid == null
        ? null
        : valid
        ? const Icon(Icons.verified, color: AppColors.secondary, size: 18)
        : const Icon(Icons.cancel, color: AppColors.error, size: 18);

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _rncController,
            decoration: InputDecoration(
              labelText: 'RNC',
              prefixIcon: const Icon(Icons.badge),
              suffixIcon: validIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: validIcon,
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        ConfidenceIndicator(
          confidence: invoice.confidenceFor('rnc'),
          compact: true,
        ),
      ],
    );
  }

  Widget _buildTotalField(InvoiceEntity invoice) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _totalController,
              decoration: const InputDecoration(
                labelText: 'Total',
                prefixIcon: Icon(Icons.attach_money),
                border: InputBorder.none,
              ),
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
            ),
          ),
          ConfidenceIndicator(confidence: invoice.confidenceFor('total')),
        ],
      ),
    );
  }

  void _onSave() {
    if (!_formKey.currentState!.validate() || _currentInvoice == null) return;

    final updatedInvoice = _currentInvoice!.copyWith(
      merchantName: _merchantController.text,
      supplier: _merchantController.text,
      rnc: _rncController.text.isNotEmpty ? _rncController.text : null,
      numeroComprobante: _ncfController.text.isNotEmpty
          ? _ncfController.text
          : null,
      date: DateTime.tryParse(_dateController.text) ?? _currentInvoice!.date,
      subtotal: double.tryParse(_subtotalController.text),
      tax: double.tryParse(_taxController.text),
      total: double.tryParse(_totalController.text),
      amount: double.tryParse(_totalController.text),
      category: _category,
      status: 'Processed',
    );

    context.read<InvoiceBloc>().add(InvoiceEvent.saveInvoice(updatedInvoice));
  }
}
