import 'package:injectable/injectable.dart';

import '../model/user_model.dart';

/// Contrato del datasource de autenticación.
abstract interface class AuthDatasource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String email,
    required String password,
    required String displayName,
  });
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

/// Implementación mock — datos hardcodeados con latencia simulada.
@LazySingleton(as: AuthDatasource)
class AuthDatasourceImpl implements AuthDatasource {
  UserModel? _currentUser;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock: acepta cualquier email válido con contraseña "123456"
    if (password != '123456') {
      throw Exception('wrong-password');
    }
    if (!email.contains('@')) {
      throw Exception('invalid-email');
    }

    _currentUser = UserModel(
      id: 'usr_001',
      email: email,
      displayName: email.split('@').first,
      photoUrl: null,
    );
    return _currentUser!;
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    _currentUser = UserModel(
      id: 'usr_002',
      email: email,
      displayName: displayName,
      photoUrl: null,
    );
    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _currentUser;
  }
}
