import 'package:injectable/injectable.dart';

import '../model/analytics_model.dart';

abstract interface class AnalyticsDatasource {
  Future<AnalyticsModel> getAnalyticsData(String period);
}

@LazySingleton(as: AnalyticsDatasource)
class AnalyticsDatasourceImpl implements AnalyticsDatasource {
  @override
  Future<AnalyticsModel> getAnalyticsData(String period) async {
    // Simular latencia de red
    await Future.delayed(const Duration(milliseconds: 800));

    // Datos mockeados dependiendo del período (simulados aquí)
    final double monthlyTotal = period == 'Mes Anterior' ? 3200.50 : 2540.75;

    final barChartData = [
      const MonthlyExpenseModel(month: 'Ene', amount: 1200),
      const MonthlyExpenseModel(month: 'Feb', amount: 1800),
      const MonthlyExpenseModel(month: 'Mar', amount: 1500),
      const MonthlyExpenseModel(month: 'Abr', amount: 2200),
      const MonthlyExpenseModel(month: 'May', amount: 2540),
      const MonthlyExpenseModel(month: 'Jun', amount: 3200),
    ];

    final categoryExpenses = [
      const CategoryExpenseModel(
        category: 'Tecnología',
        amount: 1200.0,
        percentage: 0.47,
      ),
      const CategoryExpenseModel(
        category: 'Transporte',
        amount: 600.0,
        percentage: 0.24,
      ),
      const CategoryExpenseModel(
        category: 'Alimentos',
        amount: 450.0,
        percentage: 0.18,
      ),
      const CategoryExpenseModel(
        category: 'Otras',
        amount: 290.75,
        percentage: 0.11,
      ),
    ];

    final topMerchants = [
      const TopMerchantModel(
        id: '1',
        name: 'Apple Store',
        category: 'Tecnología',
        amount: 899.99,
        invoiceCount: 1,
      ),
      const TopMerchantModel(
        id: '2',
        name: 'Uber',
        category: 'Transporte',
        amount: 320.50,
        invoiceCount: 14,
      ),
      const TopMerchantModel(
        id: '3',
        name: 'Supermercados Nacional',
        category: 'Alimentos',
        amount: 450.00,
        invoiceCount: 5,
      ),
    ];

    return AnalyticsModel(
      monthlyTotal: monthlyTotal,
      barChartData: (period == 'Mes Anterior')
          ? barChartData.sublist(0, 5) // Mock differentiation
          : barChartData,
      categoryExpenses: categoryExpenses,
      topMerchants: topMerchants,
    );
  }
}
