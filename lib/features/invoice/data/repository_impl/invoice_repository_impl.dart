import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/invoice_entity.dart';
import '../../domain/repository/invoice_repository.dart';
import '../datasource/invoice_datasource.dart';
import '../model/invoice_model.dart';

@LazySingleton(as: InvoiceRepository)
class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceDatasource _datasource;

  InvoiceRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, InvoiceEntity>> processImage(String imagePath) async {
    try {
      final model = await _datasource.processImage(imagePath);
      return Right(model);
    } catch (_) {
      return const Left(OcrFailure('No se pudo procesar la imagen'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveInvoice(InvoiceEntity invoice) async {
    try {
      await _datasource.saveInvoice(InvoiceModel.fromEntity(invoice));
      return const Right(unit);
    } catch (_) {
      return const Left(ServerFailure('No se pudo guardar la factura'));
    }
  }

  @override
  Future<Either<Failure, InvoiceEntity>> getInvoice(String id) async {
    try {
      final model = await _datasource.getInvoice(id);
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure('No se encontró la factura'));
    }
  }
}
