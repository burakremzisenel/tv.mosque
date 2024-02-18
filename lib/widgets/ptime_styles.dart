
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle styleOfPTimeTitle(bool isCurrentTime) {
  return TextStyle(
      fontSize: 30,
      color: isCurrentTime ? Colors.amber : Colors.lime,
      fontWeight: isCurrentTime ? FontWeight.bold : FontWeight.normal);
}

TextStyle styleOfPTimeDuration(bool isCurrentTime) {
  return TextStyle(
      fontSize: 50,
      color: isCurrentTime ? Colors.amber : Colors.white,
      fontWeight: isCurrentTime ? FontWeight.bold : FontWeight.normal);
}