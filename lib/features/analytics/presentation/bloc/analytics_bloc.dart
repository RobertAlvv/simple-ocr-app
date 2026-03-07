import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_case/get_analytics_data_use_case.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

@injectable
class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetAnalyticsDataUseCase _getAnalyticsDataUseCase;

  AnalyticsBloc(this._getAnalyticsDataUseCase)
    : super(const AnalyticsState.initial()) {
    on<AnalyticsEvent>((event, emit) async {
      await event.map(
        loadData: (e) async {
          emit(const AnalyticsState.loading());
          final result = await _getAnalyticsDataUseCase(period: e.period);
          result.fold(
            (failure) => emit(AnalyticsState.error(failure.message)),
            (data) => emit(
              AnalyticsState.loaded(analytics: data, selectedPeriod: e.period),
            ),
          );
        },
      );
    });
  }
}
