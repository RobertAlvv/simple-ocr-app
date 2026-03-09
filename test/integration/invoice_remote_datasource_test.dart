import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_ocr/features/invoice/data/datasource/invoice_remote_datasource.dart';
import 'package:simple_ocr/features/invoice/data/model/invoice_model.dart';
import 'package:simple_ocr/core/error/exceptions.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  late InvoiceRemoteDatasourceImpl datasource;
  late MockDio mockDio;

  // JSON de respuesta simulando exactamente el backend v2
  final tResponseJson = {
    'id': '550e8400-e29b-41d4-a716-446655440000',
    'image_path': 'test.jpg',
    'raw_text': 'Supermercados Nacional\nRNC: 101234567',
    'success': true,
    'data': {
      'numero_comprobante': {'value': 'B0100000001', 'confidence': 0.85},
      'fecha_emision': {'value': '2024-03-15', 'confidence': 0.90},
      'proveedor': {
        'nombre': {'value': 'Supermercados Nacional S.A.', 'confidence': 0.92},
        'rnc': {'value': '101234567', 'confidence': 0.95, 'valid': true},
      },
      'montos': {
        'subtotal': {'value': 1500.00, 'confidence': 0.88},
        'impuesto': {'value': 270.00, 'confidence': 0.87},
        'total': {'value': 1770.00, 'confidence': 0.93},
      },
    },
    'extraction_warnings': [],
    'ocr_confidence_avg': 0.91,
    'processing_time_ms': 1250.0,
    // Flat backward compat fields
    'supplier': 'Supermercados Nacional S.A.',
    'rnc': '101234567',
    'date': '2024-03-15',
    'subtotal': 1500.00,
    'tax': 270.00,
    'total': 1770.00,
    'confidence': 0.91,
    'status': 'Processed',
  };

  setUpAll(() async {
    // Load dotenv so the datasource can read OCR_API_BASE_URL
    dotenv.testLoad(fileInput: 'OCR_API_BASE_URL=http://10.0.2.2:8000');
  });

  setUp(() {
    mockDio = MockDio();
    datasource = InvoiceRemoteDatasourceImpl.withDio(mockDio);
  });

  group('scanInvoice', () {
    test('debe retornar InvoiceModel cuando la respuesta es 200', () async {
      // Crear archivo temporal de prueba
      final tempDir = Directory.systemTemp;
      final testFile = File('${tempDir.path}/test_invoice.jpg');
      await testFile.writeAsBytes(List.filled(100, 0));

      when(
        mockDio.post<Map<String, dynamic>>(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: tResponseJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/scan-invoice'),
        ),
      );

      final result = await datasource.scanInvoice(testFile);

      expect(result, isA<InvoiceModel>());
      expect(result.supplier, 'Supermercados Nacional S.A.');
      expect(result.rnc, '101234567');
      expect(result.total, 1770.00);
      expect(result.status, 'Processed');

      // v2 enriched fields
      expect(result.rncValid, true);
      expect(result.numeroComprobante, 'B0100000001');
      expect(result.ocrConfidenceAvg, 0.91);
      expect(result.fieldConfidences, isNotNull);
      expect(result.fieldConfidences!['total'], 0.93);

      await testFile.delete();
    });

    test('debe lanzar ServerException cuando statusCode != 200', () async {
      final testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List.filled(100, 0));

      when(
        mockDio.post<Map<String, dynamic>>(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {'detail': 'Internal Server Error'},
          statusCode: 500,
          requestOptions: RequestOptions(path: '/api/scan-invoice'),
        ),
      );

      expect(
        () => datasource.scanInvoice(testFile),
        throwsA(isA<ServerException>()),
      );

      await testFile.delete();
    });

    test(
      'debe lanzar NetworkException en DioExceptionType.connectionError',
      () async {
        final testFile = File('${Directory.systemTemp.path}/test.jpg');
        await testFile.writeAsBytes(List.filled(100, 0));

        when(
          mockDio.post<Map<String, dynamic>>(
            any,
            data: anyNamed('data'),
            options: anyNamed('options'),
          ),
        ).thenThrow(
          DioException(
            type: DioExceptionType.connectionError,
            requestOptions: RequestOptions(path: '/api/scan-invoice'),
          ),
        );

        expect(
          () => datasource.scanInvoice(testFile),
          throwsA(isA<NetworkException>()),
        );

        await testFile.delete();
      },
    );

    test('debe lanzar NetworkException en timeout', () async {
      final testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List.filled(100, 0));

      when(
        mockDio.post<Map<String, dynamic>>(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(path: '/api/scan-invoice'),
        ),
      );

      expect(
        () => datasource.scanInvoice(testFile),
        throwsA(isA<NetworkException>()),
      );

      await testFile.delete();
    });

    test('debe enviar la imagen como multipart/form-data', () async {
      final testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List.filled(100, 0));

      when(
        mockDio.post<Map<String, dynamic>>(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: tResponseJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/scan-invoice'),
        ),
      );

      await datasource.scanInvoice(testFile);

      // Verificar que se llamó con FormData
      final captured = verify(
        mockDio.post<Map<String, dynamic>>(
          any,
          data: captureAnyNamed('data'),
          options: anyNamed('options'),
        ),
      ).captured;

      expect(captured.first, isA<FormData>());

      await testFile.delete();
    });

    test('debe llamar al URL correcto del backend', () async {
      final testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List.filled(100, 0));

      when(
        mockDio.post<Map<String, dynamic>>(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: tResponseJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/api/scan-invoice'),
        ),
      );

      await datasource.scanInvoice(testFile);

      final captured = verify(
        mockDio.post<Map<String, dynamic>>(
          captureAny,
          data: anyNamed('data'),
          options: anyNamed('options'),
        ),
      ).captured;

      expect(captured.first, contains('/api/scan-invoice-v2'));

      await testFile.delete();
    });
  });
}
