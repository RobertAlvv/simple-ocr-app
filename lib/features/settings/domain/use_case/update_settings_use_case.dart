import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entity/settings_entity.dart';
import '../repository/settings_repository.dart';

@lazySingleton
class UpdateSettingsUseCase {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  Future<Either<Failure, SettingsEntity>> call(SettingsEntity settings) {
    return repository.updateSettings(settings);
  }
}
