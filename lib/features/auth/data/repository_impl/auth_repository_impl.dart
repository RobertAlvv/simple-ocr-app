import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;
  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _datasource.login(email: email, password: password);
      return Right(user);
    } on Exception catch (e) {
      final code = e.toString().replaceAll('Exception: ', '');
      return Left(AuthFailure.fromCode(code));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final user = await _datasource.register(
        email: email,
        password: password,
        displayName: displayName,
      );
      return Right(user);
    } on Exception catch (e) {
      final code = e.toString().replaceAll('Exception: ', '');
      return Left(AuthFailure.fromCode(code));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _datasource.logout();
      return const Right(unit);
    } catch (_) {
      return const Left(ServerFailure('Error al cerrar sesión'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await _datasource.getCurrentUser();
      return Right(user);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
