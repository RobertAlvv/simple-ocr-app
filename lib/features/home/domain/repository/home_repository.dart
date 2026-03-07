import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/dashboard_entity.dart';

/// Home repository contract.
abstract interface class HomeRepository {
  /// Fetches the dashboard data (totals and recent expenses).
  Future<Either<Failure, DashboardEntity>> getDashboardData();
}
