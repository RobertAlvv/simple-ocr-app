import 'package:equatable/equatable.dart';

class InvoiceEntity extends Equatable {
  final String id;
  final String imagePath;
  final String? merchantName;
  final String? supplier;
  final String? rnc;
  final String? rawText;
  final double? amount;
  final double? subtotal;
  final double? tax;
  final double? total;
  final DateTime? date;
  final String? category;
  final double? confidence;
  final String status;

  // ── v2 enriched fields ─────────────────────────────────
  final String? numeroComprobante;
  final bool? rncValid;
  final Map<String, double>? fieldConfidences;
  final List<String>? extractionWarnings;
  final double? ocrConfidenceAvg;
  final double? processingTimeMs;

  const InvoiceEntity({
    required this.id,
    required this.imagePath,
    this.merchantName,
    this.supplier,
    this.rnc,
    this.rawText,
    this.amount,
    this.subtotal,
    this.tax,
    this.total,
    this.date,
    this.category,
    this.confidence,
    this.status = 'Draft',
    this.numeroComprobante,
    this.rncValid,
    this.fieldConfidences,
    this.extractionWarnings,
    this.ocrConfidenceAvg,
    this.processingTimeMs,
  });

  /// Returns the confidence for a specific field (0.0 – 1.0), or null.
  double? confidenceFor(String field) => fieldConfidences?[field];

  InvoiceEntity copyWith({
    String? id,
    String? imagePath,
    String? merchantName,
    String? supplier,
    String? rnc,
    String? rawText,
    double? amount,
    double? subtotal,
    double? tax,
    double? total,
    DateTime? date,
    String? category,
    double? confidence,
    String? status,
    String? numeroComprobante,
    bool? rncValid,
    Map<String, double>? fieldConfidences,
    List<String>? extractionWarnings,
    double? ocrConfidenceAvg,
    double? processingTimeMs,
  }) {
    return InvoiceEntity(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      merchantName: merchantName ?? this.merchantName,
      supplier: supplier ?? this.supplier,
      rnc: rnc ?? this.rnc,
      rawText: rawText ?? this.rawText,
      amount: amount ?? this.amount,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      date: date ?? this.date,
      category: category ?? this.category,
      confidence: confidence ?? this.confidence,
      status: status ?? this.status,
      numeroComprobante: numeroComprobante ?? this.numeroComprobante,
      rncValid: rncValid ?? this.rncValid,
      fieldConfidences: fieldConfidences ?? this.fieldConfidences,
      extractionWarnings: extractionWarnings ?? this.extractionWarnings,
      ocrConfidenceAvg: ocrConfidenceAvg ?? this.ocrConfidenceAvg,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
    );
  }

  @override
  List<Object?> get props => [
    id,
    imagePath,
    merchantName,
    supplier,
    rnc,
    rawText,
    amount,
    subtotal,
    tax,
    total,
    date,
    category,
    confidence,
    status,
    numeroComprobante,
    rncValid,
    fieldConfidences,
    extractionWarnings,
    ocrConfidenceAvg,
    processingTimeMs,
  ];
}
