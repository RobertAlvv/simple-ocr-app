import 'package:injectable/injectable.dart';

import '../core/router/app_router.dart';

/// Provides app-level dependencies that can't be auto-discovered by injectable.
@module
abstract class AppModule {
  @lazySingleton
  AppRouter get router => AppRouter();
}
