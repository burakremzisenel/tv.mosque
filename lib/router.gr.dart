// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:tv_mosque/pages/screen_mosque.dart' as _i2;
import 'package:tv_mosque/pages/screen_settings.dart' as _i3;
import 'package:tv_mosque/pages/screen_settings_language.dart' as _i1;
import 'package:tv_mosque/pages/screen_settings_slider.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    LanguageSettingsPage.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LanguageSettingsScreen(),
      );
    },
    MosquePage.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(child: const _i2.MosqueScreen()),
      );
    },
    SettingsPage.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SettingsScreen(),
      );
    },
    SliderSettingsPage.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SliderSettingsScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.LanguageSettingsScreen]
class LanguageSettingsPage extends _i5.PageRouteInfo<void> {
  const LanguageSettingsPage({List<_i5.PageRouteInfo>? children})
      : super(
          LanguageSettingsPage.name,
          initialChildren: children,
        );

  static const String name = 'LanguageSettingsPage';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MosqueScreen]
class MosquePage extends _i5.PageRouteInfo<void> {
  const MosquePage({List<_i5.PageRouteInfo>? children})
      : super(
          MosquePage.name,
          initialChildren: children,
        );

  static const String name = 'MosquePage';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SettingsScreen]
class SettingsPage extends _i5.PageRouteInfo<void> {
  const SettingsPage({List<_i5.PageRouteInfo>? children})
      : super(
          SettingsPage.name,
          initialChildren: children,
        );

  static const String name = 'SettingsPage';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SliderSettingsScreen]
class SliderSettingsPage extends _i5.PageRouteInfo<void> {
  const SliderSettingsPage({List<_i5.PageRouteInfo>? children})
      : super(
          SliderSettingsPage.name,
          initialChildren: children,
        );

  static const String name = 'SliderSettingsPage';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
