import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/invoice_entity.dart';

part 'invoice_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    required super.id,
    required super.imagePath,
    super.merchantName,
    super.supplier,
    super.rnc,
    super.rawText,
    super.amount,
    super.subtotal,
    super.tax,
    super.total,
    super.date,
    super.category,
    super.confidence,
    super.status,
    super.numeroComprobante,
    super.rncValid,
    super.fieldConfidences,
    super.extractionWarnings,
    super.ocrConfidenceAvg,
    super.processingTimeMs,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);

  /// Creates an [InvoiceModel] from the backend v2 OCR response
  /// ([EnrichedInvoiceResponse]).
  ///
  /// Falls back to the flat backward-compat fields when the nested `data`
  /// structure is absent.
  factory InvoiceModel.fromBackendJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    // ── nested v2 helpers ──────────────────────────────────
    String? nestedStr(Map<String, dynamic>? parent, String key) {
      if (parent == null) return null;
      final field = parent[key];
      if (field is Map<String, dynamic>) {
        final v = field['value'];
        return v?.toString();
      }
      return null;
    }

    double? nestedNum(Map<String, dynamic>? parent, String key) {
      if (parent == null) return null;
      final field = parent[key];
      if (field is Map<String, dynamic>) {
        final v = field['value'];
        if (v is num) return v.toDouble();
        if (v is String) return double.tryParse(v);
      }
      return null;
    }

    double nestedConf(Map<String, dynamic>? parent, String key) {
      if (parent == null) return 0.0;
      final field = parent[key];
      if (field is Map<String, dynamic>) {
        return (field['confidence'] as num?)?.toDouble() ?? 0.0;
      }
      return 0.0;
    }

    // ── extract from nested v2 data ─────────────────────
    final proveedor = data?['proveedor'] as Map<String, dynamic>?;
    final montos = data?['montos'] as Map<String, dynamic>?;

    final supplierV2 = nestedStr(proveedor, 'nombre');
    final rncV2 = nestedStr(proveedor, 'rnc');
    final rncObj = proveedor?['rnc'] as Map<String, dynamic>?;
    final rncValidV2 = rncObj?['valid'] as bool?;

    final subtotalV2 = nestedNum(montos, 'subtotal');
    final taxV2 = nestedNum(montos, 'impuesto');
    final totalV2 = nestedNum(montos, 'total');

    final dateV2 = nestedStr(data, 'fecha_emision');
    final ncfV2 = nestedStr(data, 'numero_comprobante');

    // ── resolve values (v2 nested → flat fallback) ──────
    final supplier = supplierV2 ?? json['supplier'] as String?;
    final rnc = rncV2 ?? json['rnc'] as String?;
    final subtotal = subtotalV2 ?? (json['subtotal'] as num?)?.toDouble();
    final tax = taxV2 ?? (json['tax'] as num?)?.toDouble();
    final total = totalV2 ?? (json['total'] as num?)?.toDouble();
    final dateStr = dateV2 ?? json['date'] as String?;
    final ncf = ncfV2 ?? json['numero_comprobante'] as String?;

    // ── build field confidences map ─────────────────────
    final Map<String, double> fieldConfidences = {};
    if (data != null) {
      fieldConfidences['proveedor'] = nestedConf(proveedor, 'nombre');
      fieldConfidences['rnc'] = nestedConf(proveedor, 'rnc');
      fieldConfidences['subtotal'] = nestedConf(montos, 'subtotal');
      fieldConfidences['impuesto'] = nestedConf(montos, 'impuesto');
      fieldConfidences['total'] = nestedConf(montos, 'total');
      fieldConfidences['fecha'] = nestedConf(data, 'fecha_emision');
      fieldConfidences['numero_comprobante'] = nestedConf(
        data,
        'numero_comprobante',
      );
    }

    // ── extraction warnings ─────────────────────────────
    final warningsRaw = json['extraction_warnings'] as List<dynamic>?;
    final warnings = warningsRaw?.cast<String>() ?? <String>[];

    return InvoiceModel(
      id: json['id'] as String? ?? '',
      imagePath: json['image_path'] as String? ?? '',
      rawText: json['raw_text'] as String?,
      supplier: supplier,
      merchantName: supplier, // keep in sync
      rnc: rnc,
      rncValid: rncValidV2,
      date: dateStr != null ? _parseDate(dateStr) : null,
      subtotal: subtotal,
      tax: tax,
      total: total,
      amount: total, // backward compat
      confidence:
          (json['confidence'] as num?)?.toDouble() ??
          (json['ocr_confidence_avg'] as num?)?.toDouble(),
      status: json['status'] as String? ?? 'Pending',
      numeroComprobante: ncf,
      fieldConfidences: fieldConfidences.isNotEmpty ? fieldConfidences : null,
      extractionWarnings: warnings.isNotEmpty ? warnings : null,
      ocrConfidenceAvg: (json['ocr_confidence_avg'] as num?)?.toDouble(),
      processingTimeMs: (json['processing_time_ms'] as num?)?.toDouble(),
    );
  }

  factory InvoiceModel.fromEntity(InvoiceEntity entity) => InvoiceModel(
    id: entity.id,
    imagePath: entity.imagePath,
    merchantName: entity.merchantName,
    supplier: entity.supplier,
    rnc: entity.rnc,
    rawText: entity.rawText,
    amount: entity.amount,
    subtotal: entity.subtotal,
    tax: entity.tax,
    total: entity.total,
    date: entity.date,
    category: entity.category,
    confidence: entity.confidence,
    status: entity.status,
    numeroComprobante: entity.numeroComprobante,
    rncValid: entity.rncValid,
    fieldConfidences: entity.fieldConfidences,
    extractionWarnings: entity.extractionWarnings,
    ocrConfidenceAvg: entity.ocrConfidenceAvg,
    processingTimeMs: entity.processingTimeMs,
  );

  InvoiceEntity toEntity() => InvoiceEntity(
    id: id,
    imagePath: imagePath,
    merchantName: merchantName,
    supplier: supplier,
    rnc: rnc,
    rawText: rawText,
    amount: amount,
    subtotal: subtotal,
    tax: tax,
    total: total,
    date: date,
    category: category,
    confidence: confidence,
    status: status,
    numeroComprobante: numeroComprobante,
    rncValid: rncValid,
    fieldConfidences: fieldConfidences,
    extractionWarnings: extractionWarnings,
    ocrConfidenceAvg: ocrConfidenceAvg,
    processingTimeMs: processingTimeMs,
  );

  /// Parses date strings in multiple formats: dd/MM/yyyy, dd-MM-yyyy, ISO 8601.
  static DateTime? _parseDate(String value) {
    // Try ISO 8601 first (e.g. "2024-03-15" or "2024-03-15T10:30:00")
    final iso = DateTime.tryParse(value);
    if (iso != null) return iso;

    // Try dd/MM/yyyy and dd-MM-yyyy
    for (final fmt in ['dd/MM/yyyy', 'dd-MM-yyyy']) {
      try {
        return DateFormat(fmt).parseStrict(value);
      } catch (_) {
        // try next format
      }
    }
    return null;
  }
}
