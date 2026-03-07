import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/analytics_entity.dart';

part 'analytics_model.g.dart';

@JsonSerializable()
class MonthlyExpenseModel extends MonthlyExpense {
  const MonthlyExpenseModel({required super.month, required super.amount});

  factory MonthlyExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$MonthlyExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyExpenseModelToJson(this);

  factory MonthlyExpenseModel.fromEntity(MonthlyExpense entity) =>
      MonthlyExpenseModel(month: entity.month, amount: entity.amount);
}

@JsonSerializable()
class CategoryExpenseModel extends CategoryExpense {
  const CategoryExpenseModel({
    required super.category,
    required super.amount,
    required super.percentage,
  });

  factory CategoryExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryExpenseModelToJson(this);

  factory CategoryExpenseModel.fromEntity(CategoryExpense entity) =>
      CategoryExpenseModel(
        category: entity.category,
        amount: entity.amount,
        percentage: entity.percentage,
      );
}

@JsonSerializable()
class TopMerchantModel extends TopMerchant {
  const TopMerchantModel({
    required super.id,
    required super.name,
    required super.category,
    required super.amount,
    required super.invoiceCount,
  });

  factory TopMerchantModel.fromJson(Map<String, dynamic> json) =>
      _$TopMerchantModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopMerchantModelToJson(this);

  factory TopMerchantModel.fromEntity(TopMerchant entity) => TopMerchantModel(
    id: entity.id,
    name: entity.name,
    category: entity.category,
    amount: entity.amount,
    invoiceCount: entity.invoiceCount,
  );
}

@JsonSerializable()
class AnalyticsModel extends AnalyticsEntity {
  @override
  // ignore: overridden_fields
  final List<MonthlyExpenseModel> barChartData;
  @override
  // ignore: overridden_fields
  final List<CategoryExpenseModel> categoryExpenses;
  @override
  // ignore: overridden_fields
  final List<TopMerchantModel> topMerchants;

  const AnalyticsModel({
    required super.monthlyTotal,
    required this.barChartData,
    required this.categoryExpenses,
    required this.topMerchants,
  }) : super(
         barChartData: barChartData,
         categoryExpenses: categoryExpenses,
         topMerchants: topMerchants,
       );

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsModelToJson(this);

  factory AnalyticsModel.fromEntity(AnalyticsEntity entity) => AnalyticsModel(
    monthlyTotal: entity.monthlyTotal,
    barChartData: entity.barChartData
        .map((e) => MonthlyExpenseModel.fromEntity(e))
        .toList(),
    categoryExpenses: entity.categoryExpenses
        .map((e) => CategoryExpenseModel.fromEntity(e))
        .toList(),
    topMerchants: entity.topMerchants
        .map((e) => TopMerchantModel.fromEntity(e))
        .toList(),
  );
}
