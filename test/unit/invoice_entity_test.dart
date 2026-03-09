import 'package:flutter_test/flutter_test.dart';
import 'package:simple_ocr/features/invoice/domain/entity/invoice_entity.dart';

void main() {
  group('InvoiceEntity', () {
    final tEntity = InvoiceEntity(
      id: '550e8400-e29b-41d4-a716-446655440000',
      imagePath: 'factura.jpg',
      supplier: 'Supermercados Nacional S.A.',
      rnc: '101234567',
      date: DateTime(2024, 3, 15),
      subtotal: 1500.00,
      tax: 270.00,
      total: 1770.00,
      confidence: 0.91,
      status: 'Processed',
    );

    group('copyWith', () {
      test('debe mantener valores originales si no se pasan nuevos', () {
        final copy = tEntity.copyWith();
        expect(copy.supplier, tEntity.supplier);
        expect(copy.rnc, tEntity.rnc);
        expect(copy.total, tEntity.total);
        expect(copy.confidence, tEntity.confidence);
      });

      test('debe actualizar solo los campos indicados', () {
        final updated = tEntity.copyWith(status: 'Reviewed', total: 2000.00);
        expect(updated.status, 'Reviewed');
        expect(updated.total, 2000.00);
        expect(updated.supplier, tEntity.supplier); // sin cambios
        expect(updated.rnc, tEntity.rnc); // sin cambios
      });

      test('debe preservar imagePath', () {
        final copy = tEntity.copyWith(supplier: 'Otro');
        expect(copy.imagePath, tEntity.imagePath);
      });
    });

    group('Equatable / props', () {
      test('dos entidades con mismos datos deben ser iguales', () {
        final entity1 = InvoiceEntity(
          id: 'abc',
          imagePath: 'test.jpg',
          supplier: 'Test',
          total: 100.0,
        );
        final entity2 = InvoiceEntity(
          id: 'abc',
          imagePath: 'test.jpg',
          supplier: 'Test',
          total: 100.0,
        );
        expect(entity1, equals(entity2));
      });

      test('dos entidades con distinto id deben ser diferentes', () {
        final entity1 = InvoiceEntity(
          id: 'abc',
          imagePath: 'test.jpg',
          supplier: 'Test',
        );
        final entity2 = InvoiceEntity(
          id: 'xyz',
          imagePath: 'test.jpg',
          supplier: 'Test',
        );
        expect(entity1, isNot(equals(entity2)));
      });

      test('dos entidades con distinto total deben ser diferentes', () {
        final entity1 = InvoiceEntity(
          id: 'abc',
          imagePath: 'test.jpg',
          total: 100.0,
        );
        final entity2 = InvoiceEntity(
          id: 'abc',
          imagePath: 'test.jpg',
          total: 200.0,
        );
        expect(entity1, isNot(equals(entity2)));
      });
    });

    group('Defaults', () {
      test('status default debe ser Draft', () {
        final entity = InvoiceEntity(id: 'test', imagePath: 'test.jpg');
        expect(entity.status, 'Draft');
      });

      test('campos opcionales deben ser null por defecto', () {
        final entity = InvoiceEntity(id: 'test', imagePath: 'test.jpg');
        expect(entity.supplier, isNull);
        expect(entity.rnc, isNull);
        expect(entity.date, isNull);
        expect(entity.subtotal, isNull);
        expect(entity.tax, isNull);
        expect(entity.total, isNull);
        expect(entity.confidence, isNull);
        expect(entity.merchantName, isNull);
        expect(entity.rawText, isNull);
        expect(entity.category, isNull);
      });

      test('v2 campos opcionales deben ser null por defecto', () {
        final entity = InvoiceEntity(id: 'test', imagePath: 'test.jpg');
        expect(entity.numeroComprobante, isNull);
        expect(entity.rncValid, isNull);
        expect(entity.fieldConfidences, isNull);
        expect(entity.extractionWarnings, isNull);
        expect(entity.ocrConfidenceAvg, isNull);
        expect(entity.processingTimeMs, isNull);
      });
    });

    group('v2 enriched fields', () {
      final v2Entity = InvoiceEntity(
        id: 'v2-id',
        imagePath: 'factura_v2.jpg',
        supplier: 'Proveedor S.A.',
        rnc: '101234567',
        rncValid: true,
        numeroComprobante: 'B0100000001',
        date: DateTime(2024, 3, 15),
        subtotal: 1500.00,
        tax: 270.00,
        total: 1770.00,
        confidence: 0.91,
        fieldConfidences: const {'proveedor': 0.92, 'rnc': 0.95, 'total': 0.90},
        extractionWarnings: const ['Subtotal inferido'],
        ocrConfidenceAvg: 0.88,
        processingTimeMs: 1250.5,
      );

      test('confidenceFor devuelve confianza del campo solicitado', () {
        expect(v2Entity.confidenceFor('proveedor'), 0.92);
        expect(v2Entity.confidenceFor('rnc'), 0.95);
        expect(v2Entity.confidenceFor('total'), 0.90);
      });

      test('confidenceFor devuelve null para campo inexistente', () {
        expect(v2Entity.confidenceFor('desconocido'), isNull);
      });

      test('confidenceFor devuelve null si fieldConfidences es null', () {
        final e = InvoiceEntity(id: 'x', imagePath: 'x.jpg');
        expect(e.confidenceFor('total'), isNull);
      });

      test('copyWith preserva campos v2', () {
        final copy = v2Entity.copyWith(status: 'Processed');
        expect(copy.rncValid, true);
        expect(copy.numeroComprobante, 'B0100000001');
        expect(copy.fieldConfidences?['proveedor'], 0.92);
        expect(copy.extractionWarnings, ['Subtotal inferido']);
        expect(copy.ocrConfidenceAvg, 0.88);
        expect(copy.processingTimeMs, 1250.5);
      });

      test('copyWith puede actualizar campos v2', () {
        final updated = v2Entity.copyWith(
          rncValid: false,
          ocrConfidenceAvg: 0.75,
        );
        expect(updated.rncValid, false);
        expect(updated.ocrConfidenceAvg, 0.75);
      });

      test('Equatable incluye campos v2', () {
        final a = InvoiceEntity(
          id: 'a',
          imagePath: 'a.jpg',
          rncValid: true,
          ocrConfidenceAvg: 0.9,
        );
        final b = InvoiceEntity(
          id: 'a',
          imagePath: 'a.jpg',
          rncValid: false,
          ocrConfidenceAvg: 0.9,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
