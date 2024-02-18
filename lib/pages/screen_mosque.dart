library mosque;

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:translator/translator.dart';
import 'package:tv_mosque/Logic/Provider/provider_settings.dart';
import 'package:tv_mosque/router.gr.dart';
import 'package:tv_mosque/widgets/layout_horizontal.dart';
import 'package:tv_mosque/widgets/layout_vertical.dart';

import '../Model/calendar_info.dart';
import '../Model/hijri_months.dart';
import '../Model/prayer_times.dart';
import '../Logic/Provider/provider_clock.dart';
import 'dart:ui' as ui;

import '../Service/http/http_service.dart';

part '../online_translator.dart';

@RoutePage()
class MosqueScreen extends StatefulWidget implements AutoRouteWrapper {
  const MosqueScreen({super.key});

  @override
  State<MosqueScreen> createState() => MosqueScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider<ClockViewModel>(
      create: (_) => ClockViewModel(
          prayerTimes:  PrayerTimes.init(),
          hijriDate: const HijriDate(hDate: ''),
          annoList: {},
      ),
      child: this,
    );
  }
}

class MosqueScreenState extends State<MosqueScreen> with AutoRouteAwareStateMixin<MosqueScreen>{
  Timer? _timer, _timerPrayerTimes, _timerToggleLanguage;
  final translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();

    debugPrint('initState');
    fetchData();
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

    _timer?.cancel();
    _timerPrayerTimes?.cancel();
    _timerToggleLanguage?.cancel();
    fetchData();

  }

  @override
  void dispose() {
    // stop timers
    _timer?.cancel();
    _timerPrayerTimes?.cancel();
    _timerToggleLanguage?.cancel();

    super.dispose();
  }

  fetchData() async {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    if(settingsProvider.settings.directusApi.isEmpty){
      context.navigateTo(const SettingsPage());
      return;
    }
    final clockProvider = Provider.of<ClockViewModel>(context, listen: false);

    final languageTimer = settingsProvider.settings.languageToggleTimer;

    /// fetch prayer times once a day
    /// update ui
    clockProvider.updatePrayerTimes();

    /// fetch announcements
    /// fetch IGMG once a day
    /// update carousel widget
    clockProvider.updateAnnouncements()
        .then((_) => clockProvider.updateCalendarInfo());

    /// start timer
    /// update clock widget
    /// update prayer times ends in widget
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final clockModel = Provider.of<ClockViewModel>(context, listen: false);

      /// update clock
      clockModel.updateClock();
    });

    /// start timer of prayer times update
    _timerPrayerTimes = Timer.periodic(const Duration(minutes: 1), (timer) async {
      final clockModel = Provider.of<ClockViewModel?>(context, listen: false);

      /// try to update prayer times
      clockModel?.updatePrayerTimes();
    });

    /// toggle language
    /// each x seconds
    _timerToggleLanguage = Timer.periodic(Duration(seconds: languageTimer), (timer) => _toggleLanguage());
  }

  /// toggles Language
  _toggleLanguage() {
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

    final clockModel = Provider.of<ClockViewModel?>(context, listen: false);

    /// update model
    clockModel?.updateAnnouncements()
        .then((_) => clockModel.updateCalendarInfo())
        .then((_) async {
          await context.setLocale(Locale(newLocale));
        });
  }

  @override
  Widget build(BuildContext context) {

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
