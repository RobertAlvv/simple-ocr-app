import 'package:equatable/equatable.dart';

import 'expense_entity.dart';

/// Represents the data shown on the dashboard.
class DashboardEntity extends Equatable {
  final double totalExpensesMonth;
  final int pendingInvoicesCount;
  final List<ExpenseEntity> recentExpenses;

  const DashboardEntity({
    required this.totalExpensesMonth,
    required this.pendingInvoicesCount,
    required this.recentExpenses,
  });

  @override
  List<Object?> get props => [
    totalExpensesMonth,
    pendingInvoicesCount,
    recentExpenses,
  ];
}
