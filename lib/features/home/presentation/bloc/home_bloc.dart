import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/no_params.dart';
import '../../domain/entity/dashboard_entity.dart';
import '../../domain/use_case/get_dashboard_data_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDashboardDataUseCase _getDashboardDataUseCase;

  HomeBloc(this._getDashboardDataUseCase) : super(const HomeState.initial()) {
    on<LoadData>(_onLoadData);
  }

  Future<void> _onLoadData(LoadData event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());

    final result = await _getDashboardDataUseCase(const NoParams());

    result.fold(
      (failure) => emit(HomeState.error(failure.message)),
      (data) => emit(HomeState.loaded(data)),
    );
  }
}
