// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      isDarkMode: json['is_dark_mode'] as bool,
      notificationsEnabled: json['notifications_enabled'] as bool,
      saveOriginalImages: json['save_original_images'] as bool,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'is_dark_mode': instance.isDarkMode,
      'notifications_enabled': instance.notificationsEnabled,
      'save_original_images': instance.saveOriginalImages,
      'currency': instance.currency,
    };
