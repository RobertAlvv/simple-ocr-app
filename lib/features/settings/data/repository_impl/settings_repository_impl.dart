import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/settings_entity.dart';
import '../../domain/repository/settings_repository.dart';
import '../datasource/settings_datasource.dart';
import '../model/settings_model.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDatasource datasource;

  SettingsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, SettingsEntity>> getSettings() async {
    try {
      final data = await datasource.getSettings();
      return Right(data);
    } catch (e) {
      return const Left(ServerFailure('Error fetching settings'));
    }
  }

  @override
  Future<Either<Failure, SettingsEntity>> updateSettings(
    SettingsEntity settings,
  ) async {
    try {
      // mapping entity to model to pass it down to datasource
      final model = SettingsModel.fromEntity(settings);
      final data = await datasource.updateSettings(model);
      return Right(data);
    } catch (e) {
      return const Left(ServerFailure('Error updating settings'));
    }
  }
}
