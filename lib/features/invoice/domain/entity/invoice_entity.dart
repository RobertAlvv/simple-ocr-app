import 'package:equatable/equatable.dart';

class InvoiceEntity extends Equatable {
  final String id;
  final String imagePath;
  final String? merchantName;
  final double? amount;
  final DateTime? date;
  final String? category;
  final double? confidence;
  final String status;

  const InvoiceEntity({
    required this.id,
    required this.imagePath,
    this.merchantName,
    this.amount,
    this.date,
    this.category,
    this.confidence,
    this.status = 'Draft',
  });

  @override
  List<Object?> get props => [
    id,
    imagePath,
    merchantName,
    amount,
    date,
    category,
    confidence,
    status,
  ];
}
