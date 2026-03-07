import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/analytics_entity.dart';
import '../../domain/repository/analytics_repository.dart';
import '../datasource/analytics_datasource.dart';

@LazySingleton(as: AnalyticsRepository)
class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsDatasource datasource;

  AnalyticsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, AnalyticsEntity>> getAnalyticsData({
    required String period,
  }) async {
    try {
      final data = await datasource.getAnalyticsData(period);
      return Right(data);
    } catch (e) {
      return const Left(ServerFailure('Error fetching analytics'));
    }
  }
}
