import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/user_entity.dart';

/// Contrato del repositorio de autenticación.
/// La implementación vive en data/repository_impl/.
abstract interface class AuthRepository {
  /// Inicia sesión con email y contraseña.
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  /// Registra un nuevo usuario.
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String displayName,
  });

  /// Cierra la sesión del usuario actual.
  Future<Either<Failure, Unit>> logout();

  /// Retorna el usuario actualmente autenticado, o null.
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
