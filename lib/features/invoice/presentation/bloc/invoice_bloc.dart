import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/invoice_entity.dart';
import '../../domain/use_case/get_invoice_use_case.dart';
import '../../domain/use_case/process_image_use_case.dart';
import '../../domain/use_case/save_invoice_use_case.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';
part 'invoice_bloc.freezed.dart';

@injectable
class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final ProcessImageUseCase _processImageUseCase;
  final SaveInvoiceUseCase _saveInvoiceUseCase;
  final GetInvoiceUseCase _getInvoiceUseCase;

  InvoiceBloc(
    this._processImageUseCase,
    this._saveInvoiceUseCase,
    this._getInvoiceUseCase,
  ) : super(const InvoiceState.initial()) {
    on<ProcessImage>(_onProcessImage);
    on<SaveInvoice>(_onSaveInvoice);
    on<GetInvoiceDetail>(_onGetInvoiceDetail);
  }

  Future<void> _onProcessImage(
    ProcessImage event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(const InvoiceState.loading());
    final result = await _processImageUseCase(event.imagePath);
    result.fold(
      (failure) => emit(InvoiceState.error(failure.message)),
      (invoice) => emit(InvoiceState.loaded(invoice)),
    );
  }

  Future<void> _onSaveInvoice(
    SaveInvoice event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(const InvoiceState.loading());
    final result = await _saveInvoiceUseCase(event.invoice);
    result.fold(
      (failure) => emit(InvoiceState.error(failure.message)),
      (_) => emit(const InvoiceState.success('Factura guardada correctamente')),
    );
  }

  Future<void> _onGetInvoiceDetail(
    GetInvoiceDetail event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(const InvoiceState.loading());
    final result = await _getInvoiceUseCase(event.id);
    result.fold(
      (failure) => emit(InvoiceState.error(failure.message)),
      (invoice) => emit(InvoiceState.loaded(invoice)),
    );
  }
}
