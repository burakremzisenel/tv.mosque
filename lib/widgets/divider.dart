import 'package:flutter/material.dart';

Widget verticalDivider(){
  return SizedBox(
    width: 2,
    child: Center(
      child: Container(
        width: 2,
        margin: const EdgeInsetsDirectional.only(top: 15, bottom: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          gradient:
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.white10,
                Colors.amber,
                Colors.white10,
              ]
          ),
        ),
      ),
    ),
  );
}

Widget horizontalDivider(){
  return SizedBox(
    height: 12,
    child: Center(
      child: Container(
        height: 2,
        margin: const EdgeInsetsDirectional.only(start: 30, end: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Colors.white10,
                Colors.amber,
                Colors.white10,
              ]
          ),
        ),
      ),
    ),
  );
}