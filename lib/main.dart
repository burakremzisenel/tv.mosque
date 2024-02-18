
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_mosque/Service/http/http_service.dart';
import 'package:tv_mosque/router.dart';

import 'Logic/Provider/provider_settings.dart';
import 'Model/settings.dart';
import 'helper/shared_prefs.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  await EasyLocalization.ensureInitialized();

  /// full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  /// Get settings from buffer
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Settings settings = Settings.fromJson(await readFromBuffer(BufferTypes.settings));

  /// Update api settings in http service
  HttpService().settings = settings;

  runApp(
      EasyLocalization(
          supportedLocales: const [Locale('ar'),Locale('de'),Locale('tr'),Locale('en')],
          fallbackLocale: const Locale('tr'),
          startLocale: const Locale('tr'),
          saveLocale: true,
          path: 'assets/translations',
          child: MyApp(settings: settings)
      )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.settings});

  final Settings settings;

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MaterialApp.router(
        onGenerateTitle: (BuildContext context) {
          return 'app_name'.tr();
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        routerConfig: _appRouter.config(
          navigatorObservers: ()=>[AutoRouteObserver()],
        ),
        builder: (_, router){
          return ChangeNotifierProvider<SettingsProvider>(
              create: (_) => SettingsProvider(settings),
              child: router!
          );
        },
      ),
    );
  }
}


