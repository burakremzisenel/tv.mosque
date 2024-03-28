part of mosque;

extension TranslatorOnline on MosquePageState{

  /// translates calendar info
  /// from original language turkish
  /// to another possible languages in app used
  /// once a day
  Future<CalendarInfo?> _translateCalendarInfo(CalendarInfo? calendarInfo) async{
    /// translates calender event
    /// from tr to de
    await translator
        .translate(calendarInfo?.event??'', from: 'tr', to: 'de')
        .then((translation) => calendarInfo?.eventTranslations
        .update('de', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())

    );
    /// from tr to ar
    await translator
        .translate(calendarInfo?.event??'', from: 'tr', to: 'ar')
        .then((translation) => calendarInfo?.eventTranslations
        .update('ar', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())
    );

    /// translates calender days topic
    /// from tr to de
    await translator
        .translate(calendarInfo?.daysTopic??'', from: 'tr', to: 'de')
        .then((translation) => calendarInfo?.daysTopicTranslations
        .update('de', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())

    );
    /// from tr to ar
    await translator
        .translate(calendarInfo?.daysTopic??'', from: 'tr', to: 'ar')
        .then((translation) => calendarInfo?.daysTopicTranslations
        .update('ar', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())
    );

    /// translates calender days topic text
    /// from tr to de
    await translator
        .translate(calendarInfo?.daysTopicText??'', from: 'tr', to: 'de')
        .then((translation) => calendarInfo?.daysTopicTextTranslations
        .update('de', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())

    );
    /// from tr to ar
    await translator
        .translate(calendarInfo?.daysTopicText??'', from: 'tr', to: 'ar')
        .then((translation) => calendarInfo?.daysTopicTextTranslations
        .update('ar', (v) => translation.toString(), ifAbsent: () =>
        translation.toString())
    );

    /// parses surah & ayah blocks from ayahOrHadith of IGMG
    /// match block "ayah" (surah name, 2:188)
    /// ex. "Aranızda mallarınızı..." (Bakara Suresi, 2:188)
    RegExp exp = RegExp(r'((“|")(.+?)(”|")).?((\()(.+?),.?(\d+:\d+)(\)))');
    Iterable<RegExpMatch> matches = exp
        .allMatches(calendarInfo?.ayahOrHadith ??'');
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
        var replacedStr = calendarInfo?.ayahOrHadith
            .toString().replaceAll(surahInfoFromIGMG, surahInfo);

        /// adds into de translation array
        calendarInfo?.ayahTranslations.update(
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
        replacedStr = calendarInfo?.ayahOrHadith
            .toString().replaceAll(surahInfoFromIGMG, surahInfo);

        /// adds into ar translation array
        calendarInfo?.ayahTranslations.update(
            'ar', (value) => replacedStr??'',
            ifAbsent: () => replacedStr??''
        );

        /// no replacement needed for tr
        /// adds into tr translation array
        calendarInfo?.ayahTranslations.update(
            'tr', (value) => calendarInfo?.ayahOrHadith??'',
            ifAbsent: () => calendarInfo?.ayahOrHadith??'');

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
        replacedStr = calendarInfo?.ayahTranslations['de']
            .toString().replaceAll(ayahWoQuotationMarks,
            verse.translations?[0].text ??'');
        calendarInfo?.ayahTranslations.update(
            'de', (value) => replacedStr??'',
            ifAbsent: () => replacedStr??''
        );

        /// org Quran ayah from API
        /// adds into translation array
        verse = await HttpService().fetchVerseByKey(
            surahNr: verseKey[0], ayahNr: verseKey[1],
            translation: null, language: 'ar');
        replacedStr = calendarInfo?.ayahTranslations['ar']
            .toString().replaceAll(ayahWoQuotationMarks,
            verse.textImlaei ??'');
        calendarInfo?.ayahTranslations.update(
            'ar', (value) => replacedStr??'',
            ifAbsent: () => replacedStr??''
        );
      }
    }

    if ( matches.isEmpty ){}

    return calendarInfo;
  }

}