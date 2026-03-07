import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
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
  late TextEditingController _merchantController;
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  String _category = 'Otras';
  InvoiceEntity? _currentInvoice;

  @override
  void initState() {
    super.initState();
    _merchantController = TextEditingController();
    _amountController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _merchantController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _populateForm(InvoiceEntity invoice) {
    if (_currentInvoice?.id != invoice.id) {
      _currentInvoice = invoice;
      _merchantController.text = invoice.merchantName ?? '';
      _amountController.text = invoice.amount?.toStringAsFixed(2) ?? '';
      _dateController.text = invoice.date != null
          ? DateFormat('yyyy-MM-dd').format(invoice.date!)
          : '';
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
            context.router.replace(const ShellRoute()); // Go back to Home
          },
          error: (message) {
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
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Datos extraídos correctamente. Por favor verifica antes de guardar.',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _merchantController,
                        decoration: const InputDecoration(
                          labelText: 'Establecimiento',
                          prefixIcon: Icon(Icons.store),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Campo requerido' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Monto Total',
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Campo requerido' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          labelText: 'Fecha',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _currentInvoice != null) {
                            final updatedInvoice = InvoiceEntity(
                              id: _currentInvoice!.id,
                              imagePath: _currentInvoice!.imagePath,
                              merchantName: _merchantController.text,
                              amount: double.tryParse(_amountController.text),
                              date:
                                  DateTime.tryParse(_dateController.text) ??
                                  _currentInvoice!.date,
                              category: _category,
                              confidence: _currentInvoice!.confidence,
                              status: 'Processed', // Update status to processed
                            );
                            context.read<InvoiceBloc>().add(
                              InvoiceEvent.saveInvoice(updatedInvoice),
                            );
                          }
                        },
                        child: const Text('Confirmar y Guardar'),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (msg) => Center(child: Text('Error: $msg')),
            orElse: () => const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
