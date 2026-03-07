import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entity/invoice_entity.dart';
import '../repository/invoice_repository.dart';

@injectable
class ProcessImageUseCase {
  final InvoiceRepository _repository;

  ProcessImageUseCase(this._repository);

  Future<Either<Failure, InvoiceEntity>> call(String imagePath) {
    return _repository.processImage(imagePath);
  }
}
