library mosque;

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:translator/translator.dart';
import 'package:tv_mosque/Logic/Provider/provider_settings.dart';
import 'package:tv_mosque/widgets/layout_horizontal.dart';
import 'package:tv_mosque/widgets/layout_vertical.dart';
import 'package:wakelock/wakelock.dart';

import '../Model/calendar_info.dart';
import '../Model/prayer_times.dart';
import '../Logic/Provider/provider_clock.dart';
import 'dart:ui' as ui;

import '../Service/http/http_service.dart';

part '../online_translator.dart';

@RoutePage()
class MosquePage extends StatefulWidget implements AutoRouteWrapper {
  const MosquePage({super.key});

  @override
  State<MosquePage> createState() => MosquePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider<ClockViewModel>(
      create: (_) => ClockViewModel(
          prayerTimes:  PrayerTimes.init(),
          annoList: {},
      ),
      child: this,
    );
  }
}

class MosquePageState extends State<MosquePage> with AutoRouteAwareStateMixin<MosquePage>{
  Timer? _timer, _timerPrayerTimes, _timerToggleLanguage;
  final translator = GoogleTranslator();

  static const MethodChannel _channel = MethodChannel('mosque.tv/flutter_hdmi_cec');

  @override
  void initState() {
    super.initState();

    debugPrint('initState');

    /// Enable wake lock
    Wakelock.enable();
  }

  @override
  void didPush() {
    super.didPush();

    debugPrint('didPush');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    debugPrint('didChangeDependencies');
  }

  @override
  void didPushNext() {
    super.didPushNext();

    debugPrint('didPushNext');

    // stop timers
    _timer?.cancel();
    _timerPrayerTimes?.cancel();
    _timerToggleLanguage?.cancel();
  }

  @override
  void didPop() {
    super.didPop();

    debugPrint('didPop');
  }

  @override
  void didPopNext() {
    super.didPopNext();

    debugPrint('didPopNext');

    /// Fetch data
    /// and
    /// start timers
    initData();
  }

  @override
  void dispose() {
    // stop timers
    _timer?.cancel();
    _timerPrayerTimes?.cancel();
    _timerToggleLanguage?.cancel();

    super.dispose();
  }

  /// Fetch data
  /// and
  /// start timers
  initData() {
    _timer?.cancel();
    _timerPrayerTimes?.cancel();
    _timerToggleLanguage?.cancel();

    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    final clockProvider = Provider.of<ClockViewModel>(context, listen: false);

    /// Update prayer times
    clockProvider.updatePrayerTimes(
        calcMethod: settingsProvider.settings.calculationMethod,
        location: settingsProvider.settings.location
    );

    /// fetch announcements
    if(settingsProvider.settings.directus){
      clockProvider.updateAnnouncements().catchError((e)=>debugPrint(e.toString()));
    }

    /// Fetch calendar info from IGMG
    if(settingsProvider.settings.igmg){
      clockProvider.updateCalendarInfo().catchError((e)=>debugPrint(e.toString()));
    }

    /// Timer of clock widget
    /// each 1 second
    /// update prayer times ends in widget
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final clockModel = Provider.of<ClockViewModel>(context, listen: false);

      /// update clock
      clockModel.updateClock();
    });

    /// Timer of prayer times update
    /// each 1 minute
    _timerPrayerTimes = Timer.periodic(const Duration(seconds: 60), (timer) async {
      final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
      final clockProvider = Provider.of<ClockViewModel>(context, listen: false);

      /// Turn TV off after 60 min.
      if(clockProvider.prayerTimes.isISHAA()){
        int timeLeft = clockProvider.prayerTimes.currPrayerTimeEndsIn().inMinutes;
        int timeRange = clockProvider.prayerTimes.currPrayerTimeLength().inMinutes;
        if(timeRange - timeLeft > 60){
          /// Disable wake lock
          Wakelock.disable();
          //debugPrint('PlatformVer: ${await _channel.invokeMethod('getPlatformVersion')}');
        }
      }

      /// Update prayer times
      clockProvider.updatePrayerTimes(
          calcMethod: settingsProvider.settings.calculationMethod,
          location: settingsProvider.settings.location
      );

      /// fetch announcements
      if(settingsProvider.settings.directus){
        clockProvider.updateAnnouncements().catchError((e)=>debugPrint(e.toString()));
      }

      /// Fetch calendar info from IGMG
      if(settingsProvider.settings.igmg){
        clockProvider.updateCalendarInfo().catchError((e)=>debugPrint(e.toString()));
      }
    });

    /// toggle language
    /// each x seconds
    final languageTimer = settingsProvider.settings.languageToggleTimer;
    if(languageTimer != 0){
      _timerToggleLanguage = Timer.periodic(Duration(seconds: languageTimer), (timer) => _toggleLanguage());
    }
  }

  /// toggles Language
  _toggleLanguage() async {
    late String newLocale;
    switch (context.locale.toString()) {
      case 'de':
        newLocale = 'ar';
        break;
      case 'ar':
        newLocale = 'tr';
        break;
      case 'tr':
        newLocale = 'de';
        break;
      default:
        newLocale = 'de';
        break;
    }
    await context.setLocale(Locale(newLocale));
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initData();
    });

    return SafeArea(
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Scaffold(
          //Color(0xff005c4c)
          backgroundColor: CupertinoColors.darkBackgroundGray,

          /// body
          body: Selector<SettingsProvider, bool>(
            selector: (_, provider) => provider.isLandscape,
            builder: (context, isLandscape, child) {
              if(!isLandscape){
                return const RotatedBox(quarterTurns: 1, child: LayoutVertical());
              } else {
                return const LayoutHorizontal();
              }
            }
          ),
        ),
      ),
    );
  }
}
