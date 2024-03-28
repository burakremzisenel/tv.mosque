import 'package:auto_route/annotations.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ps.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../../Logic/Provider/provider_settings.dart';
import '../../widgets/dropdown_country_selector.dart';
import '../../widgets/dropdown_location_selector.dart';

@RoutePage()
class PrayerTimesSettingsPage extends StatefulWidget {
  const PrayerTimesSettingsPage({super.key});

  @override
  State<PrayerTimesSettingsPage> createState() => PrayerTimesSettingsPageState();
}

class PrayerTimesSettingsPageState extends State<PrayerTimesSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,

        child: Consumer<SettingsProvider>(
          builder: (context, provider, child) {
            return RotatedBox(
              quarterTurns: provider.isLandscape? 0 :1,
                child: Scaffold(
                  backgroundColor: CupertinoColors.lightBackgroundGray,

                  appBar: AppBar(
                    title: Text('Prayer Times'),
                  ),

                  body: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                          ]
                      )
                    ),
                  )
                )
            );
          },
        ),
    );
  }
}
