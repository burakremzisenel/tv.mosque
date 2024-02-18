import 'package:flutter/cupertino.dart';

/// Formats Duration
/// ex. 00:53
String printDuration(Duration duration, {bool withSeconds = false}) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes${withSeconds? ':$twoDigitSeconds':''}";
}

/// compares equality of given two days
bool isSameDay(DateTime? dateA, DateTime? dateB) {
return dateA?.year == dateB?.year &&
dateA?.month == dateB?.month &&
dateA?.day == dateB?.day;
}

int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }
  const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  return daysInMonth[month - 1];
}