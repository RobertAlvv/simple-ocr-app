import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entity/analytics_entity.dart';

abstract interface class AnalyticsRepository {
  Future<Either<Failure, AnalyticsEntity>> getAnalyticsData({
    required String period, // e.g., 'Este Mes', 'Mes Anterior', 'Este Año'
  });
}
