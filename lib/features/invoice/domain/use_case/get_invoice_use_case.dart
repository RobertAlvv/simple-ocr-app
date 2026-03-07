import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entity/invoice_entity.dart';
import '../repository/invoice_repository.dart';

@injectable
class GetInvoiceUseCase {
  final InvoiceRepository _repository;

  GetInvoiceUseCase(this._repository);

  Future<Either<Failure, InvoiceEntity>> call(String id) {
    return _repository.getInvoice(id);
  }
}
