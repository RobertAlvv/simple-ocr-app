import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/no_params.dart';
import '../repository/auth_repository.dart';

@injectable
class LogoutUseCase {
  final AuthRepository _repository;
  LogoutUseCase(this._repository);

  Future<Either<Failure, Unit>> call(NoParams _) => _repository.logout();
}
