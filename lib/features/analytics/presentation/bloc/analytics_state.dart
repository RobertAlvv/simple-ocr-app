import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/analytics_entity.dart';

part 'analytics_state.freezed.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState.initial() = _Initial;
  const factory AnalyticsState.loading() = _Loading;
  const factory AnalyticsState.loaded({
    required AnalyticsEntity analytics,
    required String selectedPeriod,
  }) = _Loaded;
  const factory AnalyticsState.error(String message) = _Error;
}
