// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyExpenseModel _$MonthlyExpenseModelFromJson(Map<String, dynamic> json) =>
    MonthlyExpenseModel(
      month: json['month'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$MonthlyExpenseModelToJson(
  MonthlyExpenseModel instance,
) => <String, dynamic>{'month': instance.month, 'amount': instance.amount};

CategoryExpenseModel _$CategoryExpenseModelFromJson(
  Map<String, dynamic> json,
) => CategoryExpenseModel(
  category: json['category'] as String,
  amount: (json['amount'] as num).toDouble(),
  percentage: (json['percentage'] as num).toDouble(),
);

Map<String, dynamic> _$CategoryExpenseModelToJson(
  CategoryExpenseModel instance,
) => <String, dynamic>{
  'category': instance.category,
  'amount': instance.amount,
  'percentage': instance.percentage,
};

TopMerchantModel _$TopMerchantModelFromJson(Map<String, dynamic> json) =>
    TopMerchantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      invoiceCount: (json['invoiceCount'] as num).toInt(),
    );

Map<String, dynamic> _$TopMerchantModelToJson(TopMerchantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'amount': instance.amount,
      'invoiceCount': instance.invoiceCount,
    };

AnalyticsModel _$AnalyticsModelFromJson(Map<String, dynamic> json) =>
    AnalyticsModel(
      monthlyTotal: (json['monthlyTotal'] as num).toDouble(),
      barChartData: (json['barChartData'] as List<dynamic>)
          .map((e) => MonthlyExpenseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryExpenses: (json['categoryExpenses'] as List<dynamic>)
          .map((e) => CategoryExpenseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topMerchants: (json['topMerchants'] as List<dynamic>)
          .map((e) => TopMerchantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnalyticsModelToJson(AnalyticsModel instance) =>
    <String, dynamic>{
      'monthlyTotal': instance.monthlyTotal,
      'barChartData': instance.barChartData,
      'categoryExpenses': instance.categoryExpenses,
      'topMerchants': instance.topMerchants,
    };
