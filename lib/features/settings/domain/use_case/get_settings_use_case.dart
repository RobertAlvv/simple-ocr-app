import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entity/settings_entity.dart';
import '../repository/settings_repository.dart';

@lazySingleton
class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<Either<Failure, SettingsEntity>> call() {
    return repository.getSettings();
  }
}
