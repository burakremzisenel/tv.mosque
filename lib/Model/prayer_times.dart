import 'dart:convert';
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../helper/date_time_tools.dart';
import 'hijri_months.dart';

/*

    <!-- Dialog Actions -->
    <string name="ok">OK</string>
    <string name="yes">Yes</string>
    <string name="no">No</string>
    <string name="cancel">Cancel</string>
    <string name="back">Back</string>
    <string name="finish">Done</string>
    <string name="continue_">Continue</string>

    <string name="mail">E-Mail</string>
    <string name="share">Share</string>
    <string name="refresh">Synchronize</string>
    <string name="language">Language</string>

    <!-- Other -->
    <string name="systemLanguage">System language</string>
    <string name="notification">Notification</string>
    <string name="version">Version</string>
    <string name="search">Search</string>
    <string name="delete">Delete</string>
    <string name="no_internet">No Internet Connection</string>
    <string name="error">An error occurred</string>
 */
enum PrayerTimeType{
  FAJR(0),
  SHURUQ(1),
  DHUHR(2),
  ASR(3),
  MAGHRIB(4),
  ISHAA(5);

  final int value;

  const PrayerTimeType(this.value);

  PrayerTimeType next() {
    final nextIndex = (value + 1) % PrayerTimeType.values.length;
    return PrayerTimeType.values[nextIndex];
  }

  static PrayerTimeType nextEnum(PrayerTimeType pType) {
    final nextIndex = (pType.index + 1) % PrayerTimeType.values.length;
    return PrayerTimeType.values[nextIndex];
  }

  static PrayerTimeType getByValue(int val) {
    for (PrayerTimeType pType in PrayerTimeType.values) {
      if (pType.value == val) return pType;
    }
    return PrayerTimeType.FAJR;
  }
}
class PrayerTimes{
  String cityName;
  DateTime date;
  HijriDate? hijriDate;
  String fajr;
  String shuruq;
  String dhuhr;
  String asr;
  String maghrib;
  String ishaa;

  PrayerTimes({
    required this.cityName,
    required this.date,
    this.hijriDate,
    required this.fajr,
    required this.shuruq,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.ishaa
  });

  factory PrayerTimes.init(){
    return PrayerTimes(
        cityName: '',
        date: DateTime.now(),
        fajr: '00:00',
        shuruq: '00:00',
        dhuhr: '00:00',
        asr: '00:00',
        maghrib: '00:00',
        ishaa: '00:00'
    );
  }

  PrayerTimeType getCurrPrayerTime() {
    DateTime dateTime = DateTime.now();
    Duration now = Duration(hours: dateTime.hour, minutes: dateTime.minute);
    // check ISHAA
    PrayerTimeType prayerTimeType = PrayerTimeType.ISHAA;
    if ( now.compareTo(getPrayerTimeAsDuration(prayerTimeType)) < 0) {
      // now < ISHAA
      // check MAGHRIB
      prayerTimeType = PrayerTimeType.MAGHRIB;
      if ( now.compareTo(getPrayerTimeAsDuration(prayerTimeType)) < 0) {
        // now < MAGHRIB
        // check ASR
        prayerTimeType = PrayerTimeType.ASR;
        if ( now.compareTo(getPrayerTimeAsDuration(prayerTimeType)) < 0) {
          // now < ASR
          // check DHUHR
          prayerTimeType = PrayerTimeType.DHUHR;
          if ( now.compareTo(getPrayerTimeAsDuration(prayerTimeType)) < 0) {
            // now < DHUHR
            // check SHURUQ
            prayerTimeType = PrayerTimeType.SHURUQ;
            if ( now.compareTo(getPrayerTimeAsDuration(prayerTimeType)) < 0) {
              // check FAJR
              prayerTimeType = PrayerTimeType.FAJR;

              if ( now.compareTo(getPrayerTimeAsDuration(prayerTimeType)) < 0) {
                prayerTimeType = PrayerTimeType.ISHAA;
              }
            }
          }
        }
      }
    }
    return prayerTimeType;
  }
  bool isFAJR(){
    return getCurrPrayerTime() == PrayerTimeType.FAJR;
  }
  bool isSHURUQ(){
    return getCurrPrayerTime() == PrayerTimeType.SHURUQ;
  }
  bool isDHUHR(){
    return getCurrPrayerTime() == PrayerTimeType.DHUHR;
  }
  bool isASR(){
    return getCurrPrayerTime() == PrayerTimeType.ASR;
  }
  bool isMAGHRIB(){
    return getCurrPrayerTime() == PrayerTimeType.MAGHRIB;
  }
  bool isISHAA(){
    return getCurrPrayerTime() == PrayerTimeType.ISHAA;
  }
  bool isCurrentPrayerTime(PrayerTimeType pType){
    return (getCurrPrayerTime() == pType && pType != PrayerTimeType.SHURUQ);
  }

