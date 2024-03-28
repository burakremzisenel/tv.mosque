import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:tv_mosque/router.gr.dart';
import '../Model/prayer_times.dart';
import '../Logic/Provider/provider_clock.dart';

class LayoutTop extends StatelessWidget {
  const LayoutTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [

          /// Next prayer time countdown
          Expanded(
              flex: 1,
              child: Selector<ClockViewModel, Tuple2<DateTime, PrayerTimes>>(
                  selector: (_, provider) => Tuple2(provider.now, provider.prayerTimes),
                  builder: (context, tuple, child) {

                    /// Get provider
                    final pTime = tuple.item2;
                    String pTimeEndsIn = pTime.prayerTimesEndsIn(wSeconds: true);

                    return InkWell(
                      focusColor: Colors.transparent,
                      onTap: (){
                        /// Navigate to settings page
                        context.setLocale(const Locale('de'))
                            .then((_) => context.pushRoute(const SettingsRoute()));
                        //context.pushRoute(const SettingsRoute());
                      },
                      child: Focus(
                        child: Builder(
                          builder: (context) {
                            final FocusNode focusNode = Focus.of(context);
                            final bool hasFocus = focusNode.hasFocus;
                            return Container(
                              margin: const EdgeInsets.all(25),
                              padding: const EdgeInsets.all(10),
                              /// Decoration
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black87,
                                boxShadow: [
                                  BoxShadow(
                                    color: hasFocus? Colors.redAccent: Colors.white24,
                                    blurRadius: 5.0,
                                    spreadRadius: 0.2,
                                  ),
                                  const BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 15.0,
                                    spreadRadius: -15.0,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  /// title Prayer times ends in
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: AutoSizeText(
                                          'pTimeEndsIn'.tr(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lime
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2
                                      ),
                                    ),
                                  ),

                                  /// Countdown 59:59:59
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: AutoSizeText(
                                          pTimeEndsIn??'',
                                          style: const TextStyle(
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepOrangeAccent
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                        ),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        ),
                      ),
                    );
                  })
          ),

          /// Middle Widget
          /// Date & Time
          Expanded(
            flex: 1,
            child: Selector<ClockViewModel, DateTime>(
                selector: (_, provider) => provider.now,
              builder: (context, now, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Row 1
                    /// local date
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                        DateFormat('EEE, dd.MMM yyyy', context.locale.toString()).format(now),
                        style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),

                    /// Row2
                    /// hijri date
                    Expanded(
                      flex: 3,
                      child: AutoSizeText(
                        HijriCalendar.now().toFormat("MMMM dd yyyy"),
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.lime,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),

                    /// Row3
                    /// Digital clock
                    Expanded(
                      flex: 5,
                      child: AutoSizeText(
                        DateFormat('HH:mm', context.locale.toString()).format(now),
                        style: const TextStyle(
                            fontSize: 34,
                            color: Colors.lime,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                  ],
                );
              }
            ),
          ),

          /// Right Widget
          /// ALLAH lafzı
          Expanded(
              child: Focus(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/Allah.png')),
                  ),
                ),
              )
          ),
        ]
    );
  }
}
