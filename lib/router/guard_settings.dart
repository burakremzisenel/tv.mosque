import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../Model/settings.dart';
import '../helper/shared_prefs.dart';
import '../router.gr.dart';

class SettingsGuard extends AutoRouteGuard {
  SettingsGuard();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation

    debugPrint('GUARD Settings RouteName: ${resolver.routeName}');

    /// Read settings from buffer
    Settings settings = Settings.fromJson(await readFromBuffer(BufferTypes.settings));
    if(settings.location == null){
      resolver.redirect(const SettingsRoute(), replace: true);

    } else {
      resolver.next(true);
    }
  }
}
