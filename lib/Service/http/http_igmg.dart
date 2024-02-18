part of 'http_service.dart';

extension IGMGAPI on HttpService{
  /// Gebetszeiten
  Future<PrayerTimes?> fetchPrayerTimes(DateTime dateTime) async {
    var response = await dio?.get(
        '${settings?.igmgApi}/GetPrayerTimes',
        queryParameters: {
          'cityID': '20015',
          'locale': 'de',
          'from': DateFormat("dd.MM.yyyy").format(dateTime)
        },
        options: Options(
            headers: {"X-API-Key": settings?.igmgApiKey}
        )
    );

    return PrayerTimes.parsePrayerTimes(response?.data).firstOrNull;
  }

  /// Hijri-Jahr
  Future<String?> fetchHijriYear() async{
    var response = await dio?.get(
        '${settings?.igmgApi}/GetHijriYearData',
        options: Options(
            headers: {"X-API-Key": settings?.igmgApiKey}
        )
    );

    return response?.data['asHijriDate'];

    //print('Hicri: ' + response.data['asHijriDate']);
    //print('Miladi: ' + response.data['sampleGregDate']);
  }

  /// Calendar info
  Future<CalendarInfo?> fetchCalendarInfo(DateTime dateTime) async {
    var response = await dio?.get(
        '${settings?.igmgApi}/GetCalendarInfo',
        queryParameters: {
          'date': DateFormat("dd.MM.yyyy").format(dateTime)
        },
        options: Options(
            headers: {"X-API-Key": settings?.igmgApiKey}
        )
    );

    return CalendarInfo.fromJson(response?.data['notes']);
  }
}