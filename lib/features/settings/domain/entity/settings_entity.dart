import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final bool saveOriginalImages;
  final String currency;

  const SettingsEntity({
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.saveOriginalImages,
    required this.currency,
  });

  @override
  List<Object?> get props => [
    isDarkMode,
    notificationsEnabled,
    saveOriginalImages,
    currency,
  ];
}
