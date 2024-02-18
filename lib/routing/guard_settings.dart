import 'package:auto_route/auto_route.dart';

class SettingsGuard extends AutoRouteGuard {

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation

    //      resolver.next(true);
    //resolver.redirect(const SettingsRoute(), replace: true);
  }
}