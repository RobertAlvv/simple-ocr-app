import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/expense_entity.dart';

part 'expense_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ExpenseModel extends ExpenseEntity {
  const ExpenseModel({
    required super.id,
    required super.merchantName,
    required super.amount,
    required super.date,
    required super.category,
    super.status,
    super.receiptUrl,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);

  factory ExpenseModel.fromEntity(ExpenseEntity entity) => ExpenseModel(
    id: entity.id,
    merchantName: entity.merchantName,
    amount: entity.amount,
    date: entity.date,
    category: entity.category,
    status: entity.status,
    receiptUrl: entity.receiptUrl,
  );
}
