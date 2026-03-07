import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entity/analytics_entity.dart';
import '../repository/analytics_repository.dart';

@lazySingleton
class GetAnalyticsDataUseCase {
  final AnalyticsRepository repository;

  GetAnalyticsDataUseCase(this.repository);

  Future<Either<Failure, AnalyticsEntity>> call({String period = 'Este Mes'}) {
    return repository.getAnalyticsData(period: period);
  }
}
