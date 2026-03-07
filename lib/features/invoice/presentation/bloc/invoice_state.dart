part of 'invoice_bloc.dart';

@freezed
class InvoiceState with _$InvoiceState {
  const factory InvoiceState.initial() = _Initial;
  const factory InvoiceState.loading() = _Loading;
  const factory InvoiceState.loaded(InvoiceEntity invoice) = _Loaded;
  const factory InvoiceState.success([String? message]) = _Success;
  const factory InvoiceState.error(String message) = _Error;
}
