part of 'http_service.dart';

extension IGMGAPI on HttpService{
  /// Prayer times
  Future<PrayerTimes> fetchPrayerTimes(DateTime dateTime, {
    required String locale,
    required int cityID
  }) async {

    /// Cache Options
    Options? options = cacheOptions?.copyWith(
        policy: CachePolicy.forceCache,
        maxStale: const Nullable<Duration>(Duration(hours: 24))
    ).toOptions();
    options?.headers =  {
      "X-API-Key": settings?.igmgApiKey,
      "Content-Type": "application/json",
    };
    options?.responseType = ResponseType.json;

    /// HTTP GET
    var response = await dio?.get(
        '${settings?.igmgApi}/GetPrayerTimes?'
            'from=${DateFormat("dd.MM.yyyy").format(dateTime)}'
            '&cityID=$cityID'
            '&locale=$locale',
        options: options
    );

    return PrayerTimes.parsePrayerTimes(response?.data).first;
  }

  /// Calendar info
  Future<CalendarInfo?> fetchCalendarInfo(DateTime dateTime) async {
    /// Cache Options
    Options? options = cacheOptions?.copyWith(
        policy: CachePolicy.forceCache,
        maxStale: const Nullable<Duration>(Duration(hours: 24))
    ).toOptions();
    options?.headers =  {
      "X-API-Key": settings?.igmgApiKey,
      "Content-Type": "application/json",
    };
    options?.responseType = ResponseType.json;
    options?.receiveTimeout = const Duration(seconds: 10);

    /// HTTP GET
    var response = await dio?.get(
        '${settings?.igmgApi}/GetCalendarInfo?'
            'date=${DateFormat("dd.MM.yyyy").format(dateTime)}',
        options: options
    );

    return CalendarInfo.fromJson(response?.data['notes']);
  }
}