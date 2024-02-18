import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/hijri_months.dart';
import '../Model/prayer_times.dart';
import '../Logic/Provider/provider_clock.dart';
import '../pages/screen_settings.dart';

class LayoutTop extends StatelessWidget {
  const LayoutTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
              flex: 1,
              child: Selector<ClockViewModel, DateTime>(
                  selector: (_, provider) => provider.now,
                  builder: (context, now, child) {

                    /// Get provider
                    PrayerTimes pTime = Provider.of<ClockViewModel>(context, listen: false).prayerTimes;
                    String pTimeEndsIn = pTime.prayerTimesEndsIn(wSeconds: true);

                    return InkWell(
                      focusColor: Colors.transparent,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsScreen()),
                        );
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

                                  /// Icon
                                  const Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        FittedBox(child: Icon(Icons.timer_outlined, color: Colors.deepOrangeAccent, size: 20)),
                                        FittedBox(
                                          child: AutoSizeText(
                                            'hh:mm:ss',
                                            style: TextStyle(fontSize: 10, color: Colors.white),
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Row 1
                /// local date
                Expanded(
                  flex: 2,
                  child: AutoSizeText(
                    DateFormat('EEE, dd.MMM yyyy', context.locale.toString()).format(DateTime.now()),
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
                Selector<ClockViewModel, HijriDate>(
                    selector: (_, provider) => provider.hijriDate,
                    builder: (context, hijriDate, child) {
                      return Expanded(
                        flex: 3,
                        child: AutoSizeText.rich(
                          TextSpan(
                              children: <TextSpan>[
                                for (String dateChunk in hijriDate.convert() ?? [])
                                  TextSpan(text: ' $dateChunk')
                              ]
                          ),
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.lime,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }
                ),

                /// Row3
                /// Digital clock
                Selector<ClockViewModel, DateTime>(
                    selector: (_, provider) => provider.now,
                    builder: (context, now, child) {
                      return Expanded(
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
                      );
                    }
                ),
              ],
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
