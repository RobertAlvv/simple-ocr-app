part of 'invoice_bloc.dart';

@freezed
class InvoiceEvent with _$InvoiceEvent {
  const factory InvoiceEvent.processImage(String imagePath) = ProcessImage;
  const factory InvoiceEvent.saveInvoice(InvoiceEntity invoice) = SaveInvoice;
  const factory InvoiceEvent.getInvoiceDetail(String id) = GetInvoiceDetail;
}
