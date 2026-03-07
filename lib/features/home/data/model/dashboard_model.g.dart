// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    DashboardModel(
      totalExpensesMonth: (json['total_expenses_month'] as num).toDouble(),
      pendingInvoicesCount: (json['pending_invoices_count'] as num).toInt(),
      recentExpenses: (json['recent_expenses'] as List<dynamic>)
          .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'total_expenses_month': instance.totalExpensesMonth,
      'pending_invoices_count': instance.pendingInvoicesCount,
      'recent_expenses': instance.recentExpenses,
    };
