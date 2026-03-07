import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/no_params.dart';
import '../entity/dashboard_entity.dart';
import '../repository/home_repository.dart';

@injectable
class GetDashboardDataUseCase {
  final HomeRepository _repository;

  GetDashboardDataUseCase(this._repository);

  Future<Either<Failure, DashboardEntity>> call(NoParams _) =>
      _repository.getDashboardData();
}
