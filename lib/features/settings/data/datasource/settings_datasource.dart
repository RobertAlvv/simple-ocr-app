import 'package:injectable/injectable.dart';

import '../model/settings_model.dart';

abstract interface class SettingsDatasource {
  Future<SettingsModel> getSettings();
  Future<SettingsModel> updateSettings(SettingsModel settings);
}

@LazySingleton(as: SettingsDatasource)
class SettingsDatasourceImpl implements SettingsDatasource {
  // In-memory mock storage
  SettingsModel _mockSettings = const SettingsModel(
    isDarkMode: false,
    notificationsEnabled: true,
    saveOriginalImages: true,
    currency: 'USD',
  );

  @override
  Future<SettingsModel> getSettings() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockSettings;
  }

  @override
  Future<SettingsModel> updateSettings(SettingsModel settings) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _mockSettings = settings;
    return _mockSettings;
  }
}
