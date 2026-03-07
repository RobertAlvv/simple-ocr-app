import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/dashboard_entity.dart';
import 'expense_model.dart';

part 'dashboard_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardModel extends DashboardEntity {
  @override
  // ignore: overridden_fields
  final List<ExpenseModel> recentExpenses;

  const DashboardModel({
    required super.totalExpensesMonth,
    required super.pendingInvoicesCount,
    required this.recentExpenses,
  }) : super(recentExpenses: recentExpenses);

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);

  factory DashboardModel.fromEntity(DashboardEntity entity) => DashboardModel(
    totalExpensesMonth: entity.totalExpensesMonth,
    pendingInvoicesCount: entity.pendingInvoicesCount,
    recentExpenses: entity.recentExpenses
        .map((e) => ExpenseModel.fromEntity(e))
        .toList(),
  );
}
