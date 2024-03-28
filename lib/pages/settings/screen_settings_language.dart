
import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

import '../../Logic/Provider/provider_settings.dart';
import '../../widgets/dropdown_country_selector.dart';
import '../../widgets/dropdown_location_selector.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ps.dart';
import 'package:iconify_flutter/icons/mdi.dart';

@RoutePage()
class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => LanguageSettingsPageState();
}

class LanguageSettingsPageState extends State<LanguageSettingsPage> {
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
                title: Text('Land & Sprache'),
              ),

              body: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      /// Dropdown Country
                      ListTile(
                        title: Text('Land'),
                        leading: Iconify(Ps.world, color: Colors.black87),
                        subtitle: Column(
                          children: [
                            DropDownCountrySelector(),
                            // spacer
                            SizedBox(height: 15)
                          ],
                        ),
                      ),

                      /// Dropdown City
                      ListTile(
                        title: Text('City'),
                        leading: Iconify(Mdi.home_city_outline, color: Colors.black87),
                        subtitle: Column(
                          children: [
                            DropDownLocationSelector(),
                            // spacer
                            SizedBox(height: 15)
                          ],
                        ),
                      ),

                      /// Language toggle duration title
                      ListTile(
                        title: Text('language_timer_desc'.tr()),
                        //subtitle: Text('language_timer_desc'.tr(),softWrap: true,),
                      ),

                      /// Buttons increase decrease
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Decrease button
                          ElevatedButton(
                            onPressed: () => provider.decLangTimer(),
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(24),
                                elevation: 0
                            ),
                            child: const Text('-',  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                          ),

                          /// Current value
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(
                              child: Text(
                                  '${provider.languageToggleTimer}',
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
                              ),
                            ),
                          ),

                          /// Increase button
                          ElevatedButton(
                              onPressed: () => provider.incLangTimer(),
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(24),
                                  elevation: 0
                              ),
                              child: const Text('+',style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ),
          );
        }
      ),
    );
  }
}