import 'package:auto_route/auto_route.dart';
import 'package:tv_mosque/router.gr.dart';
import 'package:tv_mosque/router/guard_settings.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MosqueRoute.page, guards: [SettingsGuard()], initial: true),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: LanguageSettingsRoute.page),
    AutoRoute(page: SliderSettingsRoute.page),
    AutoRoute(page: ApiSettingsRoute.page),
    AutoRoute(page: PrayerTimesSettingsRoute.page),
  ];
}    