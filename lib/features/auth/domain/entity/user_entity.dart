import 'package:equatable/equatable.dart';

/// Represents an authenticated user in the domain layer.
/// Dart puro — sin imports de Flutter, Firebase ni paquetes externos.
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;

  const UserEntity({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [id, email, displayName, photoUrl];
}
