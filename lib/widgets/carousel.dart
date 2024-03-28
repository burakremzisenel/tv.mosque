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
          return Selector<ClockViewModel, Map<String, Announcement>>(
              selector: (_, provider) => provider.annos,
              builder: (context, annoList, child) {

                if(annoList.isNotEmpty){
                  CalendarInfo? calendarInfo = Provider.of<ClockViewModel>(context, listen: false).calendarInfo;
                  List<Announcement> list = annoList.values.toList();
                  list.sort((a,b){
                    int compareType = a.type.key.compareTo(b.type.key);
                    if(compareType != 0){
                      return compareType;
                    }

                    if(a.type == AnnoTypes.IGMG){
                      return a.title.compareTo(b.title);

                    } else {
                      return -a.createdAt!.compareTo(b.createdAt!);
                    }
                  });

                  return Selector<SettingsProvider, int>(
                      selector: (_, provider) => provider.pageSlideTimer,
                      builder: (context, timer, child) {
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
                          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                            String title = list[itemIndex].title;
                            String body = list[itemIndex].body;
                            if(list[itemIndex].type == AnnoTypes.IGMG){
                              title = switch( list[itemIndex].title ){
                                'today_ayah_or_hadit' => 'today_ayah_or_hadit'.tr(),
                                'today_in_history' => 'today_in_history'.tr(),
                                'topic' => calendarInfo?.daysTopic ??'',
                                _ => '',
                              };
                              body = switch( list[itemIndex].title ){
                                'today_ayah_or_hadit' => calendarInfo?.ayahOrHadith ??'',
                                'today_in_history' => calendarInfo?.event ??'',
                                'topic' => calendarInfo?.daysTopicText ??'',
                                _ => '',
                              };
                            }
                            return AnnoCard(
                              imageFilename: list[itemIndex].image,
                              body: body,
                              title: title,
                              maxHeight: constraints.maxHeight,
                              maxWidth: constraints.maxWidth,
                            );
                          },
                        );
                      }
                  );

                } else {
                  return const SizedBox.shrink();
                }
              }
          );
        });
  }
}
