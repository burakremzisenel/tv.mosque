import 'package:easy_localization/easy_localization.dart';

enum HijriMonths{
  MUHARRAM(1),
  SAFAR(2),
  RABI_AL_AWWAL(3),
  RABI_AL_THANI(4),
  JUMADA_AL_AWWAL(5),
  JUMADA_AL_THANI(6),
  RAJAB(7),
  SHABAN(8),
  RAMADAN(9),
  SHAWWAL(10),
  DHUL_QADAH(11),
  DHUL_HIJJAH(12);

  final int value;

  const HijriMonths(this.value);

  static HijriMonths? getByMonth(int month) {
    for (HijriMonths hMonth in HijriMonths.values) {
      if (hMonth.value == month) return hMonth;
    }

    return null;
  }
}

class HijriDate{
  final String hDate;
  const HijriDate({required this.hDate});

  List<String> convert() {
    if (hDate.isEmpty) return [];
    List<String> chunks = hDate.split('.');
    HijriMonths hMonth = HijriMonths.getByMonth(int.parse(chunks[1]))
        ??HijriMonths.RAMADAN;
    return [chunks[0], 'hijriMonth'.tr(gender: hMonth.name), chunks[2]];
  }

  factory HijriDate.fromBuffer(Map<String, dynamic> json) =>
      HijriDate(
        hDate: json["hDate"],
      );
  Map<String, dynamic> toJson() => {
    "hDate": hDate,
  };
}