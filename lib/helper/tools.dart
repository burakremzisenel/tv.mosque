import 'dart:typed_data';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String obfuscateMail(String string, {int level = 2}) {
  final parts = string.split("@");
  if (parts.length != 2) {
    // Handle the case where there is no "@" separator in the string
    return string;
  }
  final stringBeforeA = parts[0];
  final stringAfterA = parts[1];
  var unconsoredBeforeA = stringBeforeA;
  if(stringBeforeA.length > level * 2){
    unconsoredBeforeA = stringBeforeA.replaceRange(
        level, stringBeforeA.length - level, "*" * (stringBeforeA.length - level * 2));
  }
  return "$unconsoredBeforeA@$stringAfterA";
}
isNumeric(string) => num.tryParse(string) != null;
isInt(string) => int.tryParse(string) != null;
/*
Future<MemoryImage> svgStrToMemoryimage(String svgString) async{
  final svgDrawableRoot = await vg.loadPicture(SvgStringLoader(svgString), null);
  final image = await svgDrawableRoot.picture.toImage(200,200);
  ByteData? bytes = await image.toByteData(format: ImageByteFormat.png);
  if (bytes == null) {
    return Future.error('error');
  }
  return MemoryImage(bytes.buffer.asUint8List());
}

 */

String parseDateJM(DateTime dateTime){
  final chunks = DateFormat.Hm().format(dateTime).split(':');
  return '${chunks[0]}:${chunks[1]}';
}