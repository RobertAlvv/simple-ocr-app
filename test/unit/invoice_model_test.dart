import 'package:flutter_test/flutter_test.dart';
import 'package:simple_ocr/features/invoice/data/model/invoice_model.dart';
import 'package:simple_ocr/features/invoice/domain/entity/invoice_entity.dart';

void main() {
  group('InvoiceModel', () {
    // JSON simulado como lo genera json_serializable (snake_case)
    final tJson = {
      'id': '550e8400-e29b-41d4-a716-446655440000',
      'image_path': 'factura.jpg',
      'raw_text': 'Supermercados Nacional S.A.\nRNC: 101234567',
      'supplier': 'Supermercados Nacional S.A.',
      'rnc': '101234567',
      'date': '2024-03-15T00:00:00.000',
      'subtotal': 1500.00,
      'tax': 270.00,
      'total': 1770.00,
      'confidence': 0.91,
      'status': 'Processed',
    };

    final tModel = InvoiceModel(
      id: '550e8400-e29b-41d4-a716-446655440000',
      imagePath: 'factura.jpg',
      rawText: 'Supermercados Nacional S.A.\nRNC: 101234567',
      supplier: 'Supermercados Nacional S.A.',
      rnc: '101234567',
      date: DateTime(2024, 3, 15),
      subtotal: 1500.00,
      tax: 270.00,
      total: 1770.00,
      confidence: 0.91,
      status: 'Processed',
    );

    group('fromJson', () {
      test('debe parsear todos los campos correctamente', () {
        final result = InvoiceModel.fromJson(tJson);
        expect(result.id, tModel.id);
        expect(result.supplier, tModel.supplier);
        expect(result.rnc, tModel.rnc);
        expect(result.date, tModel.date);
        expect(result.subtotal, tModel.subtotal);
        expect(result.tax, tModel.tax);
        expect(result.total, tModel.total);
        expect(result.confidence, tModel.confidence);
        expect(result.status, tModel.status);
      });

      test('debe mapear image_path → imagePath correctamente', () {
        final result = InvoiceModel.fromJson(tJson);
        expect(result.imagePath, 'factura.jpg');
      });

      test('debe mapear raw_text → rawText correctamente', () {
        final result = InvoiceModel.fromJson(tJson);
        expect(result.rawText, contains('RNC: 101234567'));
      });

      test('debe retornar null en campos opcionales ausentes', () {
        final minimalJson = {'id': 'test-id', 'image_path': 'test.jpg'};
        final result = InvoiceModel.fromJson(minimalJson);
        expect(result.supplier, isNull);
        expect(result.rnc, isNull);
        expect(result.date, isNull);
        expect(result.subtotal, isNull);
        expect(result.tax, isNull);
        expect(result.total, isNull);
        expect(result.confidence, isNull);
      });

      test('debe manejar montos como int en el JSON', () {
        final jsonWithInts = {
          ...tJson,
          'subtotal': 1500,
          'tax': 270,
          'total': 1770,
        };
        final result = InvoiceModel.fromJson(jsonWithInts);
        expect(result.subtotal, 1500.0);
        expect(result.tax, 270.0);
        expect(result.total, 1770.0);
      });
    });

    group('toJson', () {
      test('debe serializar todos los campos', () {
        final result = tModel.toJson();
        expect(result['supplier'], tModel.supplier);
        expect(result['rnc'], tModel.rnc);
        expect(result['subtotal'], tModel.subtotal);
        expect(result['tax'], tModel.tax);
        expect(result['total'], tModel.total);
        expect(result['confidence'], tModel.confidence);
        expect(result['status'], tModel.status);
      });

      test('debe usar image_path como key (no imagePath)', () {
        final result = tModel.toJson();
        expect(result.containsKey('image_path'), isTrue);
        expect(result.containsKey('imagePath'), isFalse);
      });

      test('fromJson → toJson es idempotente', () {
        final model = InvoiceModel.fromJson(tJson);
        final result = model.toJson();
        expect(result['supplier'], tJson['supplier']);
        expect(result['rnc'], tJson['rnc']);
        expect(result['total'], tJson['total']);
      });
    });

    group('fromBackendJson', () {
      final backendJson = {
        'id': '550e8400-e29b-41d4-a716-446655440000',
        'image_path': 'factura.jpg',
        'raw_text': 'Supermercados Nacional S.A.\nRNC: 101234567',
        'supplier': 'Supermercados Nacional S.A.',
        'rnc': '101234567',
        'date': '15/03/2024',
        'subtotal': 1500.00,
        'tax': 270.00,
        'total': 1770.00,
        'confidence': 0.91,
        'status': 'Processed',
      };

      test('debe parsear la respuesta del backend correctamente', () {
        final result = InvoiceModel.fromBackendJson(backendJson);
        expect(result.supplier, 'Supermercados Nacional S.A.');
        expect(result.rnc, '101234567');
        expect(result.subtotal, 1500.00);
        expect(result.tax, 270.00);
        expect(result.total, 1770.00);
        expect(result.confidence, 0.91);
        expect(result.status, 'Processed');
      });

      test('debe mapear supplier a merchantName también', () {
        final result = InvoiceModel.fromBackendJson(backendJson);
        expect(result.merchantName, result.supplier);
      });

      test('debe mapear total a amount (backward compat)', () {
        final result = InvoiceModel.fromBackendJson(backendJson);
        expect(result.amount, result.total);
      });

      test('debe manejar JSON con int en montos', () {
        final json = {
          ...backendJson,
          'subtotal': 1500,
          'tax': 270,
          'total': 1770,
        };
        final result = InvoiceModel.fromBackendJson(json);
        expect(result.subtotal, 1500.0);
        expect(result.tax, 270.0);
        expect(result.total, 1770.0);
      });

      test('debe manejar campos ausentes gracefully', () {
        final minimalJson = {'id': 'x', 'status': 'Pending'};
        final result = InvoiceModel.fromBackendJson(minimalJson);
        expect(result.supplier, isNull);
        expect(result.rnc, isNull);
        expect(result.total, isNull);
        expect(result.status, 'Pending');
      });
    });

    group('toEntity', () {
      test('debe convertir a InvoiceEntity correctamente', () {
        final entity = tModel.toEntity();
        expect(entity, isA<InvoiceEntity>());
        expect(entity.supplier, tModel.supplier);
        expect(entity.rnc, tModel.rnc);
        expect(entity.date, tModel.date);
        expect(entity.subtotal, tModel.subtotal);
        expect(entity.tax, tModel.tax);
        expect(entity.total, tModel.total);
        expect(entity.confidence, tModel.confidence);
        expect(entity.status, tModel.status);
      });

      test('campos null en model deben ser null en entity', () {
        final emptyModel = InvoiceModel(
          id: 'x',
          imagePath: 'test.jpg',
          status: 'Pending',
        );
        final entity = emptyModel.toEntity();
        expect(entity.supplier, isNull);
        expect(entity.rnc, isNull);
        expect(entity.total, isNull);
      });
    });

    group('fromEntity', () {
      test('debe crear model desde entity preservando campos', () {
        final entity = tModel.toEntity();
        final model = InvoiceModel.fromEntity(entity);
        expect(model.id, entity.id);
        expect(model.supplier, entity.supplier);
        expect(model.rnc, entity.rnc);
        expect(model.total, entity.total);
      });
    });

    group('fromBackendJson (v2 enriched response)', () {
      final v2ResponseJson = {
        'id': '550e8400-e29b-41d4-a716-446655440000',
        'image_path': 'factura.jpg',
        'raw_text': 'Supermercados Nacional S.A.\nRNC: 101234567',
        'success': true,
        'data': {
          'numero_comprobante': {'value': 'B0100000001', 'confidence': 0.85},
          'fecha_emision': {'value': '2024-03-15', 'confidence': 0.90},
          'proveedor': {
            'nombre': {
              'value': 'Supermercados Nacional S.A.',
              'confidence': 0.92,
            },
            'rnc': {'value': '101234567', 'confidence': 0.95, 'valid': true},
          },
          'montos': {
            'subtotal': {'value': 1500.00, 'confidence': 0.88},
            'impuesto': {'value': 270.00, 'confidence': 0.87},
            'total': {'value': 1770.00, 'confidence': 0.93},
          },
        },
        'extraction_warnings': ['Subtotal inferido por regla de 3'],
        'ocr_confidence_avg': 0.91,
        'processing_time_ms': 1250.5,
        // Flat backward compat fields also present
        'supplier': 'Supermercados Nacional S.A.',
        'rnc': '101234567',
        'date': '2024-03-15',
        'subtotal': 1500.00,
        'tax': 270.00,
        'total': 1770.00,
        'confidence': 0.91,
        'status': 'Processed',
      };

      test('debe parsear estructura anidada v2 correctamente', () {
        final result = InvoiceModel.fromBackendJson(v2ResponseJson);
        expect(result.supplier, 'Supermercados Nacional S.A.');
        expect(result.merchantName, result.supplier);
        expect(result.rnc, '101234567');
        expect(result.rncValid, true);
        expect(result.subtotal, 1500.00);
        expect(result.tax, 270.00);
        expect(result.total, 1770.00);
        expect(result.amount, 1770.00);
        expect(result.date, DateTime(2024, 3, 15));
        expect(result.numeroComprobante, 'B0100000001');
      });

      test('debe extraer fieldConfidences de la estructura anidada', () {
        final result = InvoiceModel.fromBackendJson(v2ResponseJson);
        expect(result.fieldConfidences, isNotNull);
        expect(result.fieldConfidences!['proveedor'], 0.92);
        expect(result.fieldConfidences!['rnc'], 0.95);
        expect(result.fieldConfidences!['subtotal'], 0.88);
        expect(result.fieldConfidences!['impuesto'], 0.87);
        expect(result.fieldConfidences!['total'], 0.93);
        expect(result.fieldConfidences!['fecha'], 0.90);
        expect(result.fieldConfidences!['numero_comprobante'], 0.85);
      });

      test('debe parsear extractionWarnings', () {
        final result = InvoiceModel.fromBackendJson(v2ResponseJson);
        expect(result.extractionWarnings, isNotNull);
        expect(result.extractionWarnings!.length, 1);
        expect(
          result.extractionWarnings!.first,
          'Subtotal inferido por regla de 3',
        );
      });

      test('debe parsear ocrConfidenceAvg y processingTimeMs', () {
        final result = InvoiceModel.fromBackendJson(v2ResponseJson);
        expect(result.ocrConfidenceAvg, 0.91);
        expect(result.processingTimeMs, 1250.5);
      });

      test('debe usar campos planos como fallback cuando data es null', () {
        final flatJson = {
          'id': 'flat-id',
          'image_path': 'test.jpg',
          'supplier': 'Flat Supplier',
          'rnc': '999888777',
          'date': '15/03/2024',
          'subtotal': 500.00,
          'tax': 90.00,
          'total': 590.00,
          'confidence': 0.80,
          'status': 'Processed',
        };
        final result = InvoiceModel.fromBackendJson(flatJson);
        expect(result.supplier, 'Flat Supplier');
        expect(result.rnc, '999888777');
        expect(result.subtotal, 500.00);
        expect(result.total, 590.00);
        expect(result.fieldConfidences, isNull);
        expect(result.extractionWarnings, isNull);
      });

      test('toEntity preserva campos v2', () {
        final model = InvoiceModel.fromBackendJson(v2ResponseJson);
        final entity = model.toEntity();
        expect(entity.rncValid, true);
        expect(entity.numeroComprobante, 'B0100000001');
        expect(entity.fieldConfidences?['proveedor'], 0.92);
        expect(
          entity.extractionWarnings?.first,
          'Subtotal inferido por regla de 3',
        );
        expect(entity.ocrConfidenceAvg, 0.91);
        expect(entity.processingTimeMs, 1250.5);
      });

      test('fromEntity preserva campos v2', () {
        final entity = InvoiceEntity(
          id: 'v2',
          imagePath: 'v2.jpg',
          rncValid: true,
          numeroComprobante: 'NCF123',
          ocrConfidenceAvg: 0.85,
          processingTimeMs: 980.0,
          fieldConfidences: const {'total': 0.9},
          extractionWarnings: const ['warn1'],
        );
        final model = InvoiceModel.fromEntity(entity);
        expect(model.rncValid, true);
        expect(model.numeroComprobante, 'NCF123');
        expect(model.ocrConfidenceAvg, 0.85);
        expect(model.processingTimeMs, 980.0);
        expect(model.fieldConfidences, {'total': 0.9});
        expect(model.extractionWarnings, ['warn1']);
      });
    });
  });
}
