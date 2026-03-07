import 'package:injectable/injectable.dart';

import '../model/dashboard_model.dart';
import '../model/expense_model.dart';

abstract interface class HomeDatasource {
  Future<DashboardModel> getDashboardData();
}

@LazySingleton(as: HomeDatasource)
class HomeDatasourceImpl implements HomeDatasource {
  @override
  Future<DashboardModel> getDashboardData() async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data for the dashboard
    final now = DateTime.now();

    return DashboardModel(
      totalExpensesMonth: 1250.50,
      pendingInvoicesCount: 3,
      recentExpenses: [
        ExpenseModel(
          id: 'exp_1',
          merchantName: 'Amazon Web Services',
          amount: 120.00,
          date: now.subtract(const Duration(days: 1)),
          category: 'Software',
          status: 'Processed',
        ),
        ExpenseModel(
          id: 'exp_2',
          merchantName: 'Uber',
          amount: 25.50,
          date: now.subtract(const Duration(days: 2)),
          category: 'Transport',
          status: 'Processed',
        ),
        ExpenseModel(
          id: 'exp_3',
          merchantName: 'WeWork',
          amount: 450.00,
          date: now.subtract(const Duration(days: 5)),
          category: 'Office',
          status: 'Pending',
        ),
      ],
    );
  }
}
