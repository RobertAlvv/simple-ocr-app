import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_case/get_settings_use_case.dart';
import '../../domain/use_case/update_settings_use_case.dart';
import 'settings_event.dart';
import 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase _getSettingsUseCase;
  final UpdateSettingsUseCase _updateSettingsUseCase;

  SettingsBloc(this._getSettingsUseCase, this._updateSettingsUseCase)
    : super(const SettingsState.initial()) {
    on<SettingsEvent>((event, emit) async {
      await event.map(
        loadSettings: (_) async {
          emit(const SettingsState.loading());
          final result = await _getSettingsUseCase();
          result.fold(
            (failure) => emit(SettingsState.error(failure.message)),
            (settings) => emit(SettingsState.loaded(settings)),
          );
        },
        updateSettings: (e) async {
          emit(const SettingsState.loading());
          final result = await _updateSettingsUseCase(e.settings);
          result.fold(
            (failure) => emit(SettingsState.error(failure.message)),
            (settings) => emit(SettingsState.loaded(settings)),
          );
        },
      );
    });
  }
}
