import 'dart:async';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:tv_mosque/Model/location.dart';
import '../../Service/http/http_service.dart';
import '../../Model/announcement.dart';
import '../../Model/calendar_info.dart';
import '../../Model/prayer_times.dart';
import 'package:adhan/adhan.dart' as adhan;

class ClockViewModel extends ChangeNotifier {
  ClockViewModel({
    required this.prayerTimes,
    required this.annoList,
    this.appbarVisible = false,
  }):
        now = DateTime.now();

  bool appbarVisible;

  PrayerTimes prayerTimes;
  int? currPrayerTimeType;
  DateTime now;

  final Map<String, Announcement> annoList;
  CalendarInfo? calendarInfo;

  toggleAppBarVisibility(){
    appbarVisible = !appbarVisible;
    notifyListeners();
  }

  updateClock(){
    now = DateTime.now();
    notifyListeners();
  }

  Future updatePrayerTimes({
    required adhan.CalculationMethod calcMethod,
    Location? location,
  }) async{
    if( calcMethod == adhan.CalculationMethod.other){
      /// IGMG
      HttpService().fetchPrayerTimes(
          DateTime.now(),
          locale: location?.city ??'de',
          cityID: location?.id ??20015
      ).then((value) {
        prayerTimes = value;
        notifyListeners();
      }).catchError((e){
        /// Fallback
        /// Diyanet
        if(location != null){
          prayerTimes = PrayerTimes.calculate(location: location, method: calcMethod);
          notifyListeners();
        }
      });

    } else {
      /// Diyanet
      if(location != null){
        prayerTimes = PrayerTimes.calculate(location: location, method: calcMethod);
        notifyListeners();
      }
    }
  }

  /// fetch data from directus
  Future updateAnnouncements() async {
    /// fetch announcements
    List<Announcement> list = await HttpService().fetchAnnouncements();
    Map<int, Announcement> basicMap = list.asMap();

    /// remove all annos except calendar data
    annoList.removeWhere((key, value) => !(['today_ayah_or_hadit', 'today_in_history', 'topic']).contains(key));

    /// add new annos
    basicMap.forEach((key, value) {
      annoList.putIfAbsent(key.toString(), () => value);
    });

    notifyListeners();
  }
  Map<String, Announcement> get annos{
    return Map<String, Announcement>.from(annoList);
  }

  /// fetch data from IGMG
  Future updateCalendarInfo() async {
    /// fetch calendar info
    final info = await HttpService().fetchCalendarInfo(DateTime.now());
    if(info != null){

      /// translate calendar event & topic
      //calendarInfo = await translateCalendarInfo(info);
      calendarInfo = info;

      /// remove all calendar data
      annoList.removeWhere((key, value) => (['today_ayah_or_hadit', 'today_in_history', 'topic']).contains(key));

      /// Adds ayah or hadit
      annoList.putIfAbsent('today_ayah_or_hadit', () =>
      const Announcement(id: 0, title: 'today_ayah_or_hadit', body: '', type: AnnoTypes.IGMG)
      );
      /// Adds today in history
      annoList.putIfAbsent('today_in_history', () =>
      const Announcement(id: 0, title: 'today_in_history', body: '', type: AnnoTypes.IGMG)
      );
      /// Adds topic
      annoList.putIfAbsent('topic', () =>
      const Announcement(id: 0, title: 'topic', body: '', type: AnnoTypes.IGMG)
      );

      notifyListeners();
    }
  }

