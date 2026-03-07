import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/invoice_entity.dart';

part 'invoice_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    required super.id,
    required super.imagePath,
    super.merchantName,
    super.amount,
    super.date,
    super.category,
    super.confidence,
    super.status,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);

  factory InvoiceModel.fromEntity(InvoiceEntity entity) => InvoiceModel(
    id: entity.id,
    imagePath: entity.imagePath,
    merchantName: entity.merchantName,
    amount: entity.amount,
    date: entity.date,
    category: entity.category,
    confidence: entity.confidence,
    status: entity.status,
  );
}
