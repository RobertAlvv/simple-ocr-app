import 'package:equatable/equatable.dart';

/// Base class for domain-layer failures.
/// Every repository returns `Either<Failure, T>`.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// ── Server / Network ───────────────────────────────────────

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Error del servidor']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexión a internet']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Tiempo de espera agotado']);
}

// ── Data ───────────────────────────────────────────────────

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Error de caché']);
}

class ParseFailure extends Failure {
  const ParseFailure([super.message = 'Error al procesar datos']);
}

// ── Auth ───────────────────────────────────────────────────

class AuthFailure extends Failure {
  const AuthFailure(super.message);

  factory AuthFailure.fromCode(String code) => switch (code) {
    'user-not-found' => const AuthFailure('Usuario no encontrado'),
    'wrong-password' => const AuthFailure('Contraseña incorrecta'),
    'email-already-in-use' => const AuthFailure('El correo ya está registrado'),
    'invalid-email' => const AuthFailure('Correo electrónico inválido'),
    'weak-password' => const AuthFailure('La contraseña es demasiado débil'),
    'too-many-requests' => const AuthFailure(
      'Demasiados intentos, intenta más tarde',
    ),
    _ => AuthFailure('Error de autenticación: $code'),
  };
}

// ── OCR ────────────────────────────────────────────────────

class OcrFailure extends Failure {
  const OcrFailure([super.message = 'Error al procesar el documento']);
}

// ── Storage ────────────────────────────────────────────────

class StorageFailure extends Failure {
  const StorageFailure([super.message = 'Error al guardar el archivo']);
}

// ── Permission ─────────────────────────────────────────────

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Permiso denegado']);
}
