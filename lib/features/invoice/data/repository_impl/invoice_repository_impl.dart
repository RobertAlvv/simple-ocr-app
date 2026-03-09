import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entity/invoice_entity.dart';
import '../../domain/repository/invoice_repository.dart';
import '../datasource/invoice_datasource.dart';
import '../datasource/invoice_remote_datasource.dart';
import '../model/invoice_model.dart';

@LazySingleton(as: InvoiceRepository)
class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceDatasource _datasource;
  final InvoiceRemoteDatasource _remoteDatasource;

  InvoiceRepositoryImpl(this._datasource, this._remoteDatasource);

  /// Quick connectivity probe — tries to resolve the backend host.
  Future<bool> _hasConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Either<Failure, InvoiceEntity>> processImage(String imagePath) async {
    // Proactive connectivity check
    if (!await _hasConnectivity()) {
      return const Left(
        NetworkFailure('Sin conexión a internet. Verifica tu red e intenta de nuevo.'),
      );
    }

    try {
      final imageFile = File(imagePath);
      final model = await _remoteDatasource.scanInvoice(imageFile);
      // Save to local datasource so ExtractedDataReviewScreen can retrieve it
      await _datasource.saveInvoice(model);
      return Right(model.toEntity());
    } on NetworkException catch (e) {
      final msg = e.message ?? '';
      // Differentiate timeout from generic network errors
      if (msg.toLowerCase().contains('timeout')) {
        return Left(TimeoutFailure(msg));
      }
      return Left(NetworkFailure(msg.isEmpty ? 'Sin conexión al servidor OCR' : msg));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Error del servidor'));
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
