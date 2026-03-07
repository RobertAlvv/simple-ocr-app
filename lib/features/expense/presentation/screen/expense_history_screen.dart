import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/expense_bloc.dart';
import '../view/expense_history_view.dart';

@RoutePage()
class ExpenseHistoryScreen extends StatelessWidget {
  const ExpenseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ExpenseBloc>()..add(const ExpenseEvent.loadExpenses()),
      child: const ExpenseHistoryView(),
    );
  }
}
