import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entity/invoice_entity.dart';
import '../repository/invoice_repository.dart';

@injectable
class SaveInvoiceUseCase {
  final InvoiceRepository _repository;

  SaveInvoiceUseCase(this._repository);

  Future<Either<Failure, Unit>> call(InvoiceEntity invoice) {
    return _repository.saveInvoice(invoice);
  }
}
