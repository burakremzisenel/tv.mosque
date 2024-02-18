import 'package:flutter/material.dart';

extension Data on Map<String, TextEditingController> {
  Map<String, dynamic> data() {
    final res = <String, dynamic>{};
    for (MapEntry e in entries) {
      res.putIfAbsent(e.key, () => e.value?.text);
    }
    return res;
  }
}
extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}
extension IterableExtensions<T> on Iterable<T>{
  List<T> joinWith<T>(T separator){
    if (length == 0) return [];
    if (length == 1) return List<T>.from(this);
    return List<T>.from(map((current) => [
      current,
      separator,
    ]).expand((w) => w))..removeLast();
  }
}