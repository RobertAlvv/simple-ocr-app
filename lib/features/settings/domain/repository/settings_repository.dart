import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entity/settings_entity.dart';

abstract interface class SettingsRepository {
  Future<Either<Failure, SettingsEntity>> getSettings();
  Future<Either<Failure, SettingsEntity>> updateSettings(
    SettingsEntity settings,
  );
}
