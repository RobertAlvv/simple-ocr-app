import 'package:equatable/equatable.dart';

/// Placeholder parameter for use cases that take no input.
/// Usage: `useCase(const NoParams())`
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
