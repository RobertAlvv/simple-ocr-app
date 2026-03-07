import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/no_params.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

@injectable
class GetCurrentUserUseCase {
  final AuthRepository _repository;
  GetCurrentUserUseCase(this._repository);

  Future<Either<Failure, UserEntity?>> call(NoParams _) =>
      _repository.getCurrentUser();
}
