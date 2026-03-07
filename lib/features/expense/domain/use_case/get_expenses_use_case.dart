import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/no_params.dart';
import '../entity/expense_entity.dart';
import '../repository/expense_repository.dart';

@injectable
class GetExpensesUseCase {
  final ExpenseRepository _repository;

  GetExpensesUseCase(this._repository);

  Future<Either<Failure, List<ExpenseEntity>>> call(NoParams _) {
    return _repository.getExpenses();
  }
}
