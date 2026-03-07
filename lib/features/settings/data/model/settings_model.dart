import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/settings_entity.dart';

part 'settings_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SettingsModel extends SettingsEntity {
  const SettingsModel({
    required super.isDarkMode,
    required super.notificationsEnabled,
    required super.saveOriginalImages,
    required super.currency,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

  factory SettingsModel.fromEntity(SettingsEntity entity) => SettingsModel(
    isDarkMode: entity.isDarkMode,
    notificationsEnabled: entity.notificationsEnabled,
    saveOriginalImages: entity.saveOriginalImages,
    currency: entity.currency,
  );
}
