import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/no_params.dart';
import '../../domain/entity/expense_entity.dart';
import '../../domain/use_case/get_expenses_use_case.dart';

part 'expense_event.dart';
part 'expense_state.dart';
part 'expense_bloc.freezed.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetExpensesUseCase _getExpensesUseCase;

  ExpenseBloc(this._getExpensesUseCase) : super(const ExpenseState.initial()) {
    on<LoadExpenses>(_onLoadExpenses);
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(const ExpenseState.loading());
    final result = await _getExpensesUseCase(const NoParams());
    result.fold(
      (failure) => emit(ExpenseState.error(failure.message)),
      (expenses) => emit(ExpenseState.loaded(expenses)),
    );
  }
}
