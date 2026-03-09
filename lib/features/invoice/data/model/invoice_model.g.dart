// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
  id: json['id'] as String,
  imagePath: json['image_path'] as String,
  merchantName: json['merchant_name'] as String?,
  supplier: json['supplier'] as String?,
  rnc: json['rnc'] as String?,
  rawText: json['raw_text'] as String?,
  amount: (json['amount'] as num?)?.toDouble(),
  subtotal: (json['subtotal'] as num?)?.toDouble(),
  tax: (json['tax'] as num?)?.toDouble(),
  total: (json['total'] as num?)?.toDouble(),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  category: json['category'] as String?,
  confidence: (json['confidence'] as num?)?.toDouble(),
  status: json['status'] as String? ?? 'Draft',
  numeroComprobante: json['numero_comprobante'] as String?,
  rncValid: json['rnc_valid'] as bool?,
  fieldConfidences: (json['field_confidences'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  extractionWarnings: (json['extraction_warnings'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  ocrConfidenceAvg: (json['ocr_confidence_avg'] as num?)?.toDouble(),
  processingTimeMs: (json['processing_time_ms'] as num?)?.toDouble(),
);

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_path': instance.imagePath,
      'merchant_name': instance.merchantName,
      'supplier': instance.supplier,
      'rnc': instance.rnc,
      'raw_text': instance.rawText,
      'amount': instance.amount,
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'total': instance.total,
      'date': instance.date?.toIso8601String(),
      'category': instance.category,
      'confidence': instance.confidence,
      'status': instance.status,
      'numero_comprobante': instance.numeroComprobante,
      'rnc_valid': instance.rncValid,
      'field_confidences': instance.fieldConfidences,
      'extraction_warnings': instance.extractionWarnings,
      'ocr_confidence_avg': instance.ocrConfidenceAvg,
      'processing_time_ms': instance.processingTimeMs,
    };
