import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_mosque/Model/prayer_times.dart';
import 'dart:ui' as ui;
import 'package:tv_mosque/Logic/Provider/provider_clock.dart';
import 'package:tv_mosque/helper/extensions.dart';
import 'divider.dart';
import 'ptime_styles.dart';

List<Widget> buildPrayerTimesV(BuildContext context){
  List<Widget> list = [];
  for (int i = 0; i < (PrayerTimeType.values.length); i++) {
    list.add(
        Expanded(
            flex: 1,
            child: Directionality(
              textDirection: context.locale.toString() == 'ar'
                  ? ui.TextDirection.rtl
                  : ui.TextDirection.ltr,
              child: Selector<ClockViewModel, PrayerTimes>(
                  selector: (_, provider) => provider.prayerTimes,
                  builder: (context, prayerTimes, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // prayer time title
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: AutoSizeText(
                                'prayerTime'.tr(gender: PrayerTimeType.getByValue(i).name),
                                //minFontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                maxFontSize: 24,
                                style: styleOfPTimeTitle(
                                    prayerTimes.isCurrentPrayerTime(PrayerTimeType.getByValue(i)
                                    )
                                ),
                                textAlign: TextAlign.start
                            ),
                          ),
                        ),

                        // prayer time duration
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: AutoSizeText(
                                prayerTimes.humanReadableDuration(PrayerTimeType.getByValue(i)),
                                //minFontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: styleOfPTimeDuration(
                                    prayerTimes.isCurrentPrayerTime(PrayerTimeType.getByValue(i))
                                ),
                                textAlign: TextAlign.end
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              ),
            )
        )
    );
  }
  return list.joinWith(horizontalDivider());
}
