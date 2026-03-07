import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entity/settings_entity.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Temporary state for the form
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _saveOriginalImages = true;
  String _currency = 'USD';

  bool _isInitialized = false;

  void _initializeState(SettingsEntity settings) {
    if (!_isInitialized) {
      _isDarkMode = settings.isDarkMode;
      _notificationsEnabled = settings.notificationsEnabled;
      _saveOriginalImages = settings.saveOriginalImages;
      _currency = settings.currency;
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg), backgroundColor: AppColors.error),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Ajustes', style: AppTypography.headlineMedium),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  final updatedSettings = SettingsEntity(
                    isDarkMode: _isDarkMode,
                    notificationsEnabled: _notificationsEnabled,
                    saveOriginalImages: _saveOriginalImages,
                    currency: _currency,
                  );
                  context.read<SettingsBloc>().add(
                    SettingsEvent.updateSettings(updatedSettings),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ajustes guardados')),
                  );
                },
              ),
            ],
          ),
          body: state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (settings) {
              _initializeState(settings);

              return ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  Text(
                    'Preferencias Generales',
                    style: AppTypography.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildSwitchTile(
                    title: 'Modo Oscuro',
                    subtitle: 'Cambia la apariencia de la app a oscura',
                    icon: Icons.dark_mode,
                    value: _isDarkMode,
                    onChanged: (val) => setState(() => _isDarkMode = val),
                  ),
                  const Divider(color: AppColors.divider),
                  _buildSwitchTile(
                    title: 'Notificaciones',
                    subtitle: 'Recibe alertas sobre facturas pendientes',
                    icon: Icons.notifications,
                    value: _notificationsEnabled,
                    onChanged: (val) =>
                        setState(() => _notificationsEnabled = val),
                  ),
                  const SizedBox(height: 32),
                  Text('Captura y OCR', style: AppTypography.titleLarge),
                  const SizedBox(height: 16),
                  _buildSwitchTile(
                    title: 'Guardar imágenes originales',
                    subtitle: 'Mantiene una copia de la foto en la galería',
                    icon: Icons.image,
                    value: _saveOriginalImages,
                    onChanged: (val) =>
                        setState(() => _saveOriginalImages = val),
                  ),
                  const Divider(color: AppColors.divider),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.attach_money,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Moneda Principal',
                              style: AppTypography.titleMedium,
                            ),
                            Text(
                              'Elegida para gráficos y estadísticas',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DropdownButton<String>(
                        value: _currency,
                        items: ['USD', 'EUR', 'DOP', 'COP', 'MXN']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _currency = val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.logout, color: AppColors.error),
                      label: Text(
                        'Cerrar Sesión',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        // TODO: Implement Logout in Auth Feature
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Función próximamente')),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            error: (msg) => Center(child: Text('Error: $msg')),
            orElse: () => const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleMedium),
                Text(
                  subtitle,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
