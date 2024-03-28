import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_mosque/helper/date_time_tools.dart';

const String lastCheckedAt = "date";

/// clears last fetched date time of prayer times
Future clearLastFetchedTime() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey(lastCheckedAt)) {
    await prefs.remove(lastCheckedAt);
  }
}
/// sets last fetched date time of prayer times
Future setLastFetchedAt() async{
  String nowIsoString = DateTime.now().toUtc().toIso8601String();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(lastCheckedAt, nowIsoString);
}
// checks, if prayer times was fetched today
Future<bool> wasPrayerTimesFetchedToday() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String dateStrFromBuffer = prefs.getString(lastCheckedAt) ??'';
  if (dateStrFromBuffer.isNotEmpty) {
    // check if new day
    DateTime dateTimeFromBuffer = DateTime
        .parse(dateStrFromBuffer).toLocal();
    DateTime now = DateTime.now();
    return isSameDay(now, dateTimeFromBuffer);
  }
  return false;
}

enum BufferTypes{
  prayerTimes("PRY"),
  calInfo("CAL"),
  countries("CNT"),
  settings("SET");

  final String buffer;
  const BufferTypes(this.buffer);
}
Future saveToBuffer(BufferTypes key, value) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key.buffer, json.encode(value));
}
Future readFromBuffer(BufferTypes key) async {
  final prefs = await SharedPreferences.getInstance();
  return json.decode(prefs.getString(key.buffer) ??'{}');
}