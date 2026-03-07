import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/invoice_entity.dart';

abstract interface class InvoiceRepository {
  /// Simulates OCR processing from an image path and returns parsed data.
  Future<Either<Failure, InvoiceEntity>> processImage(String imagePath);

  /// Saves the reviewed and confirmed invoice.
  Future<Either<Failure, Unit>> saveInvoice(InvoiceEntity invoice);

  /// Fetches a specific invoice by ID.
  Future<Either<Failure, InvoiceEntity>> getInvoice(String id);
}
