import 'package:auto_route/auto_route.dart';
import 'package:tv_mosque/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Page')
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MosquePage.page, initial: true),
    AutoRoute(page: SettingsPage.page),
    AutoRoute(page: LanguageSettingsPage.page),
    AutoRoute(page: SliderSettingsPage.page),
  ];
}    