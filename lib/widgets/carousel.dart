import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../Logic/Provider/provider_settings.dart';
import '../Model/announcement.dart';
import '../Model/calendar_info.dart';
import '../Logic/Provider/provider_clock.dart';
import 'card_announcement.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Selector<SettingsProvider, int>(
              selector: (_, provider) => provider.pageSlideTimer,
            builder: (context, timer, child) {
              return Selector<ClockViewModel, CalendarInfo?>(
                  selector: (_, provider) => provider.calendarInfo,
                  builder: (context, calendarInfo, child) {
                    final clockModel = Provider.of<ClockViewModel>(context, listen: false);

                    if(calendarInfo != null){

                      Map<String, Announcement> map = clockModel.annoList;
                      /// remove all calendar data
                      map.removeWhere((key, value) => (['today_ayah_or_hadit', 'today_in_history', 'topic']).contains(key));

                      /// Adds translated ayah or hadit to carousel
                      map.putIfAbsent('today_ayah_or_hadit', () =>
                          Announcement(
                              id: 0,
                              title: 'today_ayah_or_hadit'.tr(),
                              body: calendarInfo.getTranslatedAyah(context.locale.toString())
                          )
                      );
                      /// Adds translated today in history text to carousel
                      map.putIfAbsent('today_in_history', () =>
                          Announcement(
                              id: 0,
                              title: 'today_in_history'.tr(),
                              body: calendarInfo.getTranslatedEvent(context.locale.toString())
                          )
                      );
                      /// Adds translated topic to carousel
                      map.putIfAbsent('topic', () =>
                          Announcement(
                              id: 0,
                              title: calendarInfo.getTranslatedTopic(context.locale.toString()),
                              body: calendarInfo.getTranslatedTopicText(context.locale.toString())
                          )
                      );
                      List<Announcement> list = map.values.toList();

                      /// Carousel
                      return FlutterCarousel.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: timer),
                          autoPlayAnimationDuration: const Duration(milliseconds: 1300),
                          autoPlayCurve: Curves.easeOutBack,
                          viewportFraction: 1,
                          height: constraints.maxHeight,floatingIndicator: false
                        ),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                            AnnoCard(
                              imageFilename: list[itemIndex].image,
                              body: list[itemIndex].body,
                              title: list[itemIndex].title,
                              maxHeight: constraints.maxHeight,
                              maxWidth: constraints.maxWidth,
                            ),
                      );

                    } else {
                      return const SizedBox.shrink();
                    }
                  }
              );
            }
          );
        });
  }
}
