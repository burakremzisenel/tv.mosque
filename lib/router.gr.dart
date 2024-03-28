// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:tv_mosque/pages/screen_mosque.dart' as _i3;
import 'package:tv_mosque/pages/screen_settings.dart' as _i5;
import 'package:tv_mosque/pages/settings/screen_settings_api.dart' as _i1;
import 'package:tv_mosque/pages/settings/screen_settings_language.dart' as _i2;
import 'package:tv_mosque/pages/settings/screen_settings_prayer_times.dart'
    as _i4;
import 'package:tv_mosque/pages/settings/screen_settings_slider.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    ApiSettingsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ApiSettingsPage(),
      );
    },
    LanguageSettingsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LanguageSettingsPage(),
      );
    },
    MosqueRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.WrappedRoute(child: const _i3.MosquePage()),
      );
    },
    PrayerTimesSettingsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PrayerTimesSettingsPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SettingsPage(),
      );
    },
    SliderSettingsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SliderSettingsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ApiSettingsPage]
class ApiSettingsRoute extends _i7.PageRouteInfo<void> {
  const ApiSettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ApiSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApiSettingsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LanguageSettingsPage]
class LanguageSettingsRoute extends _i7.PageRouteInfo<void> {
  const LanguageSettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LanguageSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageSettingsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MosquePage]
class MosqueRoute extends _i7.PageRouteInfo<void> {
  const MosqueRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MosqueRoute.name,
          initialChildren: children,
        );

  static const String name = 'MosqueRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PrayerTimesSettingsPage]
class PrayerTimesSettingsRoute extends _i7.PageRouteInfo<void> {
  const PrayerTimesSettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          PrayerTimesSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrayerTimesSettingsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SliderSettingsPage]
class SliderSettingsRoute extends _i7.PageRouteInfo<void> {
  const SliderSettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SliderSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SliderSettingsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
