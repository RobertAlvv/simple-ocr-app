import 'package:injectable/injectable.dart';

import '../model/expense_model.dart';

abstract interface class ExpenseDatasource {
  Future<List<ExpenseModel>> getExpenses();
}

@LazySingleton(as: ExpenseDatasource)
class ExpenseDatasourceImpl implements ExpenseDatasource {
  @override
  Future<List<ExpenseModel>> getExpenses() async {
    await Future.delayed(const Duration(milliseconds: 800));

    final now = DateTime.now();
    return [
      ExpenseModel(
        id: 'exp_001',
        merchantName: 'Amazon Web Services',
        amount: 120.00,
        date: now.subtract(const Duration(days: 1)),
        category: 'Software',
        status: 'Processed',
        receiptUrl: 'https://via.placeholder.com/150',
      ),
      ExpenseModel(
        id: 'exp_002',
        merchantName: 'Uber',
        amount: 25.50,
        date: now.subtract(const Duration(days: 2)),
        category: 'Transport',
        status: 'Processed',
        receiptUrl: 'https://via.placeholder.com/150',
      ),
      ExpenseModel(
        id: 'exp_003',
        merchantName: 'WeWork',
        amount: 450.00,
        date: now.subtract(const Duration(days: 5)),
        category: 'Office',
        status: 'Pending',
        receiptUrl: 'https://via.placeholder.com/150',
      ),
      ExpenseModel(
        id: 'exp_004',
        merchantName: 'Starbucks',
        amount: 8.50,
        date: now.subtract(const Duration(days: 7)),
        category: 'Food',
        status: 'Processed',
        receiptUrl: 'https://via.placeholder.com/150',
      ),
      ExpenseModel(
        id: 'exp_005',
        merchantName: 'Google Cloud Platform',
        amount: 210.30,
        date: now.subtract(const Duration(days: 10)),
        category: 'Software',
        status: 'Processed',
        receiptUrl: 'https://via.placeholder.com/150',
      ),
    ];
  }
}
