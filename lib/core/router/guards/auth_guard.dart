import 'package:auto_route/auto_route.dart';

/// Placeholder AuthGuard — allows all navigation for now.
/// Replace with real authentication check when auth feature is implemented.
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // TODO: check if user is authenticated
    // final isAuthenticated = getIt<AuthRepository>().currentUser != null;
    // if (isAuthenticated) {
    //   resolver.next(true);
    // } else {
    //   router.push(LoginRoute(onLoginCallback: resolver.next));
    // }
    resolver.next(true); // Allow all for now
  }
}