  PrayerTimeType getNextPrayerTime() {
    return getCurrPrayerTime().next();
  }

  String prayerTimesEndsIn({bool wSeconds = false}){
    return printDuration(currPrayerTimeEndsIn(), withSeconds: wSeconds);
  }

  Duration currPrayerTimeEndsIn() {
    if(cityName.isEmpty) return const Duration(seconds: 60);
    int nextPrayerTimeInSeconds = nextPrayerTimeAsDuration().inSeconds;
    int diff = nextPrayerTimeInSeconds - currTimeToDuration().inSeconds;
    if ( diff < 0 ) diff += 24*60*60;
    return Duration(seconds: diff);
  }

  Duration nextPrayerTimeAsDuration(){
    return getPrayerTimeAsDuration(getNextPrayerTime());
  }

  Duration currPrayerTimeAsDuration(){
    return getPrayerTimeAsDuration(getCurrPrayerTime());
  }

  Duration currTimeToDuration() {
    DateTime now = DateTime.now();
    return Duration(hours: now.hour, minutes: now.minute, seconds: now.second);
  }

  Duration getPrayerTimeAsDuration(PrayerTimeType pType) {
    List<String> parts = getPrayerTime(pType).split(':');
    return Duration(hours: int.parse(parts[0]), minutes: int.parse(parts[1]));
  }

  String humanReadableDuration(PrayerTimeType pType){
    return printDuration(getPrayerTimeAsDuration(pType));
  }

  String getPrayerTime(PrayerTimeType pType) {
    switch( pType ){
      case PrayerTimeType.FAJR:
        return fajr;
      case PrayerTimeType.SHURUQ:
        return shuruq;
      case PrayerTimeType.DHUHR:
        return dhuhr;
      case PrayerTimeType.ASR:
        return asr;
      case PrayerTimeType.MAGHRIB:
        return maghrib;
      case PrayerTimeType.ISHAA:
        return ishaa;
    }
  }

  static List<PrayerTimes> parsePrayerTimes(Map<String, dynamic> resp) {
    return resp["list"].map<PrayerTimes>((json) =>
        PrayerTimes.fromJson(json)).toList();
  }
  factory PrayerTimes.fromJson(Map<String, dynamic> json) => PrayerTimes(
    cityName: json["cityName"],
    date: DateFormat('dd.MM.yyyy').parse(json["date"]),
    fajr: json["fajr"],
    shuruq: json["sunrise"],
    dhuhr: json["dhuhr"],
    asr: json["asr"],
    maghrib: json["maghrib"],
    ishaa: json["ishaa"]
  );
  factory PrayerTimes.fromBuffer(Map<String, dynamic> json) => PrayerTimes(
      cityName: json["cityName"],
      date: DateTime.parse(json["date"]).toLocal(),
      hijriDate: HijriDate.fromBuffer(json["hijriDate"]),
      fajr: json["fajr"],
      shuruq: json["sunrise"],
      dhuhr: json["dhuhr"],
      asr: json["asr"],
      maghrib: json["maghrib"],
      ishaa: json["ishaa"]
  );

  Map<String, dynamic> toJson() => {
    "cityName": cityName,
    "date": date.toUtc().toIso8601String(),
    "hijriDate": hijriDate?.toJson(),
    "fajr": fajr,
    "sunrise": shuruq,
    "dhuhr": dhuhr,
    "asr": asr,
    "maghrib": maghrib,
    "ishaa": ishaa,
  };
}