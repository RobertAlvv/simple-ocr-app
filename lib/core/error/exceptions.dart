// Raw exceptions thrown by data/datasource layer.
// These get caught by repository_impl and mapped to [Failure].

class ServerException implements Exception {
  final String? message;
  final int? statusCode;
  const ServerException({this.message, this.statusCode});

  @override
  String toString() =>
      'ServerException(message: $message, statusCode: $statusCode)';
}

class NetworkException implements Exception {
  const NetworkException();
}

class CacheException implements Exception {
  final String? message;
  const CacheException({this.message});
}

class OcrException implements Exception {
  final String? message;
  const OcrException({this.message});

  @override
  String toString() => 'OcrException(message: $message)';
}

class StorageException implements Exception {
  final String? message;
  const StorageException({this.message});
}

class PermissionException implements Exception {
  final String? permission;
  const PermissionException({this.permission});

  @override
  String toString() => 'PermissionException(permission: $permission)';
}
