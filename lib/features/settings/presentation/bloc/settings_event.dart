import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/settings_entity.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.loadSettings() = _LoadSettings;
  const factory SettingsEvent.updateSettings(SettingsEntity settings) =
      _UpdateSettings;
}
