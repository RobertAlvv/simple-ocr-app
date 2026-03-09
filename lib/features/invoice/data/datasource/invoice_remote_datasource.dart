import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../model/invoice_model.dart';

/// Remote datasource that sends images to the backend OCR API.
abstract class InvoiceRemoteDatasource {
  /// Uploads [imageFile] to POST /api/scan-invoice and returns parsed model.
  Future<InvoiceModel> scanInvoice(File imageFile);
}

@LazySingleton(as: InvoiceRemoteDatasource)
class InvoiceRemoteDatasourceImpl implements InvoiceRemoteDatasource {
  final Dio _dio;

  InvoiceRemoteDatasourceImpl._(this._dio);

  @factoryMethod
  factory InvoiceRemoteDatasourceImpl() => InvoiceRemoteDatasourceImpl._(
    Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  /// For testing — allows injecting a mock Dio instance.
  factory InvoiceRemoteDatasourceImpl.withDio(Dio dio) =>
      InvoiceRemoteDatasourceImpl._(dio);

  @override
  Future<InvoiceModel> scanInvoice(File imageFile) async {
    final baseUrl = dotenv.env['OCR_API_BASE_URL'] ?? 'http://10.0.2.2:8000';
    final url = '$baseUrl/api/scan-invoice-v2';

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
        contentType: DioMediaType.parse(_inferMimeType(imageFile.path)),
      ),
    });

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return InvoiceModel.fromBackendJson(response.data!);
      }

      throw ServerException(
        message: 'Error del servidor: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  String _inferMimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      _ => 'image/jpeg',
    };
  }

  Exception _handleDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const NetworkException(
        'Timeout de conexión',
      ),
      DioExceptionType.connectionError => const NetworkException(
        'Sin conexión al servidor OCR',
      ),
      _ => ServerException(message: e.message ?? 'Error desconocido'),
    };
  }
}
