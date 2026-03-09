import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../model/invoice_model.dart';

abstract interface class InvoiceDatasource {
  Future<InvoiceModel> processImage(String imagePath);
  Future<void> saveInvoice(InvoiceModel invoice);
  Future<InvoiceModel> getInvoice(String id);
}

@LazySingleton(as: InvoiceDatasource)
class InvoiceDatasourceImpl implements InvoiceDatasource {
  final List<InvoiceModel> _db = [];
  final _uuid = const Uuid();

  @override
  Future<InvoiceModel> processImage(String imagePath) async {
    // Simulating OCR processing delay (longer since it's "AI")
    await Future.delayed(const Duration(milliseconds: 2500));

    // Fake extracted data simulating v2 enriched response
    return InvoiceModel(
      id: _uuid.v4(),
      imagePath: imagePath,
      merchantName: 'Mock Merchant Cafe',
      supplier: 'Mock Merchant Cafe',
      rnc: '101234567',
      rncValid: true,
      amount: 1770.00,
      subtotal: 1500.00,
      tax: 270.00,
      total: 1770.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Alimentos',
      confidence: 0.92,
      status: 'Pending',
      numeroComprobante: 'B0100000001',
      fieldConfidences: const {
        'proveedor': 0.92,
        'rnc': 0.95,
        'fecha': 0.88,
        'subtotal': 0.90,
        'impuesto': 0.90,
        'total': 0.93,
        'numero_comprobante': 0.85,
      },
      extractionWarnings: const [],
      ocrConfidenceAvg: 0.92,
      processingTimeMs: 1250.0,
    );
  }

  @override
  Future<void> saveInvoice(InvoiceModel invoice) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final index = _db.indexWhere((e) => e.id == invoice.id);
    if (index >= 0) {
      _db[index] = invoice;
    } else {
      _db.add(invoice);
    }
  }

  @override
  Future<InvoiceModel> getInvoice(String id) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final invoice = _db.firstWhere(
      (e) => e.id == id,
      orElse: () => InvoiceModel(
        id: id,
        imagePath: 'mock_path',
        merchantName: 'Unknown',
        amount: 0,
        date: DateTime.now(),
        category: 'Otras',
        confidence: 1.0,
        status: 'Processed',
      ),
    );
    return invoice;
  }
}
