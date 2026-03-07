import 'package:equatable/equatable.dart';

class MonthlyExpense extends Equatable {
  final String month;
  final double amount;

  const MonthlyExpense({required this.month, required this.amount});

  @override
  List<Object?> get props => [month, amount];
}

class CategoryExpense extends Equatable {
  final String category;
  final double amount;
  final double percentage; // 0.0 to 1.0

  const CategoryExpense({
    required this.category,
    required this.amount,
    required this.percentage,
  });

  @override
  List<Object?> get props => [category, amount, percentage];
}

class TopMerchant extends Equatable {
  final String id;
  final String name;
  final String category;
  final double amount;
  final int invoiceCount;

  const TopMerchant({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.invoiceCount,
  });

  @override
  List<Object?> get props => [id, name, category, amount, invoiceCount];
}

class AnalyticsEntity extends Equatable {
  final double monthlyTotal;
  final List<MonthlyExpense> barChartData;
  final List<CategoryExpense> categoryExpenses;
  final List<TopMerchant> topMerchants;

  const AnalyticsEntity({
    required this.monthlyTotal,
    required this.barChartData,
    required this.categoryExpenses,
    required this.topMerchants,
  });

  @override
  List<Object?> get props => [
    monthlyTotal,
    barChartData,
    categoryExpenses,
    topMerchants,
  ];
}
