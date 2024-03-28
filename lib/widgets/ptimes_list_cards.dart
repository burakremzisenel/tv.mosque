import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:tv_mosque/Model/prayer_times.dart';
import 'dart:ui' as ui;
import 'package:tv_mosque/Logic/Provider/provider_clock.dart';
import 'package:tv_mosque/helper/extensions.dart';
import 'ptime_styles.dart';

List<Widget> buildPrayerTimeCards(BuildContext context){
  List<Widget> list = [];
  for (int i = 0; i < (PrayerTimeType.values.length); i++) {
    list.add(
        Expanded(
          flex: 1,
          child: Selector<ClockViewModel, Tuple2<DateTime, PrayerTimes>>(
              selector: (_, provider) => Tuple2(provider.now, provider.prayerTimes),
              builder: (context, tuple, child) {

                final pTimes = tuple.item2;

                return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black87,
                      boxShadow: [
                        if(pTimes.isCurrentPrayerTime(PrayerTimeType.getByValue(i)))
                          const BoxShadow(
                            color: Colors.amber,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          )
                        else
                          const BoxShadow(
                            color: Colors.white24,
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
                    child: Directionality(
                      textDirection: context.locale.toString() == 'ar'
                          ? ui.TextDirection.rtl
                          : ui.TextDirection.ltr,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // prayer time title
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: AutoSizeText(
                                  'prayerTime'.tr(gender: PrayerTimeType.getByValue(i).name),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: styleOfPTimeTitle(
                                      pTimes.isCurrentPrayerTime(PrayerTimeType.getByValue(i))
                                  ),
                                  textAlign: TextAlign.center
                              ),
                            ),
                          ),

                          // prayer time duration
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: AutoSizeText(
                                  pTimes.humanReadableDuration(PrayerTimeType.getByValue(i)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: styleOfPTimeDuration(
                                      pTimes.isCurrentPrayerTime(PrayerTimeType.getByValue(i))
                                  ),
                                  textAlign: TextAlign.center
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                );
            }
          ),
        )
    );
  }
  return list.joinWith(const SizedBox(width: 2));
}