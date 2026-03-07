import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/expense_entity.dart';
import '../../domain/repository/expense_repository.dart';
import '../datasource/expense_datasource.dart';

@LazySingleton(as: ExpenseRepository)
class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseDatasource _datasource;

  ExpenseRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ExpenseEntity>>> getExpenses() async {
    try {
      final models = await _datasource.getExpenses();
      return Right(models.cast<ExpenseEntity>());
    } catch (_) {
      return const Left(ServerFailure('Error al cargar historial de gastos'));
    }
  }
}
