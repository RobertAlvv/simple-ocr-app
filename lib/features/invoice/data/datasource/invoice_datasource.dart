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

    // Fake extracted data
    return InvoiceModel(
      id: _uuid.v4(),
      imagePath: imagePath,
      merchantName: 'Mock Merchant Cafe',
      amount: 45.50,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Alimentos',
      confidence: 0.92,
      status: 'Pending',
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
