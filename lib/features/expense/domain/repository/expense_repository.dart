import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entity/expense_entity.dart';

abstract interface class ExpenseRepository {
  Future<Either<Failure, List<ExpenseEntity>>> getExpenses();
}
