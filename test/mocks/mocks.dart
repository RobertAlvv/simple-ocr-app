import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:simple_ocr/features/invoice/data/datasource/invoice_remote_datasource.dart';
import 'package:simple_ocr/features/invoice/domain/repository/invoice_repository.dart';

@GenerateMocks([InvoiceRemoteDatasource, InvoiceRepository, Dio])
void main() {}
