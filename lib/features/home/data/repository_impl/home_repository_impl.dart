import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/dashboard_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/home_datasource.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource _datasource;

  HomeRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, DashboardEntity>> getDashboardData() async {
    try {
      final model = await _datasource.getDashboardData();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure('Error al cargar el dashboard'));
    }
  }
}