  /// translates calendar info
  /// from original language turkish
  /// to another possible languages in app used
  /// once a day
  Future<CalendarInfo> translateCalendarInfo(CalendarInfo info) async{
    final translator = GoogleTranslator();

    /// translates calender event
    /// from tr to de
    await translator.translate(info.event??'', from: 'tr', to: 'de')
        .then((translation) => info.eventTranslations
        .update('de', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())

    );
    /// from tr to ar
    await translator.translate(info.event??'', from: 'tr', to: 'ar')
        .then((translation) => info.eventTranslations
        .update('ar', (v) => translation.toString(), ifAbsent: () => translation.toString())
    );
    /// original tr
    info.eventTranslations.update('tr', (v) => info.event??'',
        ifAbsent: () => info.event??'');

    /// translates calender days topic
    /// from tr to de
    await translator
        .translate(info.daysTopic??'', from: 'tr', to: 'de')
        .then((translation) => info.daysTopicTranslations
        .update('de', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())

    );
    /// from tr to ar
    await translator
        .translate(info.daysTopic??'', from: 'tr', to: 'ar')
        .then((translation) => info.daysTopicTranslations
        .update('ar', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())
    );
    /// original tr
    info.daysTopicTranslations.update('tr', (v) => info.daysTopic??'',
        ifAbsent: () => info.daysTopic??'');

    /// translates calender days topic text
    /// from tr to de
    await translator
        .translate(info.daysTopicText??'', from: 'tr', to: 'de')
        .then((translation) => info.daysTopicTextTranslations
        .update('de', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())

    );
    /// from tr to ar
    await translator
        .translate(info.daysTopicText??'', from: 'tr', to: 'ar')
        .then((translation) => info.daysTopicTextTranslations
        .update('ar', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())
    );
    /// original tr
    info.daysTopicTextTranslations.update('tr', (v) => info.daysTopicText??'',
        ifAbsent: () => info.daysTopicText??'');

    /// parses surah & ayah blocks from ayahOrHadith of IGMG
    /// match block "ayah" (surah name, 2:188)
    /// ex. "Aranızda mallarınızı..." (Bakara Suresi, 2:188)
    RegExp exp = RegExp(r'((“|")(.+?)(”|")).?((\()(.+?),.?(\d+:\d+)(\)))');
    if(exp.hasMatch(info.ayahOrHadith ??'')){
      Iterable<RegExpMatch> matches = exp.allMatches(info.ayahOrHadith ??'');
      for (RegExpMatch m in matches) {
        if ( m.groupCount == 9 ){
          /// parsed verse key found at group(9)
          /// ex. 2:188
          List<String> verseKey = m.group(8).toString().split(':');

          /// surah info at group(5)
          /// ex. (Bakara Suresi, 2:188)
          String surahInfoFromIGMG = m.group(5).toString();

          /// fetch Chapter from Quran API
          var chapterFromQuran = await HttpService()
              .fetchChapterById(id: verseKey[0]);

          /// Surah name from Quran latin
          /// ex. Al-Baqarah
          var surahNameFromQuran = chapterFromQuran.nameSimple
              ??chapterFromQuran.translatedName.name;

          /// surah info
          /// ex. (Al-Baqarah, 2:188)
          var surahInfo =
              '($surahNameFromQuran, ${verseKey[0]}:${verseKey[1]})';

          /// replaces surah name from IGMG with surah name from Quran API
          var replacedStr = info.ayahOrHadith
              .toString().replaceAll(surahInfoFromIGMG, surahInfo);

          /// adds into de translation array
          info.ayahTranslations.update(
              'de', (value) => replacedStr??'',
              ifAbsent: () => replacedStr??''
          );

          /// Surah name from Quran arabic
          /// ex. البقرة
          surahNameFromQuran = chapterFromQuran.nameArabic
              ??chapterFromQuran.translatedName.name;

          /// Surah Info
          /// ex. (البقرة, 2:188)
          surahInfo = '($surahNameFromQuran, ${verseKey[0]}:${verseKey[1]})';

          /// replaces surah name from IGMG with surah name from Quran API
          replacedStr = info.ayahOrHadith
              .toString().replaceAll(surahInfoFromIGMG, surahInfo);

          /// adds into ar translation array
          info.ayahTranslations.update(
              'ar', (value) => replacedStr??'',
              ifAbsent: () => replacedStr??''
          );

          /// no replacement needed for tr
          /// adds into tr translation array
          info.ayahTranslations.update(
              'tr', (value) => info.ayahOrHadith??'',
              ifAbsent: () => info.ayahOrHadith??'');

          /// fetch translated Verse
          /// ayah at group(3)
          /// without quotation marks
          /// ex. "Aranızda mallarınızı..." (Bakara Suresi, 2:188)
          /// Aranızda mallarınızı...
          String ayahWoQuotationMarks = m.group(3).toString();

          /// de translation
          /// of Abu Reda Muhammad ibn Ahmad(id:208) from Quran API
          /// adds into translation array
          var verse = await HttpService().fetchVerseByKey(
              surahNr: verseKey[0], ayahNr: verseKey[1],
              translation: 27, language: 'de');
          replacedStr = info.ayahTranslations['de']
              .toString().replaceAll(ayahWoQuotationMarks,
              verse.translations?[0].text ??'');
          info.ayahTranslations.update(
              'de', (value) => replacedStr??'',
              ifAbsent: () => replacedStr??''
          );

          /// org Quran ayah from API
          /// adds into translation array
          verse = await HttpService().fetchVerseByKey(
              surahNr: verseKey[0], ayahNr: verseKey[1],
              translation: null, language: 'ar');
          replacedStr = info.ayahTranslations['ar']
              .toString().replaceAll(ayahWoQuotationMarks,
              verse.textImlaei ??'');
          info.ayahTranslations.update(
              'ar', (value) => replacedStr??'',
              ifAbsent: () => replacedStr??''
          );
        }
      }

    } else {
      info.ayahTranslations.update(
          'tr', (value) => info.ayahOrHadith ??'', ifAbsent: () => info.ayahOrHadith ??''
      );
      info.ayahTranslations.update(
          'de', (value) => info.ayahOrHadith ??'', ifAbsent: () => info.ayahOrHadith ??''
      );
      info.ayahTranslations.update(
          'ar', (value) => info.ayahOrHadith ??'', ifAbsent: () => info.ayahOrHadith ??''
      );
    }

    return info;
  }
}