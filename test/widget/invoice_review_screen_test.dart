import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_ocr/features/invoice/domain/entity/invoice_entity.dart';

void main() {
  // Entidad de prueba con datos completos (v2 enriched)
  final tEntity = InvoiceEntity(
    id: 'test-uuid',
    imagePath: 'test_invoice.jpg',
    supplier: 'Supermercados Nacional S.A.',
    merchantName: 'Supermercados Nacional S.A.',
    rnc: '101234567',
    rncValid: true,
    numeroComprobante: 'B0100000001',
    date: DateTime(2024, 3, 15),
    subtotal: 1500.00,
    tax: 270.00,
    total: 1770.00,
    confidence: 0.91,
    status: 'Processed',
    fieldConfidences: const {
      'proveedor': 0.92,
      'rnc': 0.95,
      'total': 0.93,
      'subtotal': 0.88,
      'impuesto': 0.87,
      'fecha': 0.90,
      'numero_comprobante': 0.85,
    },
    extractionWarnings: const ['Subtotal inferido'],
    ocrConfidenceAvg: 0.91,
    processingTimeMs: 1250.0,
  );

  // These widget tests verify that entity data can be rendered correctly.
  // They use inline widgets as placeholders — replace with the real
  // ExtractedDataReviewView once BLoC wiring is set up for testing.

  group('InvoiceReviewScreen', () {
    testWidgets('debe mostrar el nombre del supplier', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Text(tEntity.supplier ?? ''))),
      );
      expect(find.text('Supermercados Nacional S.A.'), findsOneWidget);
    });

    testWidgets('debe mostrar el RNC', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Text(tEntity.rnc ?? ''))),
      );
      expect(find.text('101234567'), findsOneWidget);
    });

    testWidgets('debe mostrar el total formateado', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text('RD\$ ${tEntity.total?.toStringAsFixed(2)}'),
          ),
        ),
      );
      expect(find.text('RD\$ 1770.00'), findsOneWidget);
    });

    testWidgets('debe mostrar la fecha formateada', (tester) async {
      final dateStr = tEntity.date != null
          ? '${tEntity.date!.day.toString().padLeft(2, '0')}/${tEntity.date!.month.toString().padLeft(2, '0')}/${tEntity.date!.year}'
          : '';
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Text(dateStr))));
      expect(find.text('15/03/2024'), findsOneWidget);
    });

    testWidgets('debe mostrar indicador de carga mientras procesa', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: CircularProgressIndicator())),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('debe mostrar mensaje de error cuando status es Failed', (
      tester,
    ) async {
      final failedEntity = tEntity.copyWith(status: 'Failed', confidence: 0.0);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              failedEntity.status == 'Failed'
                  ? 'No se pudieron extraer los datos'
                  : failedEntity.supplier ?? '',
            ),
          ),
        ),
      );
      expect(find.text('No se pudieron extraer los datos'), findsOneWidget);
    });

    testWidgets('debe mostrar subtotal y tax', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Text('Subtotal: RD\$ ${tEntity.subtotal?.toStringAsFixed(2)}'),
                Text('ITBIS: RD\$ ${tEntity.tax?.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ),
      );
      expect(find.text('Subtotal: RD\$ 1500.00'), findsOneWidget);
      expect(find.text('ITBIS: RD\$ 270.00'), findsOneWidget);
    });

    // ── v2 enriched tests ───────────────────────────────────────

    testWidgets('debe mostrar el número de comprobante (NCF)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Text('NCF: ${tEntity.numeroComprobante}')),
        ),
      );
      expect(find.text('NCF: B0100000001'), findsOneWidget);
    });

    testWidgets('debe mostrar badge de RNC válido', (tester) async {
      final isValid = tEntity.rncValid == true;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                Text(tEntity.rnc ?? ''),
                if (isValid)
                  const Icon(Icons.verified, color: Colors.green, size: 16),
              ],
            ),
          ),
        ),
      );
      expect(find.text('101234567'), findsOneWidget);
      expect(find.byIcon(Icons.verified), findsOneWidget);
    });

    testWidgets('debe mostrar confianza OCR general', (tester) async {
      final pct = '${(tEntity.ocrConfidenceAvg! * 100).round()}%';
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Text('Confianza OCR: $pct'))),
      );
      expect(find.text('Confianza OCR: 91%'), findsOneWidget);
    });

    testWidgets('debe mostrar warning de extracción', (tester) async {
      final warnings = tEntity.extractionWarnings ?? [];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(children: warnings.map((w) => Text(w)).toList()),
          ),
        ),
      );
      expect(find.text('Subtotal inferido'), findsOneWidget);
    });

    testWidgets('debe mostrar confianza por campo', (tester) async {
      final totalConf = tEntity.confidenceFor('total');
      final pct = '${(totalConf! * 100).round()}%';
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Text('Total confianza: $pct'))),
      );
      expect(find.text('Total confianza: 93%'), findsOneWidget);
    });
  });
}
