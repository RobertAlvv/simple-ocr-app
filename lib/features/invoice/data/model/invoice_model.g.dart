// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
  id: json['id'] as String,
  imagePath: json['image_path'] as String,
  merchantName: json['merchant_name'] as String?,
  amount: (json['amount'] as num?)?.toDouble(),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  category: json['category'] as String?,
  confidence: (json['confidence'] as num?)?.toDouble(),
  status: json['status'] as String? ?? 'Draft',
);

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_path': instance.imagePath,
      'merchant_name': instance.merchantName,
      'amount': instance.amount,
      'date': instance.date?.toIso8601String(),
      'category': instance.category,
      'confidence': instance.confidence,
      'status': instance.status,
    };
