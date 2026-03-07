// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) => ExpenseModel(
  id: json['id'] as String,
  merchantName: json['merchant_name'] as String,
  amount: (json['amount'] as num).toDouble(),
  date: DateTime.parse(json['date'] as String),
  category: json['category'] as String,
  status: json['status'] as String?,
);

Map<String, dynamic> _$ExpenseModelToJson(ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchant_name': instance.merchantName,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'category': instance.category,
      'status': instance.status,
    };
